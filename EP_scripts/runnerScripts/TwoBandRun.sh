#!/bin/bash
subjectlist=$1
subjectdir=$2
encodingDir=$3
suffix=$4
#This script is designed to estimate cross spectral density dynamic causal models (DCM)
#using resting state fMRI data from the HCP Early Psychosis dataset that are filtered into
#two frequency bands (slow 5 and slow 4) as inputs [hpf at 0.01 and 0.027 Hz respectively]

#Requires: FSL, SPM, DPABI & MATLAB

#Input arguments are 1: path to text file of subject IDs with one ID number per line, 2: the directory that contains the individual subject folders, 3 optional: (the encoding direction of the data if included in the path name) and 4 (optional): a standard suffix that follows each of the subject file names.

#e.g., ./TwoBandRun.sh /media/drive/project/subject_list.txt /media/drive/project/fMRI _01_MR
#This points to a subject list (which should contain values like 1001, 1002, ...), 
#informing the script to look at those subjects in the directory /media/drive/project/fMRI 
#including their standard suffix _01_MR. 
#the script would then evaluate data in directories /media/drive/project/fMRI/1001_01_MR, /media/drive/project/fMRI/1002_01_MR ...

#Author: Corey Jones | corey.jones@tum.de

#Feature to be added: count num subs in list and report to terminal

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
../bin/smooth_raw.sh $2/$subject$4/$3 $subject $3 2>&1 | tee $2/$subject$4/$3/Logs/4mmsmooth.txt
#Extract brain mask to use in bandpass filter [fsl]
../bin/mask_gen.sh $2/$subject$4/$3 $3 2>&1 | tee $2/$subject$4/$3/Logs/mask_gen.txt
#Bandpass filter [DPABI]
../bin/2bpf_run.sh $2/$subject$4/$3 2>&1 | tee $2/$subject$4/$3/Logs/2bpf.txt
#Extract CSF and WM signal for GLM (averaged tx1 vectors) [fsl]
../bin/extract_csf_wm.sh $2/$subject$4/$3 2>&1 | tee $2/$subject$4/$3/Logs/csf_wm_extract.txt
#Split smoothed, filtered data into individual volumes [fsl]
../bin/split_smoothed.sh $2/$subject$4/$3 2>&1 | tee $2/$subject$4/$3/Logs/split_smoothed.txt
#Estimate GLMs [spm]
../bin/glmRun.sh $2/$subject$4/$3 2>&1 | tee $2/$subject$4/$3/Logs/GLMs.txt
#Merge GLM residuals into 4D [fsl]
../bin/merge_glmOut.sh $2/$subject$4/$3 2>&1 | tee $2/$subject$4/$3/Logs/merge_glm_res.txt
#Remove split data that have been merged and compressed
../bin/removeSplitData_p.sh $2/$subject$4/$3
#Find max F-contrasts in ROIs and extract time series [MATLAB & spm]
../bin/findMaxFs.sh $2/$subject$4/$3 $subject 2>&1 | tee $2/$subject$4/$3/Logs/findMaxF.txt
#Estimate DCM [spm]
../bin/dcm_run.sh $2/$subject$4/$3 2>&1 | tee $2/$subject$4/$3/Logs/DCM_estimate.txt
done < $1
