#!/bin/sh
basepath=$(cd `dirname $0`; pwd)
file="$basepath/test.php"
#初始化备份目录
bak_dir="/tmp/bak$(dirname ${file})"
if [ ! -d "${bak_dir}" ];then
	mkdir -p $bak_dir
fi	
#获取下备份文件
bak_file="${bak_dir}/$(basename ${file}).bak"
#备份文件
#cat $file > $bak_file
#对比文件是否相同
diff $file $bak_file > /dev/null
if [ $? != 0 ];then
	echo "文件改变了"
else
	echo "文件没变"
fi
#if [$0 != 0];then
#	echo "文件发生了修改"
#fi