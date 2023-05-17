#!/bin/bash
subjectlist=$1
subjectdir=$2
encodingDir=$3
suffix=$4
while read -r subject;
do
#Check if intermediate and output directories exist and make them if they don't
if [ ! -d $2/$subject$4/$3/Logs ]
then
mkdir $2/$subject$4/$3/Logs
else 
echo "Some directories for subject $subject already exist; check existing outputs in $2/$subject$4/$3 before overwriting"
fi
if [ ! -d $2/$subject$4/$3/fMRI ]
then
mkdir $2/$subject$4/$3/fMRI
fi
if [ ! -d $2/$subject$4/$3/fMRI_f2 ]
then
mkdir $2/$subject$4/$3/fMRI_f2
fi
if [ ! -d $2/$subject$4/$3/masks ]
then
mkdir $2/$subject$4/$3/masks
fi
if [ ! -d $2/$subject$4/$3/models ]
then
mkdir $2/$subject$4/$3/models
fi
if [ ! -d $2/$subject$4/$3/extracted_rois ]
then
mkdir $2/$subject$4/$3/extracted_rois
fi
if [ ! -d $2/$subject$4/$3/positions_of_MaxFs ]
then
mkdir $2/$subject$4/$3/positions_of_MaxFs
fi
if [ ! -d $2/$subject$4/$3/positions_of_MaxF2s ]
then
mkdir $2/$subject$4/$3/positions_of_MaxF2s
fi
echo "running TwoBand DCM estimator for subject $subject..."
echo "estimated run time is approxiamtely 1 to 4 hours per subject (with 32GB Ram, 4.7Ghz processor)"
echo "Variability arises from differing number of iterations required to reach convergence in DCM estimation."
echo "Some activity in the terminal should appear shortly (within a few minutes).."
#Extract movement regressors from tsv and save as txt file
../bin/mvmtreg_tsv2txt.sh $2/$subject$4/$3 $subject $3
#Smooth raw data with a 4mm Gaussian Kernel [fsl]
../bin/smooth_raw.sh $2/$subject$4/$3 $subject $3 6 2>&1 | tee $2/$subject$4/$3/Logs/4mmsmooth.txt
#Extract brain mask to use in bandpass filter [fsl]
../bin/mask_gen.sh $2/$subject$4/$3 $3 2>&1 | tee $2/$subject$4/$3/Logs/mask_gen.txt
#Bandpass filter [DPABI]
../bin/2bpf_run.sh $2/$subject$4/$3 2>&1 | tee $2/$subject$4/$3/Logs/2bpf.txt
done < $1
