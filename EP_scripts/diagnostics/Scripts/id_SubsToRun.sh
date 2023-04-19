#!/bin/bash
subjectlistFull=$1
subjectDir=$2
suffix=$3
encdir=$4
outputtextfile=$5
#Create list of subjects that have not had their models estimated at all (here, done simply by assessing if the subject has a Log directory in their subdirectory).

while read -r subject;
do
	if [ ! -d $2/$subject$3/$4/Logs ]
	then
		echo $subject >> $5
	fi
done < $1
