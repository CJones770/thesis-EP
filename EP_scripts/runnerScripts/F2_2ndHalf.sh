#!/bin/bash
subjectlist=$1
subjectdir=$2
encodingDir=$3
suffix=$4
#Run BOLD rs-fMRI preprocessing post smoothing with FWHM kernal up to DCM estimation (Only for second Frequency Band)
while read -r subject;
do
echo "Initializing subject: $subject"
../bin/F2/F2_split_smoothed.sh $2/$subject$4/$3 2>&1 | tee $2/$subject$4/$3/Logs/split_smoothed.txt
#Estimate GLMs [spm]
../bin/F2/F2_glmRun.sh $2/$subject$4/$3 2>&1 | tee $2/$subject$4/$3/Logs/GLMs.txt

#Find max F-contrasts in ROIs and extract time series [MATLAB & spm]
../bin/F2/F2_findMaxFs.sh $2/$subject$4/$3 $subject 2>&1 | tee $2/$subject$4/$3/Logs/findMaxF.txt
#Estimate DCM [spm]
../bin/F2/F2_dcm_run.sh $2/$subject$4/$3 2>&1 | tee $2/$subject$4/$3/Logs/DCM_estimate.txt
#Remove split data that have been merged and compressed
../bin/F2/F2_removeSplitData_p.sh $2/$subject$4/$3
echo "subject $subject complete"
done < $1
