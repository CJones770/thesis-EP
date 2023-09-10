%prepare PEB data structure
%(depends on running prepDataStructure script first)
%From table of subject data store DCMs as cell

GCM1 = cell(num_subs,1); 
GCM2 = cell(num_subs,1);
desMat = zeros(num_subs,1);
for s=1:num_subs
    GCM1{s,1} = joinedTable.Var1(s,1).DCM;
    GCM2{s,1} = joinedTable.Var2(s,1).DCM;
    %if string(joinedTable.sex(s)) == "F"
    %    desMat(s,2) = 1;
    %end
    if string(joinedTable.phenotype_description(s)) == "Non-affective psychosis"
        desMat(s,1) = 1;
    end
    %desMat(s,3) = joinedTable.apd_date_equiv(s);

    %Uncomment above lines in block to control for subject sex and medication status.
end

%Define design matrix based on covariates of interest
col1 = ones(num_subs,1);
desMat = horzcat(col1,desMat);

%Define M using 'single' precision (See spm_dcm_peb in SPM12 for details)
M.X = desMat;
M.Q = 'single';
M.Xnames = {'X0','non-aff'}; %,'sex','chlr_eq'};

[PEB1, P1] = spm_dcm_peb(GCM1,M);
[PEB2, P2] = spm_dcm_peb(GCM2,M);

%Write PEB structure and subject-wise estimates ('P') to files 
%save('/media/corey/4TB-WDBlue/data-thesis/fMRI/bmrs/naff_PEB1.mat','PEB1')
%save('/media/corey/4TB-WDBlue/data-thesis/fMRI/bmrs/naff_PEB2.mat','PEB2')
%save('/media/corey/4TB-WDBlue/data-thesis/fMRI/bmrs/naff_P1_n1015.mat','P1','P2','-v7.3')


%To-do for generalizability:
%Import list of variables of interest
%Develop arbitrary variable specification compatibility
