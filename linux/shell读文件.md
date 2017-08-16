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
