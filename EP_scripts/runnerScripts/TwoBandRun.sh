#!/bin/bash
subjectlist=$1
subjectdir=$2
encodingDir=$3
suffix=$4
#This script is designed to estimate cross spectral density dynamic causal models (DCM)
#using resting state fMRI data from the HCP Early Psychosis dataset that are filtered into
#two frequency bands (slow 5 and slow 4) as inputs [hpf at 0.01 and 0.027 Hz respectively]

#Requires: FSL, SPM, DPABI & MATLAB

#Input arguments are 1: path to text file of subject IDs with one ID number per line, 2: the directory that contains the individual subject folders, 3 optional: (the encoding direction of the data if included in the path name) and 4 (optional): a standard suffix that follows each of the subject ids in the file names.

#e.g., ./TwoBandRun.sh /media/drive/project/subject_list.txt /media/drive/project/fMRI _01_MR
#This points to a subject list (which should contain values like 1001, 1002, ...), 
#informing the script to look at those subjects in the directory /media/drive/project/fMRI 
#including their standard suffix _01_MR. 
#the script would then evaluate data in directories /media/drive/project/fMRI/1001_01_MR, /media/drive/project/fMRI/1002_01_MR ...

#Author: Corey Jones | corey.jones@tum.de

Help()
{
	#Display help
	echo "TwoBandRun prepares fMRI data for and subsequently performs resting state dynamic causal model estimation"
	echo
	echo "It is expected that the subject data have a standard path naming convention that takes the following form:"
	echo "/SubjectDir/SubjectidSuffix/EncodingDirection/* where the files represented by * contain the BOLD fMRI data and movement regressors"
	echo
	echo "Given these scripts were developed for a specific project using rapidtide corrected data, it is expected that"
	echo "Subject time series data should be stored in a file called Rap*_SubjectID_EncDir_desc-lfofilterCleaned_bold.nii.gz"
	echo "Movement parameters should take the form of Rap*_SubjectID_EncDir_desc-refinedmovingregressor_timeseries.tsv.gz"
	echo
	echo "If needed, the name for the BOLD data can be changed in the EP_scripts/bin/smooth_raw.sh script to match a different convention"
	echo "Similarly, one can change the movement regressor name in the EP_scripts/bin/mvmtreg_tsv2txt.sh file"
	echo
	echo "Syntax: ./TwoBandRun.sh SubjectListPath SubjectDirectory [EncodingDirection] [Suffix] [-h]"
	echo "Example: ./TwoBandRun.sh /media/corey/4TBdrive/subject_list.txt /media/corey/4TBdrive/SubjectDir PA _01_MR" 	
	echo "options:"
	echo "h		Print this Help"

}
while getopts ":h" option; do
	case $option in
		h) #display Help
		Help
		exit;;
	esac
done

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

#Extract CSF and WM signal for GLM (averaged tx1 vectors) [fsl]
#../bin/extract_csf_wm.sh $2/$subject$4/$3 2>&1 | tee $2/$subject$4/$3/Logs/csf_wm_extract.txt
#Now done beforehand in python [nibabel] - change reflected in glm-DCT and glm-NR scripts

#Split smoothed, filtered data into individual volumes [fsl]
../bin/split_smoothed.sh $2/$subject$4/$3 2>&1 | tee $2/$subject$4/$3/Logs/split_smoothed.txt
#Estimate GLMs [spm]
../bin/glmRun.sh $2/$subject$4/$3 2>&1 | tee $2/$subject$4/$3/Logs/GLMs.txt
#Merge GLM residuals into 4D [fsl]
../bin/merge_glmOut.sh $2/$subject$4/$3 2>&1 | tee $2/$subject$4/$3/Logs/merge_glm_res.txt
#Find max F-contrasts in ROIs and extract time series [MATLAB & spm]
../bin/findMaxFs.sh $2/$subject$4/$3 $subject 2>&1 | tee $2/$subject$4/$3/Logs/findMaxF.txt
#Estimate DCM [spm]
../bin/dcm_run.sh $2/$subject$4/$3 2>&1 | tee $2/$subject$4/$3/Logs/DCM_estimate.txt
#Remove split data that have been merged and compressed
../bin/removeSplitData_p.sh $2/$subject$4/$3
done < $1
