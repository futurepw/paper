# protobuf
## protobuf的优点：
* 1 性能好/效率高,时间开销:XML格式化（序列化）的开销还好；但是XML解析（反序列化）的开销就不敢恭维了。 但是protobuf在这个方面就进行了优化。可以使序列化和反序列化的时间开销都减短。空间开销：也减少了很多
* 2 有代码生成机制
* 3 支持向后兼容和向前兼容,当客户端和服务器同事使用一块协议的时候，当客户端在协议中增加一个字节，并不会影响客户端的使用
* 4 支持多种编程语言
## protobuf的缺陷
* 1 二进制格式导致可读性差,为了提高性能，protobuf采用了二进制格式进行编码。这直接导致了可读性差。
* 2 缺乏自描述,一般来说，XML是自描述的，而protobuf格式则不是。 给你一段二进制格式的协议内容，不配合你写的结构体是看不出来什么作用的。

# 安装
> 说明： 
protobuf已经全面迁移到[github](https://github.com/google/protobuf) 
[下载地址](https://github.com/google/protobuf/releases)
```
$wget https://github.com/google/protobuf/archive/v2.6.1.zip
$unzip protobuf-2.6.1.zip
$cd protobuf-2.6.1

下载自github的代码需要首先执行 $ ./autogen.sh 生成configure文件

$ ./configure
$ make
$ make install

修改安装路径（非root用户需要修改安装路径）：

protobuf默认安装在 /usr/local 目录
你可以修改安装目录通过 ./configure --prefix=命令
虽然我是root用户但觉得默认安装过于分散，所以统一安装在/home/peiwei/protobuf下

$./configure --prefix=/home/peiwei/protobuf
$ make
$ make install

到此步还没有安装完毕，在/etc/profile 或者用户目录 ~/.bashrc
添加下面内容
####### add protobuf lib path ########
#(动态库搜索路径) 程序加载运行期间查找动态链接库时指定除了系统默认路径之外的其他路径
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/peiwei/protobuf/lib/
#(静态库搜索路径) 程序编译期间查找动态链接库时指定查找共享库的路径
export LIBRARY_PATH=$LIBRARY_PATH:/home/peiwei/protobuf/lib/
#执行程序搜索路径
export PATH=$PATH:/home/peiwei/protobuf/bin/
#c程序头文件搜索路径
export C_INCLUDE_PATH=$C_INCLUDE_PATH:/home/peiwei/protobuf/include/
#c++程序头文件搜索路径
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/home/peiwei/protobuf/include/
#pkg-config 路径
export PKG_CONFIG_PATH=/home/peiwei/protobuf/lib/pkgconfig/
######################################

如果出现找不到符号和链接错误请记得加上链接选项 -lprotobuf 
并确认你的静态库路径是否生效了 
echo $LIBRARY_PATH

```
# .proto文件
　　.proto文件是protobuf一个重要的文件，它定义了需要序列化数据的结构。使用protobuf的3个步骤是：

* 在.proto文件中定义消息格式

* 用protobuf编译器编译.proto文件

* 用C++/Java等对应的protobuf API来写或者读消息
为了创建你的“地址簿”应用，你会用到一个.proto文件。这是一个很简单的.proto文件定义：你可以为你想序列化的数据结构添加一条Message，然后在Message中为每个字段指定一个名称和一个类型。以下是你想为你的Message定义的.proto文件，addressbook.proto。
```
package tutorial;  
  
message Person {  
  required string name = 1;  
  required int32 id = 2;  
  optional string email = 3;  
  
  enum PhoneType {  
    MOBILE = 0;  
    HOME = 1;  
    WORK = 2;  
  }  
  
  message PhoneNumber {  
    required string number = 1;  
    optional PhoneType type = 2 [default = HOME];  
  }  
  
  repeated PhoneNumber phone = 4;  
}  
  
message AddressBook {  
  repeated Person person = 1;  
}  
```

> 如你所见，在语法上很像C++和Java。那就让我们看看文件中的每个部分和看看它们究竟是干什么的。
> 这个.proto文件开头是包的声明，为了帮助防止在不同的工程中命名冲突。
> 在Python中，包通常由目录结构决定的，所以这个由你的.proto文件定义的包，在你生成你代码中是没有效果的。
> 但是，你应该坚持声明这条语句，为了在protocol Buffers的命名空间中防止名子的冲突，就像其它非Python的语言那样。
> 然后，就是你定义的Message。一个Message是一个包含一组类型字段的集合。
> 有许多简单的标准的数据类型可以用在类型字段中，包括bool，int32，float，double和string。
> 你也可以使用更加多的结构来定义你的Message，例如用其它Message类型当作类型字段-在上面的例子PersonMessage中就包含了PhoneNumberMessage，还有
> AddressBookMessage包含PersonMessage。
> 你也可以定义Message嵌入其它的Message——就如你所见到的那样，PhoneNumber类型就是在Person类型中定义的。
> 你也可以定义一个枚举类型，如果你想你其中一个字段有一个预设的类型列表——在这里，你可以将你的电话号码列举为MOBILE，HOME或者WORK。
> 那个“＝1”，“＝2”标记每个元素的识别，作为二进制编码中字段的唯一的标签。标签要求数字1－15比更高的数字少一个字节编码，所以，作为最优化的方案，
> 你可以决定对常用的和要重复使用的元素使用这些标签，把16或最高的数字留给不常用和可选择的元素。每个重复的字段里的元素要求重新编码它的标签号码，
> 所以重复的字段特别适合使用这种优化。
> 每个字段一定要被以下的修饰语修饰：
> * required：一定要提供一个值给这个字段，否则这条Message会被认为“没有初始化”。序列化一列没有初始化的Message会出现异常。 解析一条没有初始化的
> Message会失败。除此而外，这个required字段的行为更类似于一个optional字段。
> * optional：这个字段可以设置也可以不设置 。如果一个可选字段没有设置值，会用缺省的值。简单来说，你可以指定自己的默认值，就像我们在例子中对phone
> number类型所做的。另外，系统会缺省这样做：0给整数类型，空串给字符串类型，false给布尔类型。对于嵌入的Message，缺省的值通常会是“默认实例”或“原型”，
> 对那些没有设置字段的Message。调用存取器获得一个可选的(或要求)字段的值，那些通常什么明确给出值的字段总是返回该字段的默认值。
> * repeated：这个字段会重复几次一些号码（包括0）。重复的值给按顺序保存在protocol buffer中。重复的字段会被认为是动态的数组。
> Required Is Forever 你应该非常小心地把字段标记为required。如果在某一时刻你希望停止写或发送一个必填字段,
> 那就把不确定的字段更改为一个可选的字段——老的阅读器会认为没有这个字段Message是不完整的,而且可能会无意中拒绝或删除它们。
> 你应该考虑为你的buffer编写特定于应用程序的自定义验证例程。
> 一些来自Google有些结论：使用required弊大于利；他们更愿意只用optional和repeated。但是，这一观点并不普遍。
> 你会找到编写.proto文件的指南——包括所有可能的类型字段——在Protocol Buffer Language Guide.
> 不要去找类似于类继承的设备,虽然——protocol buffers不这样做。

# 程序示例(C++版)
　　该程序示例的大致功能是，定义一个Persion结构体和存放Persion的AddressBook，然后一个写程序向一个文件写入该结构体信息，另一个程序从文件中读出该信息并打印到输出中。

1 address.proto文件
```
复制代码
package tutorial;

message Persion {
    required string name = 1;
    required int32 age = 2;
}

message AddressBook {
    repeated Persion persion = 1;
}
```
　　编译.proto文件，执行命令: protoc -I=$SRC_DIR --cpp_out=$DST_DIR $SRC_DIR/addressbook.proto，示例中执行命令protoc --cpp_out=/tmp addressbook.proto ，会在/tmp中生成文件addressbook.pb.h和addressbook.pb.cc。

2 write.cpp文件，向文件中写入AddressBook信息，该文件是二进制的
```
 #include <iostream>
 #include <fstream>
 #include <string>
 #include "addressbook.pb.h"
 
 using namespace std;
 
 void PromptForAddress(tutorial::Persion *persion) {
     cout << "Enter persion name:" << endl;
     string name;
     cin >> name;
     persion->set_name(name);
 
     int age;
     cin >> age;
     persion->set_age(age);
 }
 
 int main(int argc, char **argv) {
     //GOOGLE_PROTOBUF_VERIFY_VERSION;
 
     if (argc != 2) {
         cerr << "Usage: " << argv[0] << " ADDRESS_BOOL_FILE" << endl;
         return -1;
     }
 
     tutorial::AddressBook address_book;
 
     {
         fstream input(argv[1], ios::in | ios::binary);
         if (!input) {
             cout << argv[1] << ": File not found. Creating a new file." << endl;
         }
         else if (!address_book.ParseFromIstream(&input)) {
             cerr << "Filed to parse address book." << endl;
             return -1;
         }
     }
 
     // Add an address
     PromptForAddress(address_book.add_persion());

     {
         fstream output(argv[1], ios::out | ios::trunc | ios::binary);
         if (!address_book.SerializeToOstream(&output)) {
             cerr << "Failed to write address book." << endl;
             return -1;
         }
     }
 
     // Optional: Delete all global objects allocated by libprotobuf.
     //google::protobuf::ShutdownProtobufLibrary();
 
     return 0;
 }
```
编译write.cpp文件，g++ addressbook.pb.cc write.cpp -o write `pkg-config --cflags --libs protobuf` (注意，这里的`符号在键盘数字1键左边，也就是和~是同一个按键)。

3 read.cpp文件，从文件中读出AddressBook信息并打印

```
 #include <iostream>
 #include <fstream>
 #include <string>
 #include "addressbook.pb.h"
 
 using namespace std;
 
 void ListPeople(const tutorial::AddressBook& address_book) {
     for (int i = 0; i < address_book.persion_size(); i++) {
         const tutorial::Persion& persion = address_book.persion(i);
 
         cout << persion.name() << " " << persion.age() << endl;
     }
 }
 
 int main(int argc, char **argv) {
     //GOOGLE_PROTOBUF_VERIFY_VERSION;
 
     if (argc != 2) {
         cerr << "Usage: " << argv[0] << " ADDRESS_BOOL_FILE" << endl;
         return -1;
     }
 
     tutorial::AddressBook address_book;
 
     {
         fstream input(argv[1], ios::in | ios::binary);
         if (!address_book.ParseFromIstream(&input)) {
             cerr << "Filed to parse address book." << endl;
             return -1;
         }
         input.close();
     }
 
     ListPeople(address_book);
 
     // Optional: Delete all global objects allocated by libprotobuf.
     //google::protobuf::ShutdownProtobufLibrary();
 
     return 0;
 }
 ```
编译read.cpp文件，g++ addressbook.pb.cc read.cpp -o read `pkg-config --cflags --libs protobuf`

# python例子
## 将proto转化为 xxx_pb2.py ,然后在你的程序里import这个py 
protoc --python_out=./  ./struct_oss_pb.proto
得到struct_oss_pb_pb2.py
```
Please use 'syntax = "proto2";' or 'syntax = "proto3";' to specify a syntax version. (Defaulted to proto2 syntax.)
如果报此类错误，需要在proto文件第一行加 syntax = "proto2";
```
## 读取例子
```
import addressbook_pb2
person = addressbook_pb2.Person()
person.id = 1234
person.name = "peiwei"
person.email = "jdoe@example.com"
phone = person.phone.add()
phone.number = "555-4321"
phone.type = addressbook_pb2.Person.HOME
```
## 读写protobuf的示例python
```
#! /usr/bin/python

import addressbook_pb2
import sys

# This function fills in a Person message based on user input.
def PromptForAddress(person):
  person.id = int(raw_input("Enter person ID number: "))
  person.name = raw_input("Enter name: ")

  email = raw_input("Enter email address (blank for none): ")
  if email != "":
    person.email = email

  while True:
    number = raw_input("Enter a phone number (or leave blank to finish): ")
    if number == "":
      break

    phone_number = person.phones.add()
    phone_number.number = number

    type = raw_input("Is this a mobile, home, or work phone? ")
    if type == "mobile":
      phone_number.type = addressbook_pb2.Person.MOBILE
    elif type == "home":
      phone_number.type = addressbook_pb2.Person.HOME
    elif type == "work":
      phone_number.type = addressbook_pb2.Person.WORK
    else:
      print "Unknown phone type; leaving as default value."

# Main procedure:  Reads the entire address book from a file,
#   adds one person based on user input, then writes it back out to the same
#   file.
if len(sys.argv) != 2:
  print "Usage:", sys.argv[0], "ADDRESS_BOOK_FILE"
  sys.exit(-1)

address_book = addressbook_pb2.AddressBook()

# Read the existing address book.
try:
  f = open(sys.argv[1], "rb")
  address_book.ParseFromString(f.read())
  f.close()
except IOError:
  print sys.argv[1] + ": Could not open file.  Creating a new one."

# Add an address.
PromptForAddress(address_book.people.add())

# Write the new address book back to disk.
f = open(sys.argv[1], "wb")
f.write(address_book.SerializeToString())
f.close()
```
```
#! /usr/bin/python

import addressbook_pb2
import sys

# Iterates though all people in the AddressBook and prints info about them.
def ListPeople(address_book):
  for person in address_book.people:
    print "Person ID:", person.id
    print "  Name:", person.name
    if person.HasField('email'):
      print "  E-mail address:", person.email

    for phone_number in person.phones:
      if phone_number.type == addressbook_pb2.Person.MOBILE:
        print "  Mobile phone #: ",
      elif phone_number.type == addressbook_pb2.Person.HOME:
        print "  Home phone #: ",
      elif phone_number.type == addressbook_pb2.Person.WORK:
        print "  Work phone #: ",
      print phone_number.number

# Main procedure:  Reads the entire address book from a file and prints all
#   the information inside.
if len(sys.argv) != 2:
  print "Usage:", sys.argv[0], "ADDRESS_BOOK_FILE"
  sys.exit(-1)

address_book = addressbook_pb2.AddressBook()

# Read the existing address book.
f = open(sys.argv[1], "rb")
address_book.ParseFromString(f.read())
f.close()

ListPeople(address_book)
```
# Protobuf 语法指南
[语法指南](https://github.com/futurepw/paper/blob/master/zmq/protobuf%E8%AF%AD%E6%B3%95%E6%8C%87%E5%8D%97.md)
