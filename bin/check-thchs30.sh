#!/bin/bash

# Only 1 or 2 parameter !
if [ $# != 1 -a $# != 2 ];then
    echo " Usage: sh check-thchs30.sh csvfile [iscopy]!";
    exit
fi

# check the file !
if ! [ -f $1 ];then
    echo "file does not exist!"
    exit
elif ! [ -r $1 ];then
    echo "file can not be read !"
    exit
fi

# PRESS ANY KEY TO CONTITUE !
read -p "begin to read $1 "

# set IFS="\n" , read $1 file per line !
IFS="
"

# i is the line number
if [ "$2" = "Y" ];then
    mkdir "/tmp/copy"
fi
if [ -f "/tmp/${1##*/}" ];then
    rm "/tmp/${1##*/}"
    echo "tmp file exist and delete!"
fi
i=1
for line in `cat $1`
do
    #echo line $i:
    fpath=$(echo $line | awk -F"," '{print $1}')
    fsize=$(echo $line | awk -F"," '{print $2}')
    cword=$(echo $line | awk -F"," '{print $3}')
    fsize2=$(ls -l $fpath | awk '{print $5}')
    fname=${fpath##*/}
    if [ "$fsize" != "$fsize2" ];then
        echo line $i:$fsize"[ != ]"$fsize2
    fi
    if [ "$i" = "1" ];then
	echo "$line" >> "/tmp/${1##*/}"
    else
	echo "$fpath,$fsize2,$cword" >> "/tmp/${1##*/}"
    fi
    if [ "$2" = "Y" ];then
	ffmpeg -i "$fpath" -c:a copy "/tmp/copy/$fname"
    fi
    i=`expr $i + 1`
done

echo "Finished reading file by line ! "
