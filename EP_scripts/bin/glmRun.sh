#!/bin/bash
route=$1
if [ ! -d $1/models/glmN-DCT ]
then
mkdir $1/models/glmN-DCT -p
else echo "model glmN-DCT directory already exists, may cause overwrite error"
fi
if [ ! -d $1/models/glmN-DCT2 ]
then
mkdir $1/models/glmN-DCT2 -p
else echo "model glmN-DCT2 directory already exists, may cause overwrite error"
fi

~/matlab/bin/matlab -nodisplay -r 'addpath(genpath("~/spm12"));cd("~/thesis-EP/EP_scripts/bin/mat"); route=string("'$route'"); run glm_dctNR.m; run glm_dctNR2; exit'
