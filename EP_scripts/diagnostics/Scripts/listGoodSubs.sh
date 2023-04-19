#!/bin/bash
#Create a list of subjects that have been run and are not problematic (using id_SubsToRun.sh and id_ProblemSubs.sh)
#Store subject ids that still need to be run and that are problematic
subjectlistfull=$1
subjectdir=$2
suffix=$3
encdir=$4
outputfile=$5

if [ -f $5 ]
then
echo "file $5 already exists. Remove it or specify another path/name"
exit
fi
if [ -f ../Logs/Subs2Run_tempout.txt ]
then
rm ../Logs/Subs2Run_tempout.txt
fi
if [ -f ../Logs/ProblemSubs_tempout.txt ]
then
rm ../Logs/ProblemSubs_tempout.txt
fi
if [ -f ../Logs/det_ProblemSubs_tempout.txt ]
then
rm ../Logs/det_ProblemSubs_tempout.txt
fi
./id_SubsToRun.sh $1 $2 $3 $4 ../Logs/Subs2Run_tempout.txt
./id_ProblemSubs.sh $1 $2 $3 $4 ../Logs/ProblemSubs_tempout.txt ../Logs/det_ProblemSubs_tempout.txt
while read -r subject;
do
	if grep $subject ../Logs/Subs2Run_tempout.txt
	then
		continue
	fi
	if grep $subject ../Logs/ProblemSubs_tempout.txt	
	then	
		continue
	fi
echo $subject >> $5
done < $1
