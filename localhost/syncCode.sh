#!/bin/sh
# brew install fsevents-tools
# 监听下一个目录下的文件修改，同步代码到另外一个目录下
from="/data/cap/remote/172.20.12.100/data/supsite/gc.supsite.work"
to="/data/cap/www2017/gc.supsite.work"
basepath=$(cd `dirname $0`; pwd)
fswatch $from | while read file
do
if [ "${file##*.}"x = "php"x ];then
	#格式化代码
	echo $file
	cmd_shell="/usr/bin/php ${basepath}/syncCode.php $file $from $to"
	eval $cmd_shell
fi
done