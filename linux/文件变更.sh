#!/bin/bash
user='peiwei'
from='peiwei0913@qq.com'
to='201662927@qq.com'
subject='邮件提醒'
message=''
function mail(){
    email_date=$(date "+%Y-%m-%d_%H:%M:%S")
    echo $message | mail -s $subject -t $user@$from -a From:$to
}
function log(){
    record=/home/peiwei/test/record
    count=`ls -lR|grep "^-"|wc -l`
    for line in `cat $record`
    do
        old=$line
    done
    if [[ $count -eq $old ]] ; then
        echo '没有增加文件'
    elif [[ $count -lt $old ]] ; then
        echo '删除了文件'
        echo `echo $count>$record`
    else
        echo '增加了文件'
        echo `echo $count>$record`
    fi
}
log
