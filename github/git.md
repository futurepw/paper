# git 命令行控制
在控制台下输入git测试是否安装git，若出现下面内容则表示已经安装
若没有安装使用命令 sudo apt-get install git 安装
## 测试ssh
github远程提交代码有两种方式，一种是ssh，一种是http，我们使用ssh
```
在命令行下输入ssh -T git@github.com 
执行后提示：Permission denied (publickey) 
```
# 配置ssh key
```
代码ssh-keygen -C "yourname@gmail.com" -f ~/.ssh/github 
```
然后将~/.ssh/github.pub公钥中的内容复制到剪贴板，公钥是一行长长的字符串(不要后面的邮箱)，注意在粘贴时不要加入多余的空格、换行符等，
否则在公钥认证过程当中因为服务端和客户端公钥不匹配而导致认证失败。最后将正确的公钥内容拷贝到GitHub的Key文本框中，并为这个ssh起个名
字，保存即可。 
注意 linux下查看文件的命令是 cat 或者 gedit
## 测试
```
在命令行下输入ssh -T git@github.com 
执行后提示：Hi username! You’ve successfully authenticated, but GitHub does not provide shell access.
```
# 开始使用github

> 配置git

即利用自己的用户名和email地址配置git
```
git config --global user.name "你的github用户名"
git config --global user.email "你的github邮箱地址"
```
如何推送本地内容到github上新建立的仓库
github上新建立仓库
具体内容不做介绍，假设，新建的仓库为dockerfiels
在本地建立一个目录
该目录名称与github新建立的目录相同，假设本地目录为~/Document/dockerfiles

本地仓库初始化
```
cd ~/Document/dockerfiles
git init
```

对本地仓库进行更改

例如，添加一个Readme文件
```
touch Readme
```
对刚刚的更改进行提交

## 该步不可省略！
```
git add Readme
git commit -m 'add readme file'
```
## push
```
首先，需要将本地仓库与github仓库关联 
注：https://github.com/你的github用户名/你的github仓库.git 是github上仓库的网址

git remote add origin https://github.com/你的github用户名/你的github仓库.git  

然后，push，此时，可能需要输入github账号和密码，按要求输入即可

git push origin master
```
## 如何推送本地内容到github上已有的仓库
```
从github上将该仓库clone下来

git clone https://github.com/你的github用户名/github仓库名.git  
```
## 对clone下来的仓库进行更改
例如，添加一个新的文件
```
touch Readme_new
```
对刚刚的更改进行提交

该步不可省略！(其实是提交到git缓存空间)
```
git add Readme_new
git commit -m 'add new readme file'
```
push
```
首先，需要将本地仓库与github仓库关联 
注：https://github.com/你的github用户名/你的github仓库.git 是github上仓库的网址

git remote add origin https://github.com/你的github用户名/你的github仓库.git  

有时，会出现fatal: remote origin already exists.，那么，需要输入git remote rm origin 解决该问题

然后，push，此时，可能需要输入github账号和密码，按要求输入即可

git push origin master

注：有时，在执行git push origin master时，报错：error:failed to push som refs to…….，那么，可以执行

git pull origin master
```
至此，github上已有的仓库的便有了更新

如果需要添加文件夹，有一点需要注意：该文件夹不能为空！否则不能成功添加

操作命令小结
```
克隆github上已有的仓库
git clone https://github.com/你的github用户名/github仓库名.git

或者是在github上新建仓库并且在本地新建同名的仓库
cd ~/Document/dockerfiles
git init
```
对本地仓库内容进行更改（如果是多次对本地的某个仓库进行这样的操作，直接从此步开始即可，不要前面的操作了，因为本地仓库已有具有了github仓库的.git文件了）

对更改内容进行提交
```
git add 更改文件名或者是文件夹名或者是点"."
git commit -m "commit内容标注"
```
本地仓库与github仓库关联
git remote add origin https://github.com/你的github用户名/你的github仓库.git  

push
```
git push origin master
```
注：另外可能用到的命令
```
git remote rm origin
git pull origin master
```
