> ZeroMQ是一个消息队列网络库，实现网络常用技术封装。在C/S中实现了三种模式，这段时间用python简单实现了一下，感觉python虽然灵活。但是数据处理不如C++自由灵活。

 

# 1.Request-Reply模式：

客户端在请求后，服务端必须回响应

> server：
```
server：


 #!/usr/bin/python
 #-*-coding:utf-8-*-
 import time
 import zmq
 
 context = zmq.Context()
 socket = context.socket(zmq.REP)
 socket.bind("tcp://*:5555")
 
 while True:
     message = socket.recv()
     print message
     #time.sleep(1)
     socket.send("server response!")
```
> client：
```
client：


 #!/usr/bin/python
 #-*-coding:utf-8-*-
 
 import zmq
 import sys
 
 context = zmq.Context()
 socket = context.socket(zmq.REQ)
 socket.connect("tcp://localhost:5555")
 
 while(True):
     data = raw_input("input your data:")
     if data == 'q':
         sys.exit()
 
     socket.send(data.encode('utf-8'))
 
     response = socket.recv();
     print response
```
 

# 2.Publish-Subscribe模式:

广播所有client，没有队列缓存，断开连接数据将永远丢失。client可以进行数据过滤。

> server：
```
server：

 #!/usr/bin/python
 #-*-coding:utf-8-*-
 
 import zmq 
 context = zmq.Context()  
 socket = context.socket(zmq.PUB)  
 socket.bind("tcp://127.0.0.1:5000")  
 while True:  
     msg = raw_input('input your data:') 
     socket.send(msg.encode('utf-8'))
```
> client：
```
client：

 #!/usr/bin/python
 #-*-coding:utf-8-*-
 
 import time
 import zmq  
 context = zmq.Context()  
 socket = context.socket(zmq.SUB)  
 socket.connect("tcp://127.0.0.1:5000")  
 socket.setsockopt(zmq.SUBSCRIBE,'') 
 while True:  
     print  socket.recv() 
```
 

# 3.Parallel Pipeline模式：

由三部分组成，push进行数据推送，work进行数据缓存，pull进行数据竞争获取处理。区别于Publish-Subscribe存在一个数据缓存和处理负载。

当连接被断开，数据不会丢失，重连后数据继续发送到对端。
> server：
```
server：

 #!/usr/bin/python
 #-*-coding:utf-8-*-
 
 import zmq
 
 context = zmq.Context()
 
 socket = context.socket(zmq.PULL)
 socket.bind('tcp://*:5558')
 
 while True:
     data = socket.recv()
     print data
```
> work：
```
work：

 #!/usr/bin/python
 #-*-coding:utf-8-*-
 
 import zmq
 
 context = zmq.Context()
 
 recive = context.socket(zmq.PULL)
 recive.connect('tcp://127.0.0.1:5557')
 
 sender = context.socket(zmq.PUSH)
 sender.connect('tcp://127.0.0.1:5558')
 
 while True:
     data = recive.recv()
     sender.send(data)
```
> client：
```
client：

 #!/usr/bin/python
 #-*-coding:utf-8-*-
 
 import zmq
 import time

 context = zmq.Context()
 socket = context.socket(zmq.PUSH)
 
 socket.bind('tcp://*:5557')
 
 while True:
     data = raw_input('input your data:')
     socket.send(data.encode('utf-8'))
```
 

消息结构：
在每个消息buff前均会自带一个buff长度

# Protobuf序列化与反序列化
## 1.初始化
set_xxx()设置required,optional字段值
add_xxx()添加repeated字段值
set_xxx(int,x)设置repeated中元素的值
## 2.序列化
```
required字段需要初始化,可以通过IsInitialized来检查是否完成message对象的初始化
SerializedAsString(),SerializedToString(std::string*)序列化为std::string
SerializedToArray(void*,int)序列化为byte数组
SerializedToOstream(ostream*)序列化到输出流
ByteSize()获取二进制字节序的大小，可用于初始化存放容器
```
## 3.反序列化
```
ParseFromString(std::string& data)从字符串中反序列化
ParseFromArray(const void *,int)从字节序中反序列化
ParseFromIstream(istream*)从输入流中反序列化
has_xxx()用于检查相应字段是否存在数据
xxx_size()用于确定repeated字段是否存在，0表示未序列化
```
## 4.获取对象
```
xxx()返回required/optional字段的const值,只读模式，返回repeated列表的指针,用于修改
mutable_xxx()返回字段指针,用于修改
xxx(int)返回repeated字段列表的元素,只读
protobuf实现原理
```
# protobuf的cache机制
* protobuf message的clear()操作是存在cache机制的，它并不会释放申请的空间，这导致占用的空间越来越大。
* 如果程序中protobuf message占用的空间变化很大，那么最好每次或定期进行清理。这样可以避免内存不断的上涨。
> 注意事项
嵌套定义时，被嵌套的结构体被解析成A_B形式,需要获取mutable_b()指针来初始化该字段,使用栈上的对象会导致程序异常
应用程序中使用protobuf,需要在退出程序时调用google::protobuf::ShutdownProtobufLibrary()以清理内存,否则会造成内存泄漏
