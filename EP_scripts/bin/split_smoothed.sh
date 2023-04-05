#!/bin/bash
path=$1
mkdir $1/fMRI/split_smoothed1
mkdir $1/fMRI_f2/split_smoothed2
fslsplit $1/fMRI_filtered/Filtered_4DVolume.nii $1/fMRI/split_smoothed1/s_ts -t
fslsplit $1/fMRI_f2_filtered/Filtered_4DVolume.nii $1/fMRI_f2/split_smoothed2/s_ts -t
gunzip $1/fMRI/split_smoothed1/s_ts*.nii.gz
gunzip $1/fMRI_f2/split_smoothed2/s_ts*.nii.gz
