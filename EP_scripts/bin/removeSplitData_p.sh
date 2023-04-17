#!/bin/bash
path=$1
rmdir -r $1/fMRI/split_smoothed1
rmdir -r $1/fMRI_f2/split_smoothed2
rm $1/models/glmNR/Res_*.nii
rm $1/models/glmNR2/Res_*.nii
