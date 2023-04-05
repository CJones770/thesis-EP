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
if [ ! -d $1/models/glmNR ]
then
mkdir $1/models/glmNR -p
else echo "model glmNR directory already exists, may cause overwrite error"
fi
if [ ! -d $1/models/glmNR2 ]
then
mkdir $1/models/glmNR2 -p
else echo "model glmNR2 directory already exists, may cause overwrite error"
fi

~/matlab/bin/matlab -nodisplay -r 'addpath(genpath("~/spm12"));cd("~/EP_scripts/bin/mat"); route=string("'$route'"); run glm_dctNR.m;  run glm_nr.m; run glm_dctNR2; run glm_nr2;  exit'
