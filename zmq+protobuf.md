# zmq资料
[zmq资料](https://github.com/futurepw/paper/blob/master/zmq.md)
# protobuf资料
[protobuf配置资料](https://github.com/futurepw/paper/blob/master/protobuf.md)
[protobuf语法资料](https://github.com/futurepw/paper/blob/master/protobuf%E8%AF%AD%E6%B3%95%E6%8C%87%E5%8D%97.md)
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
