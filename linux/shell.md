# Shell简介
 
## 概述
> Shell是一种具备特殊功能的程序，它提供了用户与内核进行交互操作的一种接口。它接收用户输入的命令，并把它送入内核去执行。内核是Linux系统的心脏，从开机自检就驻留在计算机的内存中，直到计算机关闭为止，而用户的应用程序存储在计算机的硬盘上，仅当需要时才被调入内存。Shell是一种应用程序，当用户登录linux系统时，Shell就会被调入内存去执行。Shell独立于内核，它是连接内核和应用程序的桥梁，并由输入设备读取命令，再将其转为计算机可以理解的机械码，Linux内核才能执行该命令。

## 优势
> Shell脚本语言的好处是简单、易学、易用，适合处理文件和目录之类的对象，以简单的方式快速完成某些复杂的事情通常是创建脚本的重要原则，脚本语言的特性可以总结为以下几个方面：
* 语法和结构通常比较简单。
* 学习和使用通常比较简单，
* 通常以容易修改程序的“解释”作为运行方式，而不需要“编译。
* 程序的开发产能优于运行效能。

Shell脚本语言是Linux/Unix系统上一种重要的脚本语言，在Linux/Unix领域应用极为广泛，熟练掌握Shell脚本语言是一个优秀的Linux/Unix开发者和系统管理员必经之路。利用Shell脚本语言可以简洁地实现复杂的操作，而且Shell脚本程序往往可以在不同版本的Linux/Unix系统上通用。

# shell 编程
## 基本格式

shell 脚本的个文件名后缀通常是.sh（当然你也可以使用其他后缀或者没有后缀，.sh是为了规范）
> 程序编写格式：
```
#!/bin/bash
# 注释用#号
```
# 变量
变量不需要声明，初始化不需要指定类型
## 变量命名 （和c++一样）
* 数字 字母 下划线 不能以字母开头
> 注意：变量赋值是通过等于号（=）进行赋值，在`变量` `等于` `值` 之间不能出现空格

# 变量类型
shell变量有这几类：`本地变量` `环境变量` `局部变量` `位置变量` `特殊变量`

## 本地变量
只对当前的shell进程有效，对当前进程的子进程和其他shell进程无效（相当于java中的私有变量(private)，只能当前类使用，子类和其他类都无法使用。）
```
#!/bin/bash
num=10 #定义变量 定义：VAR_NAME=VALUE
echo $num #输出变量 有两种方式 ${VAR_NAME}或者$VAR_NAME
unset num #取消变量
```

## 环境变量
自定义的环境变量对当前shell进程及其子shell进程有效，对其他的shell进程无效（相当于java中的protected修饰符,对当前类，子孙类，以及同一个包下面可以共用。）

```
#!/bin/bash
export name=alice #定义环境变量 定义：export VAR_NAME=VALUE
echo $name
```
## 局部变量
在函数中调用，函数执行结束，变量就会消失，对shell脚本中某代码片段有效（相当于java代码中某一个方法中定义的局部变量，只对这个方法有效）

* 定义：local VAR_NAME=VALUE

## 位置变量 
相当于java中main函数中的args参数，可以获取外部参数。
```
比如脚本中的参数：
$0：脚本自身
$1：脚本的第一个参数
$2：脚本的第二个参数
```
## 特殊变量
```
$?：接收上一条命令的返回状态码 返回状态码在0-255之间
$#：参数个数
$*：或者$@：所有的参数
$$：获取当前shell的进程号（PID）(可以实现脚本自杀)(或者使用exit命令直接退出也可以使用exit [num])
```

# 引号
shell编程中有三类引号：`单引号` `双引号` `反引号`
* 单引号不解析变量
* 双引号会解析变量
* 反引号是执行并引用一个命令执行结果，类似于$(...)
```
num=10
echo '$num'
echo "$num"
echo `echo $num`
#结果为
# $num
# 10
# 10 
```

# 控制语句
## 循环
> for 循环

通过使用一个变量去遍历给定列表中的每个元素，在每次变量赋值时执行一次循环体，直至赋值完成所有元素退出循环
```
# 格式一
for ((i=0;i<10;i++))
do
    ......
done
# 格式二
for i in 0 1 2 3 4 5 6 7 8 9
do 
    ......
done
# 格式三
for i in {0..9}
do 
    ......
done
```
* 注意：for i in {0..9}相当于for i in {0..9..1} 第三个参数为跨步 {0..9..2}表示0 2 4 6 8

> while 循环
使用与循环次数未知，或者不便用for直接生成较大的列表时
```
#格式
while 条件
do 
    ......
done
```

> 循环控制
* 循环控制命令——break
    * break命令是在处理过程中跳出循环的一种简单方法，可以使用break命令退出任何类型的循环，包括while循环和for循环
 
* 循环控制命令——continue
    * continue命令是一种提前停止循环内命令，而不完全终止循环的方法，这就需要在循环内设置shell不执行命令的条件
    
# 条件
bash条件测试
```
格式
test EXPR  
[ EXPR ]：注意中括号和表达式之间的空格  
```

```
整型测试：
   -gt：大于：
   -lt：小于
   -ge：大于等于
   -le：小于等于
   -eq：等于
   -ne：不等于
例如[ $num1 -gt $num2 ]或者test $num1 -gt $num2
 
字符串测试：
= 等于，例如判断变量是否为空 [ "$str" =  "" ] 或者[ -z $str ]
!= 不等于
```
* 实例
```
num1=10
num2=20
str1=peiwei
str2=ju
if [ $num1 -gt $num2 ]
then
echo num1 large than num2
else
echo num1 lower than num2
fi
# 结果
# num1 lower than num2
# str1 is not empty
if [ -z $str1 ]
then 
echo str1 is empty
else
echo str1 is not empty
fi
```

## 判断
> if 判断
```
# 单分支
if 测试条件;then  
   选择分支  
fi 

# 双分支
if 测试条件;then  
   选择分支1  
else  
   选择分支2  
fi 

# 多分支
if 条件1; then  
     分支1  
elif 条件2; then  
     分支2  
elif 条件3; then  
     分支3  
     ...  
else  
     分支n  
fi 
```
> case 判断
```
case 变量引用 in  
     PATTERN1)  
         分支1  
         ;;  
     PATTERN2)  
         分支2  
         ;;  
         ...  
     *)  
         分支n  
         ;;  
esac 


PATTERN :类同于文件名通配机制，但支持使用|表示或者
a|b：a或者b
*：匹配任意长度的任意字符
?：匹配任意单个字符
[a-z]：指定范围内的任意单个字符
```

```
#!/bin/bash

num=10
case $num in 
        1)
            echo 1
                ;;
        2)
            echo 2
                ;;
        10)  
            echo 10
                ;;
        *)
            echo something else
                ;;
esac
```
> 算术运算
* let varName=算术表达式  
   
* varName=$[算术表达式]  
   
* varName=$((算术表达式))  
   
* varName=`expr $num1 + $num2`  使用这种格式要注意两个数字和+号中间要有空格。

```
#!/bin/bash
num=1
let num=$num+1
num=$[ $num+1 ]
num=$(($num+1))
num=`expr $num + 1`
echo $num
```

> 逻辑运算符

* 需要用到shell中的逻辑操作符
-a 与
-o 或
！ 非
```
#!/bin/bash
num1=10
num2=20
nume3=15
if [ $num1 -lt $num3 -a $num2 -gt $num3 ]
then
    echo num is between 10 and 20
else
    echo something else
fi
```

```
#!/bin/bash
num1=10
num2=20
num3=15
if [[ $num1 -lt $num3 && $num2 -gt $num3 ]]
then
    echo num is between 10 and 20
else
    echo something else
fi
```
* if [ 条件A -a 条件B ] 
* if [ 条件A ] && [条件B ]
* if(( A && B ))
* if [[ A && B ]]

>  函数
格式
```
function 函数名(){  
...  
} 
```
* 引用自定义函数文件时，使用source  func.sh
* 有利于代码的重用性
* 函数传递参数（可以使用类似于Java中的args，args[1]代表Shell中的$1）
* 函数的返回值，只能是数字

```
#!/bin/bash
# func.sh
function func(){
    echo this is a function
}
func
```

```
#!/bin/bash
#b.sh
source func.sh
func
```
# read
> read命令接收标准输入（键盘）的输入，或者其他文件描述符的输入。得到输入后，read命令将数据放入一个标准变量中。
> read如果后面不指定变量，那么read命令会将接收到的数据放置在环境变量REPLY中
```
#表示输入时的提示字符串：  
read -p "Enter your name:" VAR_NAME  
```
```
# -s 表示安全输入，键入密码时不会显示  
read  -s  -p "Enter your password: " pass
```
```
# -t表示输入等待的时间  
read -t 5 -p "enter your name:" VAR_NAME 
```
# declare
用来限定变量的属性
* -r 只读
* -i 整数：某些算术计算允许在被声明为整数的变量中完成，而不需要特别使用expr或let来完成。
* -a 数组
