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
# Python 提供了两个基本的 socket 模块。
   ## 第一个是 Socket，它提供了标准的 BSD Sockets API。
   ## 第二个是 SocketServer， 它提供了服务器中心类，可以简化网络服务器的开发。
> 1、Socket 类型
```
套接字格式：
socket(family,type[,protocal]) 使用给定的地址族、套接字类型、协议编号（默认为0）来创建套接字。
socket类型                描述
socket.AF_UNIX            只能够用于单一的Unix系统进程间通信
socket.AF_INET            服务器之间网络通信
socket.AF_INET6           IPv6
socket.SOCK_STREAM        流式socket , for TCP
socket.SOCK_DGRAM         数据报式socket , for UDP
socket.SOCK_RAW           原始套接字，普通的套接字无法处理ICMP、IGMP等网络报文，而SOCK_RAW可以；
                          其次，SOCK_RAW也可以处理特殊的IPv4报文；此外，利用原始套接字，可以通过
                          IP_HDRINCL套接字选项由用户构造IP头。
socket.SOCK_SEQPACKET     可靠的连续数据包服务
创建TCP Socket：           s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
创建UDP Socket：           s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
```
> 2、Socket 函数
    >> 注意点:
* 1）TCP发送数据时，已建立好TCP连接，所以不需要指定地址。UDP是面向无连接的，每次发送要指定是发给谁。
* 2）服务端与客户端不能直接发送列表，元组，字典。需要字符串化repr(data)。
```
socket函数                 描述

服务端socket函数
s.bind(address)                             将套接字绑定到地址, 在AF_INET下,以元组（host,port）的形式表示地址.
s.listen(backlog)                           开始监听TCP传入连接。backlog指定在拒绝连接之前，操作系统可以挂起的最大连接数量。
                                            该值至少为1，大部分应用程序设为5就可以了。
s.accept()                                  接受TCP连接并返回（conn,address）,其中conn是新的套接字对象，可以用来接收和发送数                                               据。address是连接客户端的地址。
                           
客户端socket函数
s.connect(address)                          连接到address处的套接字。一般address的格式为元组（hostname,port），
                                            如果连接出错，返回socket.error错误。
s.connect_ex(adddress)                      功能与connect(address)相同，但是成功返回0，失败返回errno的值。

公共socket函数
s.recv(bufsize[,flag])                      接受TCP套接字的数据。数据以字符串形式返回，bufsize指定要接收的最大数据量。
                                            flag提供有关消息的其他信息，通常可以忽略。
s.send(string[,flag])                       发送TCP数据。将string中的数据发送到连接的套接字。返回值是要发送的字节数量，
                                            该数量可能小于string的字节大小。
s.sendall(string[,flag])                    完整发送TCP数据。将string中的数据发送到连接的套接字，但在返回之前会尝试发送所有数                                               据。成功返回None，失败则抛出异常。
s.recvfrom(bufsize[.flag])                  接受UDP套接字的数据。与recv()类似，但返回值是（data,address）。
                                            其中data是包含接收数据的字符串，address是发送数据的套接字地址。
s.sendto(string[,flag],address)             发送UDP数据。将数据发送到套接字，address是形式为（ipaddr，port）的元组，
                                            指定远程地址。返回值是发送的字节数。
s.close()                                   关闭套接字。
s.getpeername()                             返回连接套接字的远程地址。返回值通常是元组（ipaddr,port）。
s.getsockname()                             返回套接字自己的地址。通常是一个元组(ipaddr,port)
s.setsockopt(level,optname,value)           设置给定套接字选项的值。
s.getsockopt(level,optname[.buflen])        返回套接字选项的值。
s.settimeout(timeout)                       设置套接字操作的超时期，timeout是一个浮点数，单位是秒。
                                            值为None表示没有超时期。一般，超时期应该在刚创建套接字时设置，
                                            因为它们可能用于连接的操作（如connect()）
s.gettimeout()                              返回当前超时期的值，单位是秒，如果没有设置超时期，则返回None。
s.fileno()                                  返回套接字的文件描述符。
s.setblocking(flag)                         如果flag为0，则将套接字设为非阻塞模式，否则将套接字设为阻塞模式（默认值）。
                                            非阻塞模式下，如果调用recv()没有发现任何数据，或send()调用无法立即发送数据，
                                            那么将引起socket.error异常。
s.makefile()                                创建一个与该套接字相关连的文件
```
> 3、socket编程思路
    >> TCP服务端：
```
1 创建套接字，绑定套接字到本地IP与端口
   # socket.socket(socket.AF_INET,socket.SOCK_STREAM) , s.bind()
2 开始监听连接                   #s.listen()
3 进入循环，不断接受客户端的连接请求              #s.accept()
4 然后接收传来的数据，并发送给对方数据         #s.recv() , s.sendall()
5 传输完毕后，关闭套接字                     #s.close()
```
    >> TCP客户端:
```
1 创建套接字，连接远端地址
       # socket.socket(socket.AF_INET,socket.SOCK_STREAM) , s.connect()
2 连接后发送数据和接收数据          # s.sendall(), s.recv()
3 传输完毕后，关闭套接字          #s.close()
```
