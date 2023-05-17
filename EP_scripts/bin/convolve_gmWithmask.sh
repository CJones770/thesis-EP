#!/bin/bash
subjectlist=$1
subjectdir=$2
suffix=$3
encdir=$4
while read -r subject;
do
if [ ! -f $2/$subject$3/original_dcm_outputsPA/masks/resampled_gm_mask.nii.gz ]
#if [ ! -f /media/corey/2_4TB-WDBlue/original_DCM_outputs/$subject$3/$4/masks/resampled_gm_mask.nii.gz ]
then
echo "no resampeld grey matter mask available for subject $subject"
continue
fi
fslmaths $2/$subject$3/$4/fMRI_filtered/Filtered_4DVolume.nii -mul $2/$subject$3/original_dcm_outputsPA/masks/resampled_gm_mask.nii.gz $2/$subject$3/$4/fMRI_filtered/gm_signal.nii.gz							
fslmaths $2/$subject$3/$4/fMRI_f2_filtered/Filtered_4DVolume.nii -mul $2/$subject$3/original_dcm_outputsPA/masks/resampled_gm_mask.nii.gz $2/$subject$3/$4/fMRI_f2_filtered/gm_signal.nii.gz
echo "$subject"
done < $1

