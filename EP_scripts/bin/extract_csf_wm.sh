path=$1
mkdir $1/extracted_rois/temp
#define masks for WM and CSF rois (in this case, using MNI 2mm voxel space; 4mm radius sphere for CSF in 4th ventricle, 6mm radius sphere for WM in Pons)
fslroi $1/fMRI_filtered/Filtered_4DVolume.nii $1/extracted_rois/CSF_roi1.nii.gz 43 4 41 4 32 4
fslroi $1/fMRI_filtered/Filtered_4DVolume.nii $1/extracted_rois/WM_roi1.nii.gz 42 6 48 6 17 6
#store txt file outputs of average activity in each roi in created directory
fslsplit $1/extracted_rois/CSF_roi1.nii.gz $1/extracted_rois/temp/CSF1_ -t
fslsplit $1/extracted_rois/WM_roi1.nii.gz $1/extracted_rois/temp/WM1_ -t
#binarize volumes created by fslroi to pass to fslmeants
bet2 $1/extracted_rois/temp/CSF1_0001.nii.gz $1/extracted_rois/CSF1_roi_binarymask.nii.gz -m
bet2 $1/extracted_rois/temp/WM1_0001.nii.gz $1/extracted_rois/WM1_roi_binarymask.nii.gz -m
fslmeants -i $1/fMRI_filtered/Filtered_4DVolume.nii -o $1/extracted_rois/WM1_ts.txt -m $1/extracted_rois/WM1_roi_binarymask.nii.gz -c 0 -24 -33 --usemm
fslmeants -i $1/fMRI_filtered/Filtered_4DVolume.nii -o $1/extracted_rois/CSF1_ts.txt -m $1/extracted_rois/CSF1_roi_binarymask.nii.gz -c 0 -40 -5 --usemm
#Second frequency band
fslroi $1/fMRI_f2_filtered/Filtered_4DVolume.nii $1/extracted_rois/CSF_roi2.nii.gz 43 4 41 4 32 4
fslroi $1/fMRI_f2_filtered/Filtered_4DVolume.nii $1/extracted_rois/WM_roi2.nii.gz 42 6 48 6 17 6
fslsplit $1/extracted_rois/CSF_roi2.nii.gz $1/extracted_rois/temp/CSF2_ -t
fslsplit $1/extracted_rois/WM_roi2.nii.gz $1/extracted_rois/temp/WM2_ -t
bet2 $1/extracted_rois/temp/CSF2_0001.nii.gz $1/extracted_rois/CSF2_roi_binarymask.nii.gz -m
bet2 $1/extracted_rois/temp/WM2_0001.nii.gz $1/extracted_rois/WM2_roi_binarymask.nii.gz -m
fslmeants -i $1/fMRI_f2_filtered/Filtered_4DVolume.nii -o $1/extracted_rois/WM2_ts.txt -m $1/extracted_rois/WM2_roi_binarymask.nii.gz -c 0 -24 -33 --usemm
fslmeants -i $1/fMRI_f2_filtered/Filtered_4DVolume.nii -o $1/extracted_rois/CSF2_ts.txt -m $1/extracted_rois/CSF2_roi_binarymask.nii.gz -c 0 -40 -5 --usemm
rm -r $1/extracted_rois/temp/*
rmdir $1/extracted_rois/temp
