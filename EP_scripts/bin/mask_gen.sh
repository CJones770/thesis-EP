#!/bin/bash
path=$1
encdir=$2
bet2 $1/fMRI/smoothedRT_ts_$2.nii.gz $1/masks/s-rfMRI -m
gunzip $1/masks/s-rfMRI_mask.nii.gz
bet2 $1/fMRI/smoothedRT_ts_$2.nii.gz $1/masks/s-rfMRI_f2 -m
gunzip $1/masks/s-rfMRI_f2_mask.nii.gz
