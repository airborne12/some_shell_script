#!/bin/sh

usage(){
	echo -e "Usage:test.sh arg"
	echo -e "And arg must be directory"
}
DIR_PATH=$1
if [ $# -eq 1 ] && [ -d $1 ]; then
	for file in $(ls $DIR_PATH); do
		if test -d $DIR_PATH$file;then
			echo $DIR_PATH$file " is directory"
		else
			if grep -e "^#\!/.*/*sh" $DIR_PATH$file > /dev/null; then
				echo $DIR_PATH$file "is a shell script"
			elif grep -e "^#\!/.*/*python" $DIR_PATH$file > /dev/null; then
				echo $DIR_PATH$file "is a python script"
			elif file $DIR_PATH$file | grep "ELF" > /dev/null; then
				echo $DIR_PATH$file "is a ELF executable file"
			else
				echo $DIR_PATH$file "not recognized, may be ascii text?"
			fi
		fi
	done
else
	usage

fi
