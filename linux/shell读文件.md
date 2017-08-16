shell 读文件
*****
# 写法一：
```
#!/bin/bash

while read line
do
    echo $line
done < file(待读取的文件)
```
*****

# 写法二：

```
#!/bin/bash

cat file(待读取的文件) | while read line
do
    echo $line
done
```
******

# 写法三：

```
for line in `cat file(待读取的文件)`
do
    echo $line
done
```
# 每天12:00给root发信。
```
[root@lyy etc]# crontab -e   #用vi编辑 
0 12 * * * mail root -s "at 12:00" < /root/.bashrc
每项工作有六个字段分别是：
分钟    小时    日期    月份    周    指令 
0-59    0-23    1-31    1-12    0-7    指令         #0和7都代表星期天
辅助特殊字符：
* （星号）代表任何时刻 
，（逗号）代表分隔时候。如3点与6点 就是3,6 
-（减号）代表一段时间范围内。如：3点到6点 就是3-6 
/n（斜线）n代表数字，即每隔n单位。如每隔五分钟，/5
```
