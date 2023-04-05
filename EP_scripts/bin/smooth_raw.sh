#!/bin/bash
path=$1
subject=$2
encdir=$3
fslmaths $1/Rap*_"$2"_$3_desc-lfofilterCleaned_bold.nii.gz -s 4 $1/fMRI/smoothedRT_ts_$3.nii.gz
