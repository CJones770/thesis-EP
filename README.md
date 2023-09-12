# thesis-EP
This repository contains a collection of scripts used for data preparation and analysis in my masters thesis investigating alterations in Effective Connectivity (EC) and Fractional Anisotropy (FA) in Early Psychosis (EP). This README file gives descriptions on how the scripts were used to produce the results presented in the report version of the thesis, which can be found in the child folder EP_scripts in pdf form. 

This documentation is primarily provided to clarify the processes that were used to generate the results presented in the thesis report and make it possible to reproduce said results using the same data in the same structure. The secondary purpose of the documentation is to make the workflow reusable to others who may wish to conduct a study in the same style as this, however, it is likely that some organization of the data and/or hardcoded variables within the scripts of this repository would need to be changed to facilitate that. I have provided some documentation within the scripts in order to clarify which segments of code should be adjusted to fit a different data directory structure. On an as needed basis, I will update the code to be more user friendly and flexible so that it can be used on arbitrary sets of rs-fMRI and dMRI data. Questions about these scripts and how they are intended to be employed can be asked to me via email at _corey.jones@tum.de_

The workflow is broken up into four major components. (Descriptions of each method used and their respective references are available in the pdf version of the report)

1) Estimating the first level spectral dynamic causal models that provide us estimates of EC for each subject. [requires MATLAB, SPM, and DPABI] 

2) Using Parametric Empirical Bayes and Bayesian Model Reduction to obtain optimized posterior estimates of those EC metrics. [Requires MATLAB and SPM]

3) Estimating regional average FA metrics for each subject and comparing those metrics between healthy controls and patients with Early Psychosis. Assumes that raw dMRI data have been processed and DTI metrics estimated using workflows from another repository of mine (see tractography-pipeline-restore repository). [Requires tractography-pipeline-restore repo and its respective dependencies (or official HCP minimal preprocessing pipeline for dMRI data) and Jupyter Notebook]. If deciding to use HCP official processing pipeline, then the variable names coded into the estimation procedures used in this repo would need to be adjusted. [can be skipped if only interested in EC metrics and how they relate to symptom severity].

4) Analyzing the metrics generated using a set of Jupyter notebooks and Matlab scripts.

In the following paragraphs, the scripts that were used to conduct these steps will be listed and described.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

*1) Estimating first level sp-DCMs for each subject.*

In short, preparation for and estimation of spectral dynamic causal models over a list of subjects with resting state BOLD fMRI data are conducted by running the EP_scripts/runnerScripts/TwoBandRun.sh script. This initiates a workflow using the scripts found in the EP-scripts/bin/ directory requiring that a: 1) list of subject IDs (that label the files the subject data are stored in within the subject directory), 2) A path specifying the subject directory (e.g., /home/user/my-study/subject-data), 3) Assuming the subject directory has subdirectories containing subject data recored in different encoding directions (e.g., subjectDir/AP/all-of-my-subject-files and subjectDir/PA/all-of-my-subject-files), then the encoding direction as it is name i.e., AP or PA, must be passed as the third argument; otherwise this can be left blank. 4) If the subject files have a standard suffix e.g., the files that comprise 'all-of-my-subject-data' have names like SubId1-MRDATA, then -MRDATA would need to be passed as the fourth argument to the script. Doing this will create all of the necessary working and permanent directories needed to run and log the processes used in this study, and will initialize the workflow up to the estimation of the first level sp-DCMs. 

The workflow consists of the following sub-processes (As they appear in the 'additional preprocessing of fMRI data' section of the thesis report)

0: Generate Discrete Cosine Basis functions with initializors/DCT_define.m; Low-pass filter cutoff frequencies are specified here (in 1/f form).

1: Conversion of movement regressor tsv file to txt format. Will be skipped if the subject's movement regressor file, which must have the name "movement_regressors.txt", already exists.

2: 6mm FWHM smoothing of minimally preprocessed fMRI data. (size can be adjusted by changing the integer '6' to the desired size on line 95 of the TwoBandRun.sh file. 

3: Brain mask creation using FSL's bet2 function on the smoothed images (Used for filtering in the following step).

4: Highpass filtering of the rs-fMRI image data using specified cutoffs of interest. These cutoffs can be changed in the bin/mat/bpf_x.m files by adjusting the 0.01 or 0.027, for either x= 1 or 2, respectively. The low-pass part of the filtering occurs during the glm-estimation using the DCT-basis set defined using step 0.

5: Splits smoothed, filtered data into individual volumes (required for GLM implemented via SPM), these individual volumes are removed after that

6: Creates glm models for each frequency band using DCT-basis sets, head movement, and csf signal from the 4th ventricle as independent variables and nuisance regressors. Defines F-contrast over the DCT-basis set.

7: Finds maximum F-contrast values within each search radius of interest that corresponds to the ROI(s) included in the DCM estimation. The centers and diameters of the spheres of interest can be adjusted by altering the values in lines 4-28 and 48-68 in the bin/mat/find_maxFx.m files. Positions and diameters are specfied in mm, and the script is written under the assumption that the image dimensions are 2mmx2mmx2mm. If the name or number of ROIs included in the models are changed, then the corresponding down-stream code would need to be adjusted as well.

8: Declares options for running spm\_dcm\_fmri_csd.m file and estimates first level models in both frequency bands. Options can be adjusted in lines 67-73 of the /bin/mat/dcm\_run.m script (See SPM documentation on spm\_dcm\_fmri\_csd.m script for details). This estimation can take several hours per subject depending on the number of included ROIs and amount of available computational resources. Using an intel 8800-k processor (4.7GHz), an iteration took ~65-75s and a subject took ~75 iterations to converge on average. This yields an average time of 87.5 minutes per model, therefore at 2 models per subject the average time taken is *approximately 3 hours per subject*. 

*2) Using SPM functions to optimize EC metrics with PEB and BMR*

Once the first level models are estimated, the group differences can be quantifed (and covariates can be controlled for) and parameters can be optimized using PEB and BMR, respectively. 

0: Load DCMs into MATLAB environment using /analysis/prepData_struct.sh with the following arguments.
1) text file list of subject IDs who have specified models with no errors (which can be generated by using /diagnostics/Scripts/listGoodSubs.sh), 2) ndar.txt file with personal data about the subjects (e.g., age, sex, race, recording site, etc. [most importantly, whether they belong to the control or patient group]). 3) Directory where the subject data are stored (by default, this is the same as the subject directory specified in section 1 part 1). 4) Standard suffix (same as in section 1 part 1). 5) Encoding direction (same as in section 1 part 1). 6) Medical information text file (If contained in ndar file, then this can be omitted). 

1: run /analysis/mat/prep_PEB.m script, which will estimate posterior expectations of group average EC metrics. Covariates can be included by adjusting the design matrix in this script (see lines 11-13, and 17). If the design matrix is adjusted to include covariates, then those covariates must be named in the variable 'M.Xnames' (see line 29).

2: run BMR process with /analysis/mat/bmr.m, which will optimize the EC metrics specified in the previous step.

After these processes, the final group and subject-wise EC estimates used in the thesis report have been estimated and stored as peb\_bmr\_n and sw\_bmr\_n, respectively.

Note that including additional covariates to the PEB process will increase the amount of time taken to optimize the EC metrics via BMR, given that it greatly increases the number of parameters the optimization process has to consider. This scales with the number of included connections (n-connections x n-columns-of-DesignMatrix).

*3) Using tractography-pipeline-restore, FSL, and Jupyter notebooks to estimate regional average FA for each subject and compare between groups*

Details about how to use the workflow of tractography-pipeline-restore to create DTI metrics are described in that repository. The steps used in this repository to estimate average regional FA values for the purposes of this thesis are mostly contained in the /analysis/DWI/*.ipynb files and consist of the following:

1: Run 'groupDifferences\_omuir-jbabdi.ipynb', adjust paths as needed to reflect data directory structure containing DTI data and supplementary materials from O'muircheartaigh and Jbabdi, 2018. On the first run through markdown cells need to be converted to code cells to create the estimates of weighted and non-weighted regional average FA values and save them as nifti volumes.

2: Run 'extract\_Talairach\_WM\_parcels.ipynb' through cell 41. Similarly, you will need to convert the markdown cell between code cells 21 and 22 to convolve the atlas images with the individual subject data. Path names will need to be adjusted to reflect your data directory structure and Talairach atlas xml file location.

3: To obtain the Talairach labels that correspond to the O'muircheartaigh and Jbabdi ICs, use the 'mapping_Omuir2Std.ipynb' file.

*4) Analyzing EC metrics for differences between groups and for correlations with severity of cognitive impairment or clinical severity in the group with Early Psychosis.*

The methods used to assess differences in EC between the groups are consolidated in the '/analysis/Effective\_Connectivity\_Square.ipynb' file.

For the CVA methods employed:

1: The feature selection process is described and implemented in the '/analysis/mat/cca\_feature\_selection\_zarghami.m' file.

2: Model specification and estimation was done using the '/analysis/mat/cva\_via\_feature\_selection.m' file.
