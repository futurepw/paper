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
