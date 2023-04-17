#!/bin/bash
#Incomplete subject output directories are qualified here as directories without a subject specific Log directory
# (indicating that any existing outputs are derived from a previous workflow) - version specific Logs will be implemented in coming update to make more consistent & customizable
fullsubjectlist=$1
subjectdir=$2
suffix=$3
encdir=$4
outputtextfile=$5
while read -r subject;
do
if [ ! -d "$2/"$subject"$3/$4/Logs" ] 
then
echo $subject >> $5 
fi
done < $fullsubjectlist

