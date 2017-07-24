> 说明： 
protobuf已经全面迁移到[github](https://github.com/google/protobuf) 
直接下载2.6.1版本:https://github.com/google/protobuf/archive/v2.6.1.zip
默认安装步骤(需root权限)：
```
$wget https://github.com/google/protobuf/archive/v2.6.1.zip
$unzip protobuf-2.6.1.zip
$cd protobuf-2.6.1

下载自github的代码需要首先执行 $ ./autogen.sh 生成configure文件

$ ./configure
$ make
$ make check
$ make install

我使用的是centos系统
usr/local/bin
usr/local/lib,
usr/local/include 
是也系统默认路径之一，所以到这一步就可以使用protobuf了
$ protoc -I=./ --cpp_out=./ test.proto
到你的test.proto文件所在目录使用命令protoc -I=./ --cpp_out=./ 生成C++版本的协议文件
一切OK的话，你回在当前目录看到.h和.cc文件


修改安装路径（非root用户需要修改安装路径）：

protobuf默认安装在 /usr/local 目录
你可以修改安装目录通过 ./configure --prefix=命令
虽然我是root用户但觉得默认安装过于分散，所以统一安装在/usr/local/protobuf下

$./configure --prefix=/usr/local/protobuf
$ make
$ make check
$ make install

到此步还没有安装完毕，在/etc/profile 或者用户目录 ~/.bash_profile
添加下面内容
####### add protobuf lib path ########
#(动态库搜索路径) 程序加载运行期间查找动态链接库时指定除了系统默认路径之外的其他路径
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/protobuf/lib/
#(静态库搜索路径) 程序编译期间查找动态链接库时指定查找共享库的路径
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/protobuf/lib/
#执行程序搜索路径
export PATH=$PATH:/usr/local/protobuf/bin/
#c程序头文件搜索路径
export C_INCLUDE_PATH=$C_INCLUDE_PATH:/usr/local/protobuf/include/
#c++程序头文件搜索路径
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/usr/local/protobuf/include/
#pkg-config 路径
export PKG_CONFIG_PATH=/usr/local/protobuf/lib/pkgconfig/
######################################

好了，goog luck

额外赠送： 
如果出现找不到符号和链接错误请记得加上链接选项 -lprotobuf 
并确认你的静态库路径是否生效了 
echo $LIBRARY_PATH

```
