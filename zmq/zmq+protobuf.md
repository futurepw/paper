# zmq资料
[zmq资料](https://github.com/futurepw/paper/blob/master/zmq/zmq.md)
# protobuf资料
[protobuf配置资料](https://github.com/futurepw/paper/blob/master/zmq/protobuf.md)<br>
[protobuf语法资料](https://github.com/futurepw/paper/blob/master/zmq/protobuf%E8%AF%AD%E6%B3%95%E6%8C%87%E5%8D%97.md)
# 测试代码
## 测试中的错误
> 报No module named google.protobuf 错误

这是因为安装Google.protobuf后还要在重新配置Python，配置如下：
```
/home/peiwei/protobuf-2.4.1/python
python setup.py build
python setup.py install
cd /usr/local/lib/python2.7/site-packages
chmod -R 755 *
```
## server
> SerializeToString()函数是将对象序列化 ParseFromString()函数是将序列化的对象反序列化
```
#!/usr/bin/python
#-*-coding:utf-8-*-
# peiwei
import time
import zmq
import addressbook_pb2

context = zmq.Context()
socket = context.socket(zmq.REP)
socket.bind("tcp://*:5555")

person = addressbook_pb2.Person()
person.id = 1455
person.name = "peiwei"
person.email = "pei@example.com"
phone = person.phone.add()
phone.number = "1234-567"
phone.type = addressbook_pb2.Person.HOME

people = addressbook_pb2.Person()
while True:
     message = socket.recv()
     people.ParseFromString(message)
     print people
     #time.sleep(1)
     socket.send(person.SerializeToString())

```
## client
```
#!/usr/bin/python
#-*-coding:utf-8-*-
# peiwei
import addressbook_pb2
import zmq
import sys

context = zmq.Context()
socket = context.socket(zmq.REQ)
socket.connect("tcp://123.206.206.174:5555")

person = addressbook_pb2.Person()
person.id = 1234
person.name = "peiwei"
person.email = "peiwei@example.com"
phone = person.phone.add()
phone.number = "555-4321"
phone.type = addressbook_pb2.Person.HOME

people = addressbook_pb2.Person()
while(True):
    socket.send(person.SerializeToString())
    response = socket.recv()
    people.ParseFromString(response)
    print people

```



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
