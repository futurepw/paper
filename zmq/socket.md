# Python Socket学习

Python在网络通讯方面功能强大，学习一下Socket通讯的基本方式

> UDP通讯：

## Server:

```
import socket
port=8081
s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
#从指定的端口，从任何发送者，接收UDP数据
s.bind(('',port))
print('正在等待接入...')
while True:
    #接收一个数据
    data,addr=s.recvfrom(1024)
    print('Received:',data,'from',addr)
```
## Client:
```
import socket
port=8081
host='localhost'
s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
s.sendto(b'hello,this is a test info !',(host,port))
```
> 下面是TCP方式：

## Server:

```
#-*- coding: utf-8 -*-
from socket import *
from time import ctime

HOST=''
PORT=12345
BUFSIZ=1024
ADDR=(HOST, PORT)
sock=socket(AF_INET, SOCK_STREAM)

sock.bind(ADDR)

sock.listen(5)
while True:
    print('waiting for connection')
    tcpClientSock, addr=sock.accept()
    print('connect from ', addr)
    while True:
        try:
            data=tcpClientSock.recv(BUFSIZ)
        except:
            print(e)
            tcpClientSock.close()
            break
        if not data:
            break
        s='Hi,you send me :[%s] %s' %(ctime(), data.decode('utf8'))
        tcpClientSock.send(s.encode('utf8'))
        print([ctime()], ':', data.decode('utf8'))
tcpClientSock.close()
sock.close()
```
## Client:

```
#-*- coding: utf-8 -*-
from socket import *

class TcpClient:
    HOST='127.0.0.1'
    PORT=12345
    BUFSIZ=1024
    ADDR=(HOST, PORT)
    def __init__(self):
        self.client=socket(AF_INET, SOCK_STREAM)
        self.client.connect(self.ADDR)

        while True:
            data=input('>')
            if not data:
                break
            self.client.send(data.encode('utf8'))
            data=self.client.recv(self.BUFSIZ)
            if not data:
                break
            print(data.decode('utf8'))
            
if __name__ == '__main__':
    client=TcpClient()
```
> 上面的TCP方式有个问题，不能退出，好吧，我们改造一下，使这个程序可以发送quit命令以退出：

## Server:
```
#-*- coding: utf-8 -*-
from socket import *
from time import ctime
from time import localtime
import time

HOST=''
PORT=1122  #设置侦听端口
BUFSIZ=1024
ADDR=(HOST, PORT)
sock=socket(AF_INET, SOCK_STREAM)

sock.bind(ADDR)

sock.listen(5)
#设置退出条件
STOP_CHAT=False
while not STOP_CHAT:
    print('等待接入，侦听端口:%d' % (PORT))
    tcpClientSock, addr=sock.accept()
    print('接受连接，客户端地址：',addr)
    while True:
        try:
            data=tcpClientSock.recv(BUFSIZ)
        except:
            #print(e)
            tcpClientSock.close()
            break
        if not data:
            break
        #python3使用bytes，所以要进行编码
        #s='%s发送给我的信息是:[%s] %s' %(addr[0],ctime(), data.decode('utf8'))
        #对日期进行一下格式化
        ISOTIMEFORMAT='%Y-%m-%d %X'
        stime=time.strftime(ISOTIMEFORMAT, localtime())
        s='%s发送给我的信息是:%s' %(addr[0],data.decode('utf8'))
        tcpClientSock.send(s.encode('utf8'))
        print([stime], ':', data.decode('utf8'))
        #如果输入quit(忽略大小写),则程序退出
        STOP_CHAT=(data.decode('utf8').upper()=="QUIT")
        if STOP_CHAT:
            break
tcpClientSock.close()
sock.close()
```
## Client:
```
#-*- coding: utf-8 -*-
from socket import *

class TcpClient:
    #测试，连接本机
    HOST='127.0.0.1'
    #设置侦听端口
    PORT=1122 
    BUFSIZ=1024
    ADDR=(HOST, PORT)
    def __init__(self):
        self.client=socket(AF_INET, SOCK_STREAM)
        self.client.connect(self.ADDR)

        while True:
            data=input('>')
            if not data:
                break
            #python3传递的是bytes，所以要编码
            self.client.send(data.encode('utf8'))
            print('发送信息到%s：%s' %(self.HOST,data))
            if data.upper()=="QUIT":
                break            
            data=self.client.recv(self.BUFSIZ)
            if not data:
                break
            print('从%s收到信息：%s' %(self.HOST,data.decode('utf8')))
            
            
if __name__ == '__main__':
    client=TcpClient()
```
