# zmq资料
[zmq资料]()
# protobuf资料
[protobuf资料]()
# 测试代码
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
