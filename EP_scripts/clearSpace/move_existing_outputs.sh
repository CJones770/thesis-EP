#!/bin/bash
subjectlist=$1
subjectdir=$2
suffix=$3
encdir=$4
outdir=$5
mkdir $5
while read -r subject;
do
mkdir $5/$subject$3/$4/ -p
mv $2/$subject$3/$4/fMRI $5/$subject$3/$4/fMRI
mv $2/$subject$3/$4/extracted_rois $5/$subject$3/$4/extracted_rois
mv $2/$subject$3/$4/models $5/$subject$3/$4/models
mv $2/$subject$3/$4/masks $5/$subject$3/$4/masks
mv $2/$subject$3/$4/positions_of_MaxFs $5/$subject$3/$4/positions_of_MaxFs
mv $2/$subject$3/$4/positions_of_MaxF2s $5/$subject$3/$4/positions_of_MaxF2s
mv $2/$subject$3/$4/fMRI_filtered $5/$subject$3/$4/fMRI_filtered
mv $2/$subject$3/$4/fMRI_f2 $5/$subject$3/$4/fMRI_f2
mv $2/$subject$3/$4/fMRI_f2_filtered $5/$subject$3/$4/fMRI_f2_filtered
done < $subjectlist
