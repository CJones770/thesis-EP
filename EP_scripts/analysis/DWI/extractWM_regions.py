import sys
import nibabel as nib
import numpy as np
#Load dwi data and atlas data of interest

print(sys.argv[1])
dwi = nib.load('%s' %sys.argv[1]) #Example path '/media/corey/4TB-WDBlue/data-thesis/DTI/data_preproc_1to99/1006/4o/FLIRTed_meanfsumsamples.nii.gz')

jhuAtlas = nib.load('/usr/local/fsl/data/atlases/JHU/JHU-ICBM-tracts-maxprob-thr0-2mm.nii.gz') #nib.load('/usr/local/fsl/data/atlases/JHU/JHU-ICBM-DWI-2mm.nii.gz') 
ThalamusAtlas = nib.load('/usr/local/fsl/data/atlases/Thalamus/Thalamus-maxprob-thr0-2mm.nii.gz')
CerebellarAtlas = nib.load('/usr/local/fsl/data/atlases/Cerebellum/Cerebellum-MNIflirt-maxprob-thr0-2mm.nii.gz')

dwi_data = dwi.get_fdata()
affine = dwi.affine #MNI_2mm affine matrix

jhu_data = jhuAtlas.get_fdata()
thal_data = ThalamusAtlas.get_fdata()
cerb_data = CerebellarAtlas.get_fdata()
#Extract mean FA values from regions in given atlas(es) for subjects within a specified list; store each extracted volume as an independent file
#JHU atlas based extraction
for r in range(1,int(np.max(jhu_data))+1):
    null_tract = np.zeros_like(dwi_data)
    tract = null_tract
    for x in range(0,91):
        for y in range(0,109):
            for z in range(0,91):
                if jhu_data[x,y,z] == r:
                    tract[x,y,z] = dwi_data[x,y,z]
    tract_average = tract[np.nonzero(tract)].mean()
    for x in range(0,91):
        for y in range(0,109):
            for z in range(0,91):
                if jhu_data[x,y,z] == r:
                    tract[x,y,z] = tract_average
    ext_tract = nib.Nifti1Image(tract,affine)
    nib.save(ext_tract,'%s/jhu_%d' %(sys.argv[2],r))
                    
#Thalamus atlas based extraction
for r in range(1,int(np.max(thal_data))+1):
    null_tract = np.zeros_like(dwi_data)
    tract = null_tract
    for x in range(0,91):
        for y in range(0,109):
            for z in range(0,91):
                if thal_data[x,y,z] == r:
                    tract[x,y,z] = dwi_data[x,y,z]
    tract_average = tract[np.nonzero(tract)].mean()
    for x in range(0,91):
        for y in range(0,109):
            for z in range(0,91):
                if thal_data[x,y,z] == r:
                    tract[x,y,z] = tract_average
    ext_tract = nib.Nifti1Image(tract,affine)
    nib.save(ext_tract,'%s/thal_%d' %(sys.argv[2],r))

#Cerebellar atlas based extraction
labs_of_interest = [5,7,8,10]
for r in labs_of_interest:
    null_tract = np.zeros_like(dwi_data)
    tract = null_tract
    for x in range(0,91):
        for y in range(0,109):
            for z in range(0,91):
                if cerb_data[x,y,z] == r:
                    tract[x,y,z] = dwi_data[x,y,z]
    tract_average = tract[np.nonzero(tract)].mean()
    for x in range(0,91):
        for y in range(0,109):
            for z in range(0,91):
                if cerb_data[x,y,z] == r:
                    tract[x,y,z] = tract_average
    ext_tract = nib.Nifti1Image(tract,affine)
    nib.save(ext_tract,'%s/cerb_%d' %(sys.argv[2],r))