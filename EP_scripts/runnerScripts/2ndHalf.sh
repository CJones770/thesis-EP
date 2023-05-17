#!/bin/bash
subjectlist=$1
subjectdir=$2
encodingDir=$3
suffix=$4
while read -r subject;
do
echo "Initializing subject: $subject"
../bin/split_smoothed.sh $2/$subject$4/$3 2>&1 | tee $2/$subject$4/$3/Logs/split_smoothed.txt
#Estimate GLMs [spm]
../bin/glmRun.sh $2/$subject$4/$3 2>&1 | tee $2/$subject$4/$3/Logs/GLMs.txt

#Find max F-contrasts in ROIs and extract time series [MATLAB & spm]
../bin/findMaxFs.sh $2/$subject$4/$3 $subject 2>&1 | tee $2/$subject$4/$3/Logs/findMaxF.txt
#Estimate DCM [spm]
../bin/dcm_run.sh $2/$subject$4/$3 2>&1 | tee $2/$subject$4/$3/Logs/DCM_estimate.txt
#Remove split data that have been merged and compressed
../bin/removeSplitData_p.sh $2/$subject$4/$3
echo "subject $subject complete"
done < $1
