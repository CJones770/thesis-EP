#!/bin/bash
subjectlist=$1
subjectdir=$2
#Perform linear registration of "mean_fsumsamples" volumes output from bedpostX directories of each subject

while read -r subject;
do
/usr/local/fsl/bin/flirt -in $2/$subject/4o/BedpostX_$subject.bedpostX/mean_fsumsamples.nii.gz -ref /usr/local/fsl/data/standard/MNI152_T1_2mm_brain -out $2/$subject/4o/FLIRTed_meanfsumsamples.nii.gz -omat $2/$subject/4o/BedpostX_$subject.bedpostX/FLIRTed_meanfsumsamples.mat -bins 256 -cost corratio -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -dof 12  -interp trilinear
echo "$subject complete"
done < $1

