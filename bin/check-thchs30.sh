#!/bin/bash

# Only 1 parameter !
if [ $# != 1 ];then
	echo " Usage: .\check-thchs30.sh filename!";
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
i=1
for line in `cat $1`
do
    #echo line $i:
    fname=$(echo $line | awk -F"," '{print $1}')
    fsize=$(echo $line | awk -F"," '{print $2}')
    fsize2=$(ls -l $fname | awk '{print $5}')
    if [ "$fsize" != "$fsize2" ];then
        echo line $i:$fsize"[ != ]"$fsize2
    fi
    i=`expr $i + 1`
done

echo "Finished reading file by line ! "
