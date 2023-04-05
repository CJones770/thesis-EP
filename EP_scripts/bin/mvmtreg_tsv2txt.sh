#!/bin/bash
path=$1
subject=$2
encdir=$3
if [ ! -f $1/mvmt_reg.txt ]
then
gunzip $1/Rap*_$subject_$3_desc-refinedmovingregressor_timeseries.tsv.gz
cp $1/Rap*_$subject_$3_desc-refinedmovingregressor_timeseries.tsv $1/mvmt_reg.txt
fi
