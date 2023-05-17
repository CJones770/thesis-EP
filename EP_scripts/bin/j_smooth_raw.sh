#!/bin/bash
subjectlist=$1
subjectdir=$2
suffix=$3
encdir=$4
FWHWmm=$5
sigma=$(bc -l <<< "$5 / e(l(8*l(2))/2)")
echo "sigma is: $sigma"
while read -r subject;
do
echo "smoothing subject $subject 's data with $5 FWHM gaussian kernel"
fslmaths $2/$subject$3/$4/Rap*_"$subject"_$4_desc-lfofilterCleaned_bold.nii.gz -s $sigma $2/$subject$3/$4/fMRI/smoothedRT_FWHM$5mm.nii.gz | bc -l
echo "subject $subject 's data has been smoothed" 
done < $1
