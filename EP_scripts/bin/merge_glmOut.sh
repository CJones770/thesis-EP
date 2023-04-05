#!/bin/bash
path=$1
if [ ! -d $1/fMRI/mergedNR_1 ]
then
mkdir $1/fMRI/mergedNR_1
fi
if [ ! -d $1/fMRI_f2/mergedNR_2 ]
then
mkdir $1/fMRI_f2/mergedNR_2
fi
fslmerge -t $1/fMRI/mergedNR_1/Merged_ts1 $1/models/glmNR/Res_*.nii
fslmerge -t $1/fMRI_f2/mergedNR_2/Merged_ts2 $1/models/glmNR2/Res_*.nii
