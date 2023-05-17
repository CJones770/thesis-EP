#!/bin/bash
path=$1
subject=$2
encdir=$3
if [ ! -f $1/movement_regressors.txt ]
then
	if [ -d /media/corey/2_4TB-WDBlue/ext_data/EP_FunctionalPreprocessing/$2_01_MR/rfMRI_REST1_$3/ ]
	then
	cp /media/corey/2_4TB-WDBlue/ext_data/EP_FunctionalPreprocessing/$2_01_MR/rfMRI_REST1_$3/Movement_Regressors.txt $1/movement_regressors.txt
	fi
	
	if [ -d /media/corey/2_4TB-WDBlue/ext_data/EP_FunctionalPreprocessing/$2_01_MR/rfMRI_REST2_$3/ ] 
	then
	cp /media/corey/2_4TB-WDBlue/ext_data/EP_FunctionalPreprocessing/$2_01_MR/rfMRI_REST2_$3/Movement_Regressors.txt $1/movement_regressors.txt
	fi
else
echo "movement regressors text file for subject $2 exists in specified directory"
fi

#gunzip $1/Rap*_$subject_$3_desc-refinedmovingregressor_timeseries.tsv.gz
#cp $1/Rap*_$subject_$3_desc-refinedmovingregressor_timeseries.tsv $1/mvmt_reg.txt

