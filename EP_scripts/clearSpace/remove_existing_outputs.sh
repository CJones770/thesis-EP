#!/bin/bash
subjectlist=$1
subjectdir=$2
suffix=$3
encdir=$4

while read -r subject;
do
rm -r $2/$subject$3/$4/fMRI $5/$subject$3/$4/fMRI
rm -r $2/$subject$3/$4/extracted_rois $5/$subject$3/$4/extracted_rois
rm -r $2/$subject$3/$4/models $5/$subject$3/$4/models
rm -r $2/$subject$3/$4/masks $5/$subject$3/$4/masks
rm -r $2/$subject$3/$4/positions_of_MaxFs $5/$subject$3/$4/positions_of_MaxFs
rm -r $2/$subject$3/$4/positions_of_MaxF2s $5/$subject$3/$4/positions_of_MaxF2s
rm -r $2/$subject$3/$4/fMRI_filtered $5/$subject$3/$4/fMRI_filtered
rm -r $2/$subject$3/$4/fMRI_f2 $5/$subject$3/$4/fMRI_f2
rm -r $2/$subject$3/$4/fMRI_f2_filtered $5/$subject$3/$4/fMRI_f2_filtered
done
