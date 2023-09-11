#!/bin/bash
route=$1
~/matlab/bin/matlab -nodisplay -r 'addpath(genpath("~/spm12")); cd("~/thesis-EP/EP_scripts/bin/F2");route=string("'$route'"); run F2_dcm_run.m; exit'
