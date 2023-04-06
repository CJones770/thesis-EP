#!/bin/bash
route=$1
cp $1/fMRI/* $1/fMRI_f2/
~/matlab/bin/matlab -nodisplay -r 'addpath(genpath("~/DPABI_V7.0_230110"));addpath(genpath("~/spm12"));cd("~/thesis-EP/EP_scripts/bin/mat");route=string("'$route'"); run bpf_1.m; run bpf_2.m; exit'
