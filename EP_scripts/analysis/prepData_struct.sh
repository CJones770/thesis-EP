#!/bin/bash
subjectlist=$1
subjectinfo=$2
subjectdir=$3
suffix=$4
encdir=$5
~/matlab/bin/matlab -r 'addpath(genpath("~/DPABI_V7.0_230110"));addpath(genpath("~/spm12"));cd("~/thesis-EP/EP_scripts/analysis/mat");pathList=string("'$subjectlist'"); pathInfo=string("'$subjectinfo'"); pathDir=string("'$subjectdir'");suff=string("'$suffix'");encdir=string("'$encdir'"); run load_DCMs.m;'
