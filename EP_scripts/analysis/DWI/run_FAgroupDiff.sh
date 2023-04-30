#!/bin/bash
subjectlist=$1
subjectdir=$2
DirextensionName=$3
while read -r subject;
do
ls $2/$subject$4/$3 > $2/$subject$4/$3/FA_list.txt
done < $1

python3 ./groupDifferences.py $1 $2 $3
