#!/bin/bash
route=$1
if [ ! -d $1/models/2glmN-DCT ]
then
mkdir $1/models/2glmN-DCT -p
else echo "model 2glmN-DCT directory already exists, may cause overwrite error"
fi
if [ ! -d $1/models/2glmN-DCT2 ]
then
mkdir $1/models/2glmN-DCT2 -p
else echo "model 2glmN-DCT2 directory already exists, may cause overwrite error"
fi
if [ ! -d $1/models/2glmNR ]
then
mkdir $1/models/2glmNR -p
else echo "model 2glmNR directory already exists, may cause overwrite error"
fi
if [ ! -d $1/models/2glmNR2 ]
then
mkdir $1/models/2glmNR2 -p
else echo "model 2glmNR2 directory already exists, may cause overwrite error"
fi

~/matlab/bin/matlab -nodisplay -r 'addpath(genpath("~/spm12"));cd("~/thesis-EP/EP_scripts/bin/mat"); route=string("'$route'"); run glm_dctNR.m;  run glm_nr.m; run glm_dctNR2; run glm_nr2;  exit'
