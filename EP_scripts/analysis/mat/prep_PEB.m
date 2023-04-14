%prepare PEB data structure
%(depends on running prepDataStructure script first)
%From table of subject data store DCMs as cell

GCM = cell(num_subs,1); 
desMat = zeros(num_subs,2);
for s=1:num_subs
    GCM{s,1} = joinedTable.Var1(s,1).DCM;
    if string(joinedTable.sex(s)) == "F"
        desMat(s,1) = 1;
    end
    if string(joinedTable.phenotype(s)) == "Patient"
        desMat(s,2) = 1;
    end
end
%Define design matrix based on covariates of interest
col1 = ones(num_subs,1);
desMat = horzcat(col1,desMat);

%All other values of M take their defaults as defined in spm_dcm_peb.m
M.X = desMat;
M.Q = 'single';
M.Xnames = {'X0','fm','pc'};

[PEB, P] = spm_dcm_peb(GCM,M);

%Write PEB structure and GCM ('P') to file 
save("/home/corey/Desktop/fm_pc_PEB.mat",'PEB','P')
