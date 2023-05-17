#!/bin/bash
path=$1
subject=$2
encdir=$3
FWHM_mm_spec=$4
sigma=$(bc -l <<< "$4 / e(l(8*l(2))/2)")
echo "sigma is $sigma, FWHM specification is $4 mm"
fslmaths $1/Rap*_"$2"_$3_desc-lfofilterCleaned_bold.nii.gz -s $sigma $1/fMRI/smoothedRT_ts_$3.nii.gz
