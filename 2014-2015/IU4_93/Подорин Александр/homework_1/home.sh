#!/bin/bash
n_elem=$#
if [ $n_elem -lt 3 ];
then
	echo "Not enough arguments: $n_elem"
	exit 1
else
	move_dir=$1
	log_file=$2
	time_dir=`date +%Y-%m-%d%_H:%M`
	move_dir="$move_dir/$time_dir"
	if [ ! -d "$move_dir" ];
	then
		mkdir "$move_dir"
	fi
	until [ -z "$3" ]
	do
		cur_dir=$3
		for file in `find $cur_dir -type f`
		do
			if [ -f "$move_dir/${file##*/}" ];
			then
				echo "File Exists ${file##*/}"
				echo -e "$(date +%Y-%m-%d%_H:%M:%S) ${file##*/} ERROR:Совпадение имени файла \n\r" >> $log_file
			else
				cp "$file" "$move_dir"
			fi
		done
		shift
	done
fi
echo "Copy finished"
exit 0
