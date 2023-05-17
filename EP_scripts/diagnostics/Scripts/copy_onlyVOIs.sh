#!/bin/bash
subjectlist=$1
subjectdir=$2
suffix=$3
groupname=$4
targetdir=$5
mkdir $5/$4
while read -r subject;
do
if [ -d $2/$4/$subject$3 ]
then
	mkdir -p $5/$4/$subject$3/glmNR
	mkdir -p $5/$4/$subject$3/glmNR2
	mv $2/$4/$subject$3/glmNR/VOI* $5/$4/$subject$3/glmNR
	mv $2/$4/$subject$3/glmNR2/VOI* $5/$4/$subject$3/glmNR2
fi
done < $1
