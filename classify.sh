#!/bin/sh

usage(){
	echo -e "Usage:test.sh arg"
	echo -e "And arg must be directory"
}

classify(){
	if echo $1 | grep "/$" > /dev/null; then
		ABS_PATH=$1
	else
		ABS_PATH=$1/
	fi
	#echo "entering " $ABS_PATH
	for file in $(ls $ABS_PATH); do
		if test -d $ABS_PATH$file;then
			echo $ABS_PATH$file " is directory"
			$0 $ABS_PATH$file
		else
			if grep -e "^#\!/.*/*sh" $ABS_PATH$file > /dev/null; then
				echo $ABS_PATH$file "is a shell script"
			elif grep -e "^#\!/.*/*python" $ABS_PATH$file > /dev/null; then
				echo $ABS_PATH$file "is a python script"
			elif file $ABS_PATH$file | grep "ELF" > /dev/null; then
				echo $ABS_PATH$file "is a ELF executable file"
			else
				echo $ABS_PATH$file "not recognized, may be ascii text?"
			fi
		fi
	done
}
DIR_PATH=$1
if [ $# -eq 1 ] && [ -d $1 ]; then
	classify "$DIR_PATH"
else
	usage

fi
