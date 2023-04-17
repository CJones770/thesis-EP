#!/bin/bash
subjectlist=$1
subjectdir=$2
suffix=$3
encdir=$4

while read -r subject;
do
rm -r $2/$subject$3/$4/fMRI/split_smoothed1
rm -r $2/$subject$3/$4/fMRI_f2/split_smoothed2
rm $2/$subject$3/$4/models/glmNR/Res_*.nii
rm $2/$subject$3/$4/models/glmNR2/Res_*.nii
done < $subjectlist
