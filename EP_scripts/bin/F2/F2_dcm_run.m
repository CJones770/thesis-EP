clear("matlabbatch")

spmFile2 = load(sprintf('%s/models/2glmNR2/SPM.mat',route));

SPM2 = spmFile2.SPM;
%Essentially, the function used within spm (spm_dcm_specify(_ui).m is 
%recreated without reliance on the ui, unrestricting
%automation/unsupervised iteration

vois2 = {load(sprintf('%s/models/2glmNR2/VOI_PCCandPrecuneus_1.mat',route)), ...
	load(sprintf('%s/models/2glmNR2/VOI_mPFC_1.mat',route)), ...
        load(sprintf('%s/models/2glmNR2/VOI_mdThal_1.mat',route)), ...
        load(sprintf('%s/models/2glmNR2/VOI_L_lPar_1.mat',route)), ...
        load(sprintf('%s/models/2glmNR2/VOI_R_lPar_1.mat',route)), ...
        load(sprintf('%s/models/2glmNR2/VOI_L_iTem_1.mat',route)), ...
        load(sprintf('%s/models/2glmNR2/VOI_R_iTem_1.mat',route)), ...
        load(sprintf('%s/models/2glmNR2/VOI_L_pCerb_1.mat',route)), ...
        load(sprintf('%s/models/2glmNR2/VOI_R_pCerb_1.mat',route)), ...
        load(sprintf('%s/models/2glmNR2/VOI_dmPFC_1.mat',route)), ...
        load(sprintf('%s/models/2glmNR2/VOI_L_aPFC_1.mat',route)), ...
        load(sprintf('%s/models/2glmNR2/VOI_R_aPFC_1.mat',route)), ...
        load(sprintf('%s/models/2glmNR2/VOI_L_sPar_1.mat',route)), ...
        load(sprintf('%s/models/2glmNR2/VOI_R_sPar_1.mat',route)), ...
        load(sprintf('%s/models/2glmNR2/VOI_dACC_1.mat',route)), ...
        load(sprintf('%s/models/2glmNR2/VOI_L_aPFC_SN_1.mat',route)), ...
        load(sprintf('%s/models/2glmNR2/VOI_R_aPFC_SN_1.mat',route)), ...
        load(sprintf('%s/models/2glmNR2/VOI_L_Ins_1.mat',route)), ...
        load(sprintf('%s/models/2glmNR2/VOI_R_Ins_1.mat',route)), ...
        load(sprintf('%s/models/2glmNR2/VOI_L_lPar_SN_1.mat',route)), ...
        load(sprintf('%s/models/2glmNR2/VOI_R_lPar_SN_1.mat',route))};

v = SPM2.nscan;
n = length(vois2);
%Given the focus on rsfMRI only, we can define U 
%(the exogenous input matrix) as being null (as done in the original script)
U = struct();
U.u = zeros(length(vois2),1);
U.name = {'null'};
U.idx = 0;

RT = SPM2.xY.RT;
TE = 0.037; %(seconds) as per HCP specification
delays = ones(n);

options = struct();
%True/False / 1/0 choice between the following model specifications
options.nonlinear = 1; 
options.two_state = 1;
options.stochastic = 0;
options.centre = 0;
options.induced = 1;

a = ones(n,n); %Full connectivity matrix
b = zeros(n,n); %No prior specifications (b & c)
c = zeros(n);
d = zeros(n,n,n); %No nonlinear modularities

Y2 = struct();
Y2.dt = RT;
Y2.X0 = vois2{1,1}.xY.X0;

for l=1:n
    Y2.y(:,l) = vois2{1,l}.xY.u;
    Y2.name{l} = vois2{1,l}.xY.name;
    xY2(l) = vois2{1,l}.xY;
end

DCM2 = struct();
DCM2.a = a;
DCM2.b = b;
DCM2.c = c;
DCM2.d = d;
DCM2.U = U;
DCM2.Y = Y2;
DCM2.xY = xY2;
DCM2.v = v;
DCM2.n = n;
DCM2.TE = TE;
DCM2.delays = delays;
DCM2.options = options;

DCM = spm_dcm_fmri_csd(DCM2);
filename2 = sprintf('%s/models/2glmNR2/DCM_21Roi.mat',route);
save(filename2,"DCM")
