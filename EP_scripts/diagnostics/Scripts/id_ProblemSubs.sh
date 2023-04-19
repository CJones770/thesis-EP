#!/bin/bash
subjectlist=$1
subjectdir=$2
suffix=$3
encdir=$4
outputfile=$5
detailedoutputfile=$6
if [ -f $5 ]
then
	echo "Log file with name "$5" already exists, specify a different name or remove the existing file"
	exit
fi
if [ -f $6 ]
then
	echo "Log file with name "$6" already exists, specify a different name or remove the existing file"
	exit
fi
while read -r subject;
do
if [ -f ../Logs/Subs2Run_tempout.txt ] #this if - continue statement only exists for listGoodSubs.sh functionality; Uneeded if calling a specific list of subjects (e.g, that have already been run).
then
	if grep $subject ../Logs/Subs2Run_tempout.txt
	then	
		continue
	fi
fi
if [ ! -f $2/"$subject"$3/$4/models/glmNR/DCM_21Roi.mat ] 
then
	echo $subject >> $5
	echo "$subject no output for F1" >> $6
elif [ ! -f $2/"$subject"$3/$4/models/glmNR2/DCM_21Roi.mat ] 
then
	echo $subject >> $5
	echo "$subject no output for F2" >> $6
elif grep 'Matrix is close to singular or badly scaled' $2/"$subject"$3/$4/Logs/DCM_estimate.txt > /dev/null
then
	echo $subject >> $5
	echo "$subject singularity warning" >> $6
fi
done < $1
sort -u $5 > /dev/null
