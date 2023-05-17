#!/bin/bash
subjectlist=$1
subjectdir=$2
suffix=$3
groupname=$4

mkdir $2/$4

while read -r subject;
do
	if [ -d $2/$subject$3 ]
	then
		mkdir $2/$4/$subject$3
		mv $2/$subject$3/* -t $2/$4/$subject$3/
		rmdir $2/$subject$3
	fi
done < $1

