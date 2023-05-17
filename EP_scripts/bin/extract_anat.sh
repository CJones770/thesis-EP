#!/bin/bash
subjectlist=$1
subjectdir=$2
suffix=$3
while read -r subject;
do
gunzip -k $2/$subject$3/MNINonLinear/T1w_restore.nii.gz
gunzip -k $2/$subject$3/MNINonLinear/T2w_restore.nii.gz
done < $1
