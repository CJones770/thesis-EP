%prepare PEB data structure
%(depends on running prepDataStructure script first)
%From table of subject data store DCMs as cell

GCM = cell(num_subs,2); 
desMat = zeros(num_subs,3);
for s=1:num_subs
    GCM{s,1} = joinedTable.Var1(s,1).DCM;
    GCM{s,2} = joinedTable.Var2(s,1).DCM;
    if string(joinedTable.sex(s)) == "F"
        desMat(s,1) = 1;
    end
    if string(joinedTable.phenotype_description(s)) == "Non-affective psychosis"
        desMat(s,2) = 1;
    end
    if string(joinedTable.phenotype_description(s)) == "Affective psychosis"
        desMat(s,3) = 1;
    end
end
%Define design matrix based on covariates of interest
col1 = ones(num_subs,1);
desMat = horzcat(col1,desMat);

%All other values of M take their defaults as defined in spm_dcm_peb.m
M.X = desMat;
M.Q = 'single';
M.Xnames = {'X0','fm','non-aff','aff'};

[PEB, P] = spm_dcm_peb(GCM,M);

%Write PEB structure and GCM ('P') to file 
save("/home/corey/Desktop/fm_naff_aff_PEB.mat",'PEB')

%To-do
%Import list of variables of interest
%Develop arbitrary variable specification compatibility

%user specified list -> use numel(varlist) & unique(varlist) to specify
%design matrix and output description of which beta values refer to 
%which value a given covariate takes
