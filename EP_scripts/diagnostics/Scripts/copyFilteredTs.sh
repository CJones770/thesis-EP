#!/bin/bash
subjectlist=$1
subjectdir=$2
suffix=$3
encdir=$4
targetdir=$5
#Copy filtered time series data (stored in GLM-DCT and GLM-DCT2 directories) to target location
while read -r subject;
do
mkdir $5/$subject$3
cp -R $2/$subject$3/$4/models/glmNR $5/$subject$3/glmNR/
cp -R $2/$subject$3/$4/models/glmNR2 $5/$subject$3/glmNR2/
done < $1
