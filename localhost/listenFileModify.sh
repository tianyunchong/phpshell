#!/bin/sh
# brew install fsevents-tools
basepath=$(cd `dirname $0`; pwd)
fswatch /data/cap/ | while read file
do
if [ "${file##*.}"x = "php"x ];then
	#判断下文件是否存在
	if [ ! -f "${file}" ];then
		echo "${file} 文件不存在";
		continue;
	fi
	#备份目录, 如果不存在，递归建立下
	bak_dir="/tmp/bak$(dirname ${file})"
	if [ ! -d "${bak_dir}" ];then
		mkdir -p $bak_dir
	fi	
	#备份文件存在，且和当前文件一样，说明文件没有修改, 无需再次格式化,忽略本次修改
	bak_file="${bak_dir}/$(basename ${file}).bak"
	if [ -f "$bak_file" ];then
		diff $file $bak_file > /dev/null
		if [ $? == 0 ];then
			echo "${file} 没有修改，无需格式化"
			continue
		fi
	fi
	#格式化代码
	echo "开始格式化 ${file}"
	cmd_shell="/usr/bin/php ${basepath}/fmt.phar --config=${basepath}/php.tools.ini --psr2 --enable_auto_align --smart_linebreak_after_curly -o=${file} ${file}"
	eval $cmd_shell
	# 备份下当前文件
	cat $file > $bak_file
	echo "${file} 格式化成功\n" >> /tmp/debug.log
fi
done