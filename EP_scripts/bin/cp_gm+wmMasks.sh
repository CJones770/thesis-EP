#!/bin/bash
subjectlist=$1
indir=$2
outdir=$3
suffix=$4
while read -r subject;
do
cp $2/$subject$4/resampled_gm_mask.nii.gz $3/$subject$4/PA/masks/resampled_gm_mask.nii.gz
cp $2/$subject$4/resampled_wm_mask.nii.gz $3/$subject$4/PA/masks/resampled_wm_mask.nii.gz
done < $1
