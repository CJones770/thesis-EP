%Find maximum F-contrast value in predefined spheres of interest,
%store that information in a text file for each route,
%center a new sphere at the maximum value from which to extract Time series
c1_PCCandPrecuneus = [0 -52 7];
c1_mPFC = [-1 54 27];
c1_L_lPar = [-46 -66 30];
c1_R_lPar = [49 -63 33];
c1_L_iTem = [-61 -24 -9];
c1_R_iTem = [58 -24 -9];
c1_mdThal = [0 -12 9];
c1_L_pCerb = [-25 -81 -33];
c1_R_pCerb = [25 -81 -33];
c1_dmPFC = [0 24 46];
c1_L_aPFC = [-44 45 0];
c1_R_aPFC = [44 45 0];
c1_L_sPar = [-50 -51 45];
c1_R_sPar = [50 -51 45];
c1_dACC = [0 21 36];
c1_L_aPFC_SN = [-35 45 30];
c1_R_aPFC_SN = [32 45 30];
c1_L_Ins = [-41 3 6];
c1_R_Ins = [41 3 6];
c1_L_lPar_SN = [-62 -45 30];
c1_R_lPar_SN = [62 -45 30];

vox_pos_c1PCCandPrecuneus = mm2vox(c1_PCCandPrecuneus);
vp_c1_mPFC = mm2vox(c1_mPFC);
vp_c1_LlPar = mm2vox(c1_L_lPar);
vp_c1_RlPar = mm2vox(c1_R_lPar);
vp_c1_LiTem = mm2vox(c1_L_iTem);
vp_c1_RiTem = mm2vox(c1_R_iTem);
vp_c1_mdThal = mm2vox(c1_mdThal);
vp_c1_LpCerb = mm2vox(c1_L_pCerb);
vp_c1_RpCerb = mm2vox(c1_R_pCerb);
vp_c1_dmPFC = mm2vox(c1_dmPFC);
vp_c1_LaPFC = mm2vox(c1_L_aPFC);
vp_c1_RaPFC = mm2vox(c1_R_aPFC);
vp_c1_LsPar = mm2vox(c1_L_sPar);
vp_c1_RsPar = mm2vox(c1_R_sPar);
vp_c1_dACC = mm2vox(c1_dACC);
vp_c1_LaPFC_SN = mm2vox(c1_L_aPFC_SN);
vp_c1_RaPFC_SN = mm2vox(c1_R_aPFC_SN);
vp_c1_LIns = mm2vox(c1_L_Ins);
vp_c1_RIns = mm2vox(c1_R_Ins);
vp_c1_LlPar_SN = mm2vox(c1_L_lPar_SN);
vp_c1_RlPar_SN = mm2vox(c1_R_lPar_SN);

sr_c1_PCC = sphereRange(vox_pos_c1PCCandPrecuneus,6);
sr_mPFC = sphereRange(vp_c1_mPFC,8);
sr_LlPar = sphereRange(vp_c1_LlPar,8);
sr_RlPar = sphereRange(vp_c1_RlPar,8);
sr_LiTem = sphereRange(vp_c1_LiTem,8);
sr_RiTem = sphereRange(vp_c1_RiTem,8);
sr_mdThal = sphereRange(vp_c1_mdThal,6);
sr_LpCerb = sphereRange(vp_c1_LpCerb,4);
sr_RpCerb = sphereRange(vp_c1_RpCerb,4);
sr_dmPFC = sphereRange(vp_c1_dmPFC,8);
sr_LaPFC = sphereRange(vp_c1_LaPFC,8);
sr_RaPFC = sphereRange(vp_c1_RaPFC,8);
sr_LsPar = sphereRange(vp_c1_LsPar,8);
sr_RsPar = sphereRange(vp_c1_RsPar,8);
sr_dACC = sphereRange(vp_c1_dACC,6);
sr_LaPFC_SN = sphereRange(vp_c1_LaPFC_SN,8);
sr_RaPFC_SN = sphereRange(vp_c1_RaPFC_SN,8);
sr_LIns = sphereRange(vp_c1_LIns,6);
sr_RIns = sphereRange(vp_c1_RIns,6);
sr_LlPar_SN = sphereRange(vp_c1_LlPar_SN,8);
sr_RlPar_SN = sphereRange(vp_c1_RlPar_SN,8);


niftiF1 = niftiread(sprintf('%s/models/2glmN-DCT2/spmF_0001.nii',route));

maskIm = niftiread(sprintf('%s/masks/s-rfMRI_f2_mask.nii',route));
clear("matlabbatch")

%Clean up mask image, as nan will create errors with VOI calculations
fprintf("cleaning up mask for path %s",route)
for t=1:410
    v_pad = sprintf('%04d',t);
    timeseriesIm = niftiread(sprintf('%s/models/2glmNR2/Res_%s.nii',route,v_pad));
    for x=1:91
        for y=1:109
            for z=1:91
                if maskIm(x,y,z)==1 && isnan(timeseriesIm(x,y,z))
                    maskIm(x,y,z)=0;
                end
            end
        end
    end
end
fprintf('mask cleaning complete for path %s',route)


%checking for max F value within sphere centered around predefined
%coordinates in Razi et al. 2017 (for the first frequency band)
val_PCCandPrecuneus= max(niftiF1(sr_c1_PCC(1):sr_c1_PCC(2),sr_c1_PCC(3):sr_c1_PCC(4),sr_c1_PCC(5):sr_c1_PCC(6)),[],'all'); 
[r_PCCandPrecuneus,c_PCCandPrecuneus,v_PCCandPrecuneus] = findND(niftiF1==val_PCCandPrecuneus,1); 

val_mPFC = max(niftiF1(sr_mPFC(1):sr_mPFC(2),sr_mPFC(3):sr_mPFC(4),sr_mPFC(5):sr_mPFC(6)),[],'all');
[r_mPFC,c_mPFC,v_mPFC] = findND(niftiF1==val_mPFC,1);

val_L_lPar = max(niftiF1(sr_LlPar(1):sr_LlPar(2),sr_LlPar(3):sr_LlPar(4),sr_LlPar(5):sr_LlPar(6)),[],'all');
[r_L_lPar,c_L_lPar,v_L_lPar] = findND(niftiF1==val_L_lPar,1);

val_R_lPar = max(niftiF1(sr_RlPar(1):sr_RlPar(2),sr_RlPar(3):sr_RlPar(4),sr_RlPar(5):sr_RlPar(6)),[],'all');
[r_R_lPar,c_R_lPar,v_R_lPar] = findND(niftiF1==val_R_lPar,1);

val_L_iTem = max(niftiF1(sr_LiTem(1):sr_LiTem(2),sr_LiTem(3):sr_LiTem(4),sr_LiTem(5):sr_LiTem(6)),[],'all');
[r_L_iTem,c_L_iTem,v_L_iTem] = findND(niftiF1==val_L_iTem,1);

val_R_iTem = max(niftiF1(sr_RiTem(1):sr_RiTem(2),sr_RiTem(3):sr_RiTem(4),sr_RiTem(5):sr_RiTem(6)),[],'all');
[r_R_iTem,c_R_iTem,v_R_iTem] = findND(niftiF1==val_R_iTem,1);

val_mdThal = max(niftiF1(sr_mdThal(1):sr_mdThal(2),sr_mdThal(3):sr_mdThal(4),sr_mdThal(5):sr_mdThal(6)),[],'all');
[r_mdThal,c_mdThal,v_mdThal] = findND(niftiF1==val_mdThal,1);

val_L_pCerb = max(niftiF1(sr_LpCerb(1):sr_LpCerb(2),sr_LpCerb(3):sr_LpCerb(4),sr_LpCerb(5):sr_LpCerb(6)),[],'all');
[r_L_pCerb,c_L_pCerb,v_L_pCerb] = findND(niftiF1==val_L_pCerb,1);

val_R_pCerb = max(niftiF1(sr_RpCerb(1):sr_RpCerb(2),sr_RpCerb(3):sr_RpCerb(4),sr_RpCerb(5):sr_RpCerb(6)),[],'all');
[r_R_pCerb,c_R_pCerb,v_R_pCerb] = findND(niftiF1==val_R_pCerb,1);

val_dmPFC = max(niftiF1(sr_dmPFC(1):sr_dmPFC(2),sr_dmPFC(3):sr_dmPFC(4),sr_dmPFC(5):sr_dmPFC(6)),[],'all');
[r_dmPFC,c_dmPFC,v_dmPFC] = findND(niftiF1==val_dmPFC,1);

val_L_aPFC = max(niftiF1(sr_LaPFC(1):sr_LaPFC(2),sr_LaPFC(3):sr_LaPFC(4),sr_LaPFC(5):sr_LaPFC(6)),[],'all');
[r_L_aPFC,c_L_aPFC,v_aPFC] = findND(niftiF1==val_L_aPFC,1);

val_R_aPFC = max(niftiF1(sr_RaPFC(1):sr_RaPFC(2),sr_RaPFC(3):sr_RaPFC(4),sr_RaPFC(5):sr_RaPFC(6)),[],'all');
[r_R_aPFC,c_R_aPFC,v_R_aPFC] = findND(niftiF1==val_R_aPFC,1);

val_L_sPar = max(niftiF1(sr_LsPar(1):sr_LsPar(2),sr_LsPar(3):sr_LsPar(4),sr_LsPar(5):sr_LsPar(6)),[],'all');
[r_L_sPar,c_L_sPar,v_L_sPar] = findND(niftiF1==val_L_sPar,1);

val_R_sPar = max(niftiF1(sr_RsPar(1):sr_RsPar(2),sr_RsPar(3):sr_RsPar(4),sr_RsPar(5):sr_RsPar(6)),[],'all');
[r_R_sPar,c_R_sPar,v_R_sPar] = findND(niftiF1==val_R_sPar,1);

val_dACC = max(niftiF1(sr_dACC(1):sr_dACC(2),sr_dACC(3):sr_dACC(4),sr_dACC(5):sr_dACC(6)),[],'all');
[r_dACC,c_dACC,v_dACC] = findND(niftiF1==val_dACC,1);

val_L_aPFC_SN = max(niftiF1(sr_LaPFC_SN(1):sr_LaPFC_SN(2),sr_LaPFC_SN(3):sr_LaPFC_SN(4),sr_LaPFC_SN(5):sr_LaPFC_SN(6)),[],'all');
[r_L_aPFC_SN,c_L_aPFC_SN,v_L_aPFC_SN] = findND(niftiF1==val_L_aPFC_SN,1);

val_R_aPFC_SN = max(niftiF1(sr_RaPFC_SN(1):sr_RaPFC_SN(2),sr_RaPFC_SN(3):sr_RaPFC_SN(4),sr_RaPFC_SN(5):sr_RaPFC_SN(6)),[],'all');
[r_R_aPFC_SN,c_R_aPFC_SN,v_R_aPFC_SN] = findND(niftiF1==val_R_aPFC_SN,1);

val_L_Ins = max(niftiF1(sr_LIns(1):sr_LIns(2),sr_LIns(3):sr_LIns(4),sr_LIns(5):sr_LIns(6)),[],'all');
[r_L_Ins,c_L_Ins,v_L_Ins] = findND(niftiF1==val_L_Ins,1);

val_R_Ins = max(niftiF1(sr_RIns(1):sr_RIns(2),sr_RIns(3):sr_RIns(4),sr_RIns(5):sr_RIns(6)),[],'all');
[r_R_Ins,c_R_Ins,v_R_Ins] = findND(niftiF1==val_R_Ins,1);

val_L_lPar_SN = max(niftiF1(sr_LlPar_SN(1):sr_LlPar_SN(2),sr_LlPar_SN(3):sr_LlPar_SN(4),sr_LlPar_SN(5):sr_LlPar_SN(6)),[],'all');
[r_L_lPar_SN,c_L_lPar_SN,v_L_lPar_SN] = findND(niftiF1==val_L_lPar_SN,1);

val_R_lPar_SN = max(niftiF1(sr_RlPar_SN(1):sr_RlPar_SN(2),sr_RlPar_SN(3):sr_RlPar_SN(4),sr_RlPar_SN(5):sr_RlPar_SN(6)),[],'all');
[r_R_lPar_SN,c_R_lPar_SN,v_R_lPar_SN] = findND(niftiF1==val_R_lPar_SN,1);

%If there is more than one set of values that match the maximum F value for
%a given region, one must be selected over the other; first it should be
%confirmed that one is indeed within the initially specified search radius 

%store found value for each route and save into a text file for each VOI
pos_maxPCCandPrecuneus = [r_PCCandPrecuneus,c_PCCandPrecuneus,v_PCCandPrecuneus];
pos_maxmPFC = [r_mPFC,c_mPFC,v_mPFC];
pos_maxLlPar = [r_L_lPar,c_L_lPar,v_L_lPar];
pos_maxRlPar = [r_R_lPar,c_R_lPar,v_R_lPar];
pos_maxLiTem = [r_L_iTem,c_L_iTem,v_L_iTem];
pos_maxRiTem = [r_R_iTem,c_R_iTem,v_R_iTem];
pos_maxmdThal = [r_mdThal,c_mdThal,v_mdThal];
pos_maxLpCerb = [r_L_pCerb,c_L_pCerb,v_L_pCerb];
pos_maxRpCerb = [r_R_pCerb,c_R_pCerb,v_R_pCerb];
pos_maxdmPFC = [r_dmPFC,c_dmPFC,v_dmPFC];
pos_maxLaPFC = [r_L_aPFC,c_L_aPFC,v_aPFC];
pos_maxRaPFC = [r_R_aPFC,c_R_aPFC,v_R_aPFC];
pos_maxLsPar = [r_L_sPar,c_L_sPar,v_L_sPar];
pos_maxRsPar = [r_R_sPar,c_R_sPar,v_R_sPar];
pos_maxdACC = [r_dACC,c_dACC,v_dACC];
pos_maxLaPFC_SN = [r_L_aPFC_SN,c_L_aPFC_SN,v_L_aPFC_SN];
pos_maxRaPFC_SN = [r_R_aPFC_SN,c_R_aPFC_SN,v_R_aPFC_SN];
pos_maxLIns = [r_L_Ins,c_L_Ins,v_L_Ins];
pos_maxRIns = [r_R_Ins,c_R_Ins,v_R_Ins];
pos_maxLlPar_SN = [r_L_lPar_SN,c_L_lPar_SN,v_L_lPar_SN];
pos_maxRlPar_SN = [r_R_lPar_SN,c_R_lPar_SN,v_R_lPar_SN];  

%... save to txt file along with subject number
val_PCCandPrecuneus = double(val_PCCandPrecuneus);
val_mPFC = double(val_mPFC);
val_L_lPar = double(val_L_lPar);
val_R_lPar = double(val_R_lPar);
val_L_iTem = double(val_L_iTem);
val_R_iTem = double(val_R_iTem);
val_mdThal = double(val_mdThal);
val_L_pCerb = double(val_L_pCerb);
val_R_pCerb = double(val_R_pCerb);
val_dmPFC = double(val_dmPFC);
val_L_aPFC = double(val_L_aPFC);
val_R_aPFC = double(val_R_aPFC);
val_L_sPar = double(val_L_sPar);
val_R_sPar = double(val_R_sPar);
val_dACC = double(val_dACC);
val_L_aPFC_SN = double(val_L_aPFC_SN);
val_R_aPFC_SN = double(val_R_aPFC_SN);
val_L_Ins = double(val_L_Ins);
val_R_Ins = double(val_R_Ins);
val_L_lPar_SN = double(val_L_lPar_SN);
val_R_lPar_SN = double(val_R_lPar_SN);
save(sprintf('%s/positions_of_MaxF2s/coords_PCCandPrecuneus.txt',route),"subject","pos_maxPCCandPrecuneus", "val_PCCandPrecuneus",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/coords_mPFC.txt',route),"subject","pos_maxmPFC","val_mPFC",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/coords_LlPar.txt',route),"subject","pos_maxLlPar","val_L_lPar",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/coords_RlPar.txt',route),"subject","pos_maxRlPar","val_R_lPar",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/coords_LiTem.txt',route),"subject","pos_maxLiTem","val_L_iTem",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/coords_RiTem.txt',route),"subject","pos_maxRiTem","val_R_iTem",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/coords_mdThal.txt',route),"subject","pos_maxmdThal","val_mdThal",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/coords_LpCerb.txt',route),"subject","pos_maxLpCerb","val_L_pCerb",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/coords_RpCerb.txt',route),"subject","pos_maxRpCerb","val_R_pCerb",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/coords_dmPFC.txt',route),"subject","pos_maxdmPFC","val_dmPFC",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/coords_LaPFC.txt',route),"subject","pos_maxLaPFC","val_L_aPFC",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/coords_RaPFC.txt',route),"subject","pos_maxRaPFC","val_R_aPFC",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/coords_LsPar.txt',route),"subject","pos_maxLsPar","val_L_sPar",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/coords_RsPar.txt',route),"subject","pos_maxRsPar","val_R_sPar",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/coords_dACC.txt',route),"subject","pos_maxdACC","val_dACC",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/coords_LaPFC_SN.txt',route),"subject","pos_maxLaPFC_SN","val_L_aPFC_SN",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/coords_R_aPFC_SN.txt',route),"subject","pos_maxRaPFC_SN","val_R_aPFC_SN",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/coords_LIns.txt',route),"subject","pos_maxLIns","val_L_Ins",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/coords_RIns.txt',route),"subject","pos_maxRIns","val_R_Ins",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/coords_LlPar_SN.txt',route),"subject","pos_maxLlPar_SN","val_L_lPar_SN",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/coords_RlPar_SN.txt',route),"subject","pos_maxRlPar_SN","val_R_lPar_SN",'-append','-ascii');

mm_pos_maxPCCandPrecuneus = vox2mm(pos_maxPCCandPrecuneus);
mm_pos_maxmPFC = vox2mm(pos_maxmPFC);
mm_pos_maxLlPar = vox2mm(pos_maxLlPar);
mm_pos_maxRlPar = vox2mm(pos_maxRlPar);
mm_pos_maxLiTem = vox2mm(pos_maxLiTem);
mm_pos_maxRiTem = vox2mm(pos_maxRiTem);
mm_pos_maxmdThal = vox2mm(pos_maxmdThal);
mm_pos_maxLpCerb = vox2mm(pos_maxLpCerb);
mm_pos_maxRpCerb = vox2mm(pos_maxRpCerb);
mm_pos_maxdmPFC = vox2mm(pos_maxdmPFC);
mm_pos_maxLaPFC = vox2mm(pos_maxLaPFC);
mm_pos_maxRaPFC = vox2mm(pos_maxRaPFC);
mm_pos_maxLsPar = vox2mm(pos_maxLsPar);
mm_pos_maxRsPar = vox2mm(pos_maxRsPar);
mm_pos_maxdACC = vox2mm(pos_maxdACC);
mm_pos_maxLaPFC_SN = vox2mm(pos_maxLaPFC_SN);
mm_pos_maxRaPFC_SN = vox2mm(pos_maxRaPFC_SN);
mm_pos_maxLIns = vox2mm(pos_maxLIns);
mm_pos_maxRIns = vox2mm(pos_maxRIns);
mm_pos_maxLlPar_SN = vox2mm(pos_maxLlPar_SN);
mm_pos_maxRlPar_SN = vox2mm(pos_maxRlPar_SN);

save(sprintf('%s/positions_of_MaxF2s/mmcoords_PCCandPrecuneus.txt',route),"subject","mm_pos_maxPCCandPrecuneus", "val_PCCandPrecuneus",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/mmcoords_mPFC.txt',route),"subject","mm_pos_maxmPFC","val_mPFC",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/mmcoords_LlPar.txt',route),"subject","mm_pos_maxLlPar","val_L_lPar",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/mmcoords_RlPar.txt',route),"subject","mm_pos_maxRlPar","val_R_lPar",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/mmcoords_LiTem.txt',route),"subject","mm_pos_maxLiTem","val_L_iTem",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/mmcoords_RiTem.txt',route),"subject","mm_pos_maxRiTem","val_R_iTem",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/mmcoords_mdThal.txt',route),"subject","mm_pos_maxmdThal","val_mdThal",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/mmcoords_LpCerb.txt',route),"subject","mm_pos_maxLpCerb","val_L_pCerb",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/mmcoords_RpCerb.txt',route),"subject","mm_pos_maxRpCerb","val_R_pCerb",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/mmcoords_dmPFC.txt',route),"subject","mm_pos_maxdmPFC","val_dmPFC",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/mmcoords_LaPFC.txt',route),"subject","mm_pos_maxLaPFC","val_L_aPFC",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/mmcoords_RaPFC.txt',route),"subject","mm_pos_maxRaPFC","val_R_aPFC",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/mmcoords_LsPar.txt',route),"subject","mm_pos_maxLsPar","val_L_sPar",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/mmcoords_RsPar.txt',route),"subject","mm_pos_maxRsPar","val_R_sPar",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/mmcoords_dACC.txt',route),"subject","mm_pos_maxdACC","val_dACC",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/mmcoords_LaPFC_SN.txt',route),"subject","mm_pos_maxLaPFC_SN","val_L_aPFC_SN",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/mmcoords_R_aPFC_SN.txt',route),"subject","mm_pos_maxRaPFC_SN","val_R_aPFC_SN",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/mmcoords_LIns.txt',route),"subject","mm_pos_maxLIns","val_L_Ins",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/mmcoords_RIns.txt',route),"subject","mm_pos_maxRIns","val_R_Ins",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/mmcoords_LlPar_SN.txt',route),"subject","mm_pos_maxLlPar_SN","val_L_lPar_SN",'-append','-ascii');
save(sprintf('%s/positions_of_MaxF2s/mmcoords_RlPar_SN.txt',route),"subject","mm_pos_maxRlPar_SN","val_R_lPar_SN",'-append','-ascii');

niftInfo_mask = niftiinfo(sprintf('%s/masks/s-rfMRI_f2_mask.nii',route));
niftiwrite(maskIm,sprintf('%s/masks/adjusted_s-rfMRI_f2_mask.nii',route),niftInfo_mask);

%Extract VOIs using SPM jobman
matlabbatch{1}.spm.util.voi.spmmat = {sprintf('%s/models/2glmNR2/SPM.mat',route)};
matlabbatch{1}.spm.util.voi.adjust = NaN;
matlabbatch{1}.spm.util.voi.session = 1;
matlabbatch{1}.spm.util.voi.name = 'PCCandPrecuneus';
matlabbatch{1}.spm.util.voi.roi{1}.sphere.centre = mm_pos_maxPCCandPrecuneus;
matlabbatch{1}.spm.util.voi.roi{1}.sphere.radius = 8;
matlabbatch{1}.spm.util.voi.roi{1}.sphere.move.fixed = 1;
matlabbatch{1}.spm.util.voi.roi{2}.mask.image = {sprintf('%s/masks/adjusted_s-rfMRI_f2_mask.nii,1',route)};
matlabbatch{1}.spm.util.voi.roi{2}.mask.threshold = 0.5;
matlabbatch{1}.spm.util.voi.expression = 'i1&i2';
matlabbatch{2}.spm.util.voi.spmmat = {sprintf('%s/models/2glmNR2/SPM.mat',route)};
matlabbatch{2}.spm.util.voi.adjust = NaN;
matlabbatch{2}.spm.util.voi.session = 1;
matlabbatch{2}.spm.util.voi.name = 'mPFC';
matlabbatch{2}.spm.util.voi.roi{1}.sphere.centre = mm_pos_maxmPFC;
matlabbatch{2}.spm.util.voi.roi{1}.sphere.radius = 8;
matlabbatch{2}.spm.util.voi.roi{1}.sphere.move.fixed = 1;
matlabbatch{2}.spm.util.voi.roi{2}.mask.image = {sprintf('%s/masks/adjusted_s-rfMRI_f2_mask.nii,1',route)};
matlabbatch{2}.spm.util.voi.roi{2}.mask.threshold = 0.5;
matlabbatch{2}.spm.util.voi.expression = 'i1&i2';
matlabbatch{3}.spm.util.voi.spmmat = {sprintf('%s/models/2glmNR2/SPM.mat',route)};
matlabbatch{3}.spm.util.voi.adjust = NaN;
matlabbatch{3}.spm.util.voi.session = 1;
matlabbatch{3}.spm.util.voi.name = 'L_lPar';
matlabbatch{3}.spm.util.voi.roi{1}.sphere.centre = mm_pos_maxLlPar;
matlabbatch{3}.spm.util.voi.roi{1}.sphere.radius = 8;
matlabbatch{3}.spm.util.voi.roi{1}.sphere.move.fixed = 1;
matlabbatch{3}.spm.util.voi.roi{2}.mask.image = {sprintf('%s/masks/adjusted_s-rfMRI_f2_mask.nii,1',route)};
matlabbatch{3}.spm.util.voi.roi{2}.mask.threshold = 0.5;
matlabbatch{3}.spm.util.voi.expression = 'i1&i2';
matlabbatch{4}.spm.util.voi.spmmat = {sprintf('%s/models/2glmNR2/SPM.mat',route)};
matlabbatch{4}.spm.util.voi.adjust = NaN;
matlabbatch{4}.spm.util.voi.session = 1;
matlabbatch{4}.spm.util.voi.name = 'R_lPar';
matlabbatch{4}.spm.util.voi.roi{1}.sphere.centre = mm_pos_maxRlPar;
matlabbatch{4}.spm.util.voi.roi{1}.sphere.radius = 8;
matlabbatch{4}.spm.util.voi.roi{1}.sphere.move.fixed = 1;
matlabbatch{4}.spm.util.voi.roi{2}.mask.image = {sprintf('%s/masks/adjusted_s-rfMRI_f2_mask.nii,1',route)};
matlabbatch{4}.spm.util.voi.roi{2}.mask.threshold = 0.5;
matlabbatch{4}.spm.util.voi.expression = 'i1&i2';
matlabbatch{5}.spm.util.voi.spmmat = {sprintf('%s/models/2glmNR2/SPM.mat',route)};
matlabbatch{5}.spm.util.voi.adjust = NaN;
matlabbatch{5}.spm.util.voi.session = 1;
matlabbatch{5}.spm.util.voi.name = 'L_iTem';
matlabbatch{5}.spm.util.voi.roi{1}.sphere.centre = mm_pos_maxLiTem;
matlabbatch{5}.spm.util.voi.roi{1}.sphere.radius = 8;
matlabbatch{5}.spm.util.voi.roi{1}.sphere.move.fixed = 1;
matlabbatch{5}.spm.util.voi.roi{2}.mask.image = {sprintf('%s/masks/adjusted_s-rfMRI_f2_mask.nii,1',route)};
matlabbatch{5}.spm.util.voi.roi{2}.mask.threshold = 0.5;
matlabbatch{5}.spm.util.voi.expression = 'i1&i2';
matlabbatch{6}.spm.util.voi.spmmat = {sprintf('%s/models/2glmNR2/SPM.mat',route)};
matlabbatch{6}.spm.util.voi.adjust = NaN;
matlabbatch{6}.spm.util.voi.session = 1;
matlabbatch{6}.spm.util.voi.name = 'R_iTem';
matlabbatch{6}.spm.util.voi.roi{1}.sphere.centre = mm_pos_maxRiTem;
matlabbatch{6}.spm.util.voi.roi{1}.sphere.radius = 8;
matlabbatch{6}.spm.util.voi.roi{1}.sphere.move.fixed = 1;
matlabbatch{6}.spm.util.voi.roi{2}.mask.image = {sprintf('%s/masks/adjusted_s-rfMRI_f2_mask.nii,1',route)};
matlabbatch{6}.spm.util.voi.roi{2}.mask.threshold = 0.5;
matlabbatch{6}.spm.util.voi.expression = 'i1&i2';
matlabbatch{7}.spm.util.voi.spmmat = {sprintf('%s/models/2glmNR2/SPM.mat',route)};
matlabbatch{7}.spm.util.voi.adjust = NaN;
matlabbatch{7}.spm.util.voi.session = 1;
matlabbatch{7}.spm.util.voi.name = 'mdThal';
matlabbatch{7}.spm.util.voi.roi{1}.sphere.centre = mm_pos_maxmdThal;
matlabbatch{7}.spm.util.voi.roi{1}.sphere.radius = 6;
matlabbatch{7}.spm.util.voi.roi{1}.sphere.move.fixed = 1;
matlabbatch{7}.spm.util.voi.roi{2}.mask.image = {sprintf('%s/masks/adjusted_s-rfMRI_f2_mask.nii,1',route)};
matlabbatch{7}.spm.util.voi.roi{2}.mask.threshold = 0.5;
matlabbatch{7}.spm.util.voi.expression = 'i1&i2';
matlabbatch{8}.spm.util.voi.spmmat = {sprintf('%s/models/2glmNR2/SPM.mat',route)};
matlabbatch{8}.spm.util.voi.adjust = NaN;
matlabbatch{8}.spm.util.voi.session = 1;
matlabbatch{8}.spm.util.voi.name = 'L_pCerb';
matlabbatch{8}.spm.util.voi.roi{1}.sphere.centre = mm_pos_maxLpCerb;
matlabbatch{8}.spm.util.voi.roi{1}.sphere.radius = 6;
matlabbatch{8}.spm.util.voi.roi{1}.sphere.move.fixed = 1;
matlabbatch{8}.spm.util.voi.roi{2}.mask.image = {sprintf('%s/masks/adjusted_s-rfMRI_f2_mask.nii,1',route)};
matlabbatch{8}.spm.util.voi.roi{2}.mask.threshold = 0.5;
matlabbatch{8}.spm.util.voi.expression = 'i1&i2';
matlabbatch{9}.spm.util.voi.spmmat = {sprintf('%s/models/2glmNR2/SPM.mat',route)};
matlabbatch{9}.spm.util.voi.adjust = NaN;
matlabbatch{9}.spm.util.voi.session = 1;
matlabbatch{9}.spm.util.voi.name = 'R_pCerb';
matlabbatch{9}.spm.util.voi.roi{1}.sphere.centre = mm_pos_maxRpCerb;
matlabbatch{9}.spm.util.voi.roi{1}.sphere.radius = 6;
matlabbatch{9}.spm.util.voi.roi{1}.sphere.move.fixed = 1;
matlabbatch{9}.spm.util.voi.roi{2}.mask.image = {sprintf('%s/masks/adjusted_s-rfMRI_f2_mask.nii,1',route)};
matlabbatch{9}.spm.util.voi.roi{2}.mask.threshold = 0.5;
matlabbatch{9}.spm.util.voi.expression = 'i1&i2';
matlabbatch{10}.spm.util.voi.spmmat = {sprintf('%s/models/2glmNR2/SPM.mat',route)};
matlabbatch{10}.spm.util.voi.adjust = NaN;
matlabbatch{10}.spm.util.voi.session = 1;
matlabbatch{10}.spm.util.voi.name = 'dmPFC';
matlabbatch{10}.spm.util.voi.roi{1}.sphere.centre = mm_pos_maxdmPFC;
matlabbatch{10}.spm.util.voi.roi{1}.sphere.radius = 8;
matlabbatch{10}.spm.util.voi.roi{1}.sphere.move.fixed = 1;
matlabbatch{10}.spm.util.voi.roi{2}.mask.image = {sprintf('%s/masks/adjusted_s-rfMRI_f2_mask.nii,1',route)};
matlabbatch{10}.spm.util.voi.roi{2}.mask.threshold = 0.5;
matlabbatch{10}.spm.util.voi.expression = 'i1&i2';
matlabbatch{11}.spm.util.voi.spmmat = {sprintf('%s/models/2glmNR2/SPM.mat',route)};
matlabbatch{11}.spm.util.voi.adjust = NaN;
matlabbatch{11}.spm.util.voi.session = 1;
matlabbatch{11}.spm.util.voi.name = 'L_aPFC';
matlabbatch{11}.spm.util.voi.roi{1}.sphere.centre =mm_pos_maxLaPFC;
matlabbatch{11}.spm.util.voi.roi{1}.sphere.radius = 8;
matlabbatch{11}.spm.util.voi.roi{1}.sphere.move.fixed = 1;
matlabbatch{11}.spm.util.voi.roi{2}.mask.image = {sprintf('%s/masks/adjusted_s-rfMRI_f2_mask.nii,1',route)};
matlabbatch{11}.spm.util.voi.roi{2}.mask.threshold = 0.5;
matlabbatch{11}.spm.util.voi.expression = 'i1&i2';
matlabbatch{12}.spm.util.voi.spmmat = {sprintf('%s/models/2glmNR2/SPM.mat',route)};
matlabbatch{12}.spm.util.voi.adjust = NaN;
matlabbatch{12}.spm.util.voi.session = 1;
matlabbatch{12}.spm.util.voi.name = 'R_aPFC';
matlabbatch{12}.spm.util.voi.roi{1}.sphere.centre = mm_pos_maxRaPFC;
matlabbatch{12}.spm.util.voi.roi{1}.sphere.radius = 8;
matlabbatch{12}.spm.util.voi.roi{1}.sphere.move.fixed = 1;
matlabbatch{12}.spm.util.voi.roi{2}.mask.image = {sprintf('%s/masks/adjusted_s-rfMRI_f2_mask.nii,1',route)};
matlabbatch{12}.spm.util.voi.roi{2}.mask.threshold = 0.5;
matlabbatch{12}.spm.util.voi.expression = 'i1&i2';
matlabbatch{13}.spm.util.voi.spmmat = {sprintf('%s/models/2glmNR2/SPM.mat',route)};
matlabbatch{13}.spm.util.voi.adjust = NaN;
matlabbatch{13}.spm.util.voi.session = 1;
matlabbatch{13}.spm.util.voi.name = 'L_sPar';
matlabbatch{13}.spm.util.voi.roi{1}.sphere.centre = mm_pos_maxLsPar;
matlabbatch{13}.spm.util.voi.roi{1}.sphere.radius = 8;
matlabbatch{13}.spm.util.voi.roi{1}.sphere.move.fixed = 1;
matlabbatch{13}.spm.util.voi.roi{2}.mask.image = {sprintf('%s/masks/adjusted_s-rfMRI_f2_mask.nii,1',route)};
matlabbatch{13}.spm.util.voi.roi{2}.mask.threshold = 0.5;
matlabbatch{13}.spm.util.voi.expression = 'i1&i2';
matlabbatch{14}.spm.util.voi.spmmat = {sprintf('%s/models/2glmNR2/SPM.mat',route)};
matlabbatch{14}.spm.util.voi.adjust = NaN;
matlabbatch{14}.spm.util.voi.session = 1;
matlabbatch{14}.spm.util.voi.name = 'R_sPar';
matlabbatch{14}.spm.util.voi.roi{1}.sphere.centre = mm_pos_maxRsPar;
matlabbatch{14}.spm.util.voi.roi{1}.sphere.radius = 8;
matlabbatch{14}.spm.util.voi.roi{1}.sphere.move.fixed = 1;
matlabbatch{14}.spm.util.voi.roi{2}.mask.image = {sprintf('%s/masks/adjusted_s-rfMRI_f2_mask.nii,1',route)};
matlabbatch{14}.spm.util.voi.roi{2}.mask.threshold = 0.5;
matlabbatch{14}.spm.util.voi.expression = 'i1&i2';
matlabbatch{15}.spm.util.voi.spmmat = {sprintf('%s/models/2glmNR2/SPM.mat',route)};
matlabbatch{15}.spm.util.voi.adjust = NaN;
matlabbatch{15}.spm.util.voi.session = 1;
matlabbatch{15}.spm.util.voi.name = 'dACC';
matlabbatch{15}.spm.util.voi.roi{1}.sphere.centre = mm_pos_maxdACC;
matlabbatch{15}.spm.util.voi.roi{1}.sphere.radius = 8;
matlabbatch{15}.spm.util.voi.roi{1}.sphere.move.fixed = 1;
matlabbatch{15}.spm.util.voi.roi{2}.mask.image = {sprintf('%s/masks/adjusted_s-rfMRI_f2_mask.nii,1',route)};
matlabbatch{15}.spm.util.voi.roi{2}.mask.threshold = 0.5;
matlabbatch{15}.spm.util.voi.expression = 'i1&i2';
matlabbatch{16}.spm.util.voi.spmmat = {sprintf('%s/models/2glmNR2/SPM.mat',route)};
matlabbatch{16}.spm.util.voi.adjust = NaN;
matlabbatch{16}.spm.util.voi.session = 1;
matlabbatch{16}.spm.util.voi.name = 'L_aPFC_SN';
matlabbatch{16}.spm.util.voi.roi{1}.sphere.centre = mm_pos_maxLaPFC_SN;
matlabbatch{16}.spm.util.voi.roi{1}.sphere.radius = 8;
matlabbatch{16}.spm.util.voi.roi{1}.sphere.move.fixed = 1;
matlabbatch{16}.spm.util.voi.roi{2}.mask.image = {sprintf('%s/masks/adjusted_s-rfMRI_f2_mask.nii,1',route)};
matlabbatch{16}.spm.util.voi.roi{2}.mask.threshold = 0.5;
matlabbatch{16}.spm.util.voi.expression = 'i1&i2';
matlabbatch{17}.spm.util.voi.spmmat = {sprintf('%s/models/2glmNR2/SPM.mat',route)};
matlabbatch{17}.spm.util.voi.adjust = NaN;
matlabbatch{17}.spm.util.voi.session = 1;
matlabbatch{17}.spm.util.voi.name = 'R_aPFC_SN';
matlabbatch{17}.spm.util.voi.roi{1}.sphere.centre = mm_pos_maxRaPFC_SN;
matlabbatch{17}.spm.util.voi.roi{1}.sphere.radius = 8;
matlabbatch{17}.spm.util.voi.roi{1}.sphere.move.fixed = 1;
matlabbatch{17}.spm.util.voi.roi{2}.mask.image = {sprintf('%s/masks/adjusted_s-rfMRI_f2_mask.nii,1',route)};
matlabbatch{17}.spm.util.voi.roi{2}.mask.threshold = 0.5;
matlabbatch{17}.spm.util.voi.expression = 'i1&i2';
matlabbatch{18}.spm.util.voi.spmmat = {sprintf('%s/models/2glmNR2/SPM.mat',route)};
matlabbatch{18}.spm.util.voi.adjust = NaN;
matlabbatch{18}.spm.util.voi.session = 1;
matlabbatch{18}.spm.util.voi.name = 'L_Ins';
matlabbatch{18}.spm.util.voi.roi{1}.sphere.centre = mm_pos_maxLIns;
matlabbatch{18}.spm.util.voi.roi{1}.sphere.radius = 8;
matlabbatch{18}.spm.util.voi.roi{1}.sphere.move.fixed = 1;
matlabbatch{18}.spm.util.voi.roi{2}.mask.image = {sprintf('%s/masks/adjusted_s-rfMRI_f2_mask.nii,1',route)};
matlabbatch{18}.spm.util.voi.roi{2}.mask.threshold = 0.5;
matlabbatch{18}.spm.util.voi.expression = 'i1&i2';
matlabbatch{19}.spm.util.voi.spmmat = {sprintf('%s/models/2glmNR2/SPM.mat',route)};
matlabbatch{19}.spm.util.voi.adjust = NaN;
matlabbatch{19}.spm.util.voi.session = 1;
matlabbatch{19}.spm.util.voi.name = 'R_Ins';
matlabbatch{19}.spm.util.voi.roi{1}.sphere.centre = mm_pos_maxRIns;
matlabbatch{19}.spm.util.voi.roi{1}.sphere.radius = 8;
matlabbatch{19}.spm.util.voi.roi{1}.sphere.move.fixed = 1;
matlabbatch{19}.spm.util.voi.roi{2}.mask.image = {sprintf('%s/masks/adjusted_s-rfMRI_f2_mask.nii,1',route)};
matlabbatch{19}.spm.util.voi.roi{2}.mask.threshold = 0.5;
matlabbatch{19}.spm.util.voi.expression = 'i1&i2';
matlabbatch{20}.spm.util.voi.spmmat = {sprintf('%s/models/2glmNR2/SPM.mat',route)};
matlabbatch{20}.spm.util.voi.adjust = NaN;
matlabbatch{20}.spm.util.voi.session = 1;
matlabbatch{20}.spm.util.voi.name = 'L_lPar_SN';
matlabbatch{20}.spm.util.voi.roi{1}.sphere.centre = mm_pos_maxLlPar_SN;
matlabbatch{20}.spm.util.voi.roi{1}.sphere.radius = 8;
matlabbatch{20}.spm.util.voi.roi{1}.sphere.move.fixed = 1;
matlabbatch{20}.spm.util.voi.roi{2}.mask.image = {sprintf('%s/masks/adjusted_s-rfMRI_f2_mask.nii,1',route)};
matlabbatch{20}.spm.util.voi.roi{2}.mask.threshold = 0.5;
matlabbatch{20}.spm.util.voi.expression = 'i1&i2';
matlabbatch{21}.spm.util.voi.spmmat = {sprintf('%s/models/2glmNR2/SPM.mat',route)};
matlabbatch{21}.spm.util.voi.adjust = NaN;
matlabbatch{21}.spm.util.voi.session = 1;
matlabbatch{21}.spm.util.voi.name = 'R_lPar_SN';
matlabbatch{21}.spm.util.voi.roi{1}.sphere.centre = mm_pos_maxRlPar_SN;
matlabbatch{21}.spm.util.voi.roi{1}.sphere.radius = 8;
matlabbatch{21}.spm.util.voi.roi{1}.sphere.move.fixed = 1;
matlabbatch{21}.spm.util.voi.roi{2}.mask.image = {sprintf('%s/masks/adjusted_s-rfMRI_f2_mask.nii,1',route)};
matlabbatch{21}.spm.util.voi.roi{2}.mask.threshold = 0.5;
matlabbatch{21}.spm.util.voi.expression = 'i1&i2';
spm_jobman('run',matlabbatch)
