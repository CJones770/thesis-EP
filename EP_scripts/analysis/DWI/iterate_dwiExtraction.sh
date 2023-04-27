#!/bin/bash
subjectlist=$1
subjectdir=$2
outputdirname=$3
while read -r subject;
do
	if [ ! -d $2/$subject/4o/$3 ]
	then
		mkdir $2/$subject/4o/$3	
	fi
python3 extractWM_regions.py $2/$subject/4o/FLIRTed_meanfsumsamples.nii.gz $2/$subject/4o/$3
done < $1
