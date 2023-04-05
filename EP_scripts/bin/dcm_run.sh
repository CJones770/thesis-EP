#!/bin/bash
route=$1
~/matlab/bin/matlab -nodisplay -r 'addpath(genpath("~/spm12")); cd("~/EP_scripts/bin/mat");route=string("'$route'"); run dcm_run.m; exit'
