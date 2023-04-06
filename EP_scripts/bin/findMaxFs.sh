#!/bin/bash
route=$1
subject=$2
~/matlab/bin/matlab -nodisplay -r 'addpath(genpath("~/spm12"));addpath(genpath("/home/corey/matlab/toolbox/findND-master"));cd("~/thesis-EP/EP_scripts/bin/mat");subject=double('$subject');route=string("'$route'"); run find_maxF1.m; run find_maxF2.m; exit'
