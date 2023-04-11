%%Group by gender and scanning site by creating sub-tables (starting with sites Indiana university and McLean Hospital)
%Calculate sample statistics for each group
%To be run after running Load_DCM.m script in same directory
num_subs = numel(joinedTable.sex);
numFem = numel(femTable.sex);
numMen = numel(menTable.sex);
numROIs = numel(joinedTable.Var1(1,1).DCM.xY);
%Set up data structures for storing descriptive statistics
femAverage_EC = zeros(num_ROIs,num_ROIs);
menAverage_EC = zeros(num_ROIs,num_ROIs);
femStdv_EC = zeros(num_ROIs,num_ROIs);
menStdv_EC = zeros(num_ROIs,num_ROIs);
%Store DCM data in compiled fashion to make calculations simpler
fem_compiled_EC_post1 = size(numFem,num_ROIs,num_ROIs);
fem_compiled_EC_post2 = size(numFem,num_ROIs,num_ROIs);

men_compiled_EC_post1 = size(numMen,num_ROIs,num_ROIs);
men_compiled_EC_post2 = size(numMen,num_ROIs,num_ROIs);


for idx=1:numFem
    for r=1:num_ROIs
        for c=1:num_ROIs
        fem_compiled_EC_post1(idx,r,c)= femTable.Var1(idx,1).DCM.Ep.A(r,c);
        fem_compiled_EC_post2(idx,r,c)= femTable.Var2(idx,1).DCM.Ep.A(r,c);
        end
    end
end

for idx=1:numMen
    for r=1:num_ROIs
        for c=1:num_ROIs
        men_compiled_EC_post1(idx,r,c)= menTable.Var1(idx,1).DCM.Ep.A(r,c);
        men_compiled_EC_post2(idx,r,c)= menTable.Var2(idx,1).DCM.Ep.A(r,c);
        end
    end
end
FC_cell = {};
FNA_cell = {};
FAFF_cell = {};
for s=1:numFem
    if string(femTable.phenotype_description{s}) == 'In good health' %ismember(femTable.src_subject_id(s),controls)
        FC_cell{end+1,1} = fem_compiled_EC_post1(s,:,:);
        FC_cell{end,2} = fem_compiled_EC_post2(s,:,:);
    elseif string(femTable.phenotype_description{s}) == 'Non-affective psychosis' %ismember(subject_num(s),NonAff)
        FNA_cell{end+1,1} = fem_compiled_EC_post1(s,:,:);
        FNA_cell{end,2} = fem_compiled_EC_post2(s,:,:);
    elseif string(femTable.phenotype_description{s}) == 'Affective psychosis' %ismember(subject_num(s),Affective)
        FAFF_cell{end+1,1} = fem_compiled_EC_post1(s,:,:);
        FAFF_cell{end,2} = fem_compiled_EC_post2(s,:,:);
    end
end
MC_cell = {};
MNA_cell = {};
MAFF_cell = {};
for s=1:numMen
    if string(menTable.phenotype_description{s}) == 'In good health' %ismember(femTable.src_subject_id(s),controls)
        MC_cell{end+1,1} = men_compiled_EC_post1(s,:,:);
        MC_cell{end,2} = men_compiled_EC_post2(s,:,:);
    elseif string(menTable.phenotype_description{s}) == 'Non-affective psychosis' %ismember(subject_num(s),NonAff)
        MNA_cell{end+1,1} = men_compiled_EC_post1(s,:,:);
        MNA_cell{end,2} = men_compiled_EC_post2(s,:,:);
    elseif string(menTable.phenotype_description{s}) == 'Affective psychosis' %ismember(subject_num(s),Affective)
        MAFF_cell{end+1,1} = men_compiled_EC_post1(s,:,:);
        MAFF_cell{end,2} = men_compiled_EC_post2(s,:,:);
    end
end

%Define number of subjects in each gender and group
num_FC = numel(FC_cell(:,1));
num_FNA = numel(FNA_cell(:,1));
num_FAFF = numel(FAFF_cell(:,1));
num_MC = numel(MC_cell(:,1));
num_MNA = numel(MNA_cell(:,1));
num_MAFF = numel(MAFF_cell(:,1));
%Consolidate their individual EC matrices into one sxrxr matrix each
cons_FC = zeros(num_FC,numROIs,numROIs);
cons_FNA = zeros(num_FNA,numROIs,numROIs);
cons_FAFF = zeros(num_FAFF,numROIs,numROIs);
cons_MC = zeros(num_MC,numROIs,numROIs);
cons_MNA = zeros(num_MNA,numROIs,numROIs);
cons_MAFF = zeros(num_MAFF,numROIs,numROIs);
for s=1:num_FC
    cons_FC(s,:,:) = FC_cell{s,1};
end
for s=1:num_FNA
    cons_FNA(s,:,:) = FNA_cell{s,1};
end
for s=1:num_FAFF
    cons_FAFF(s,:,:) = FAFF_cell{s,1};
end
for s=1:num_MC
    cons_MC(s,:,:) = MC_cell{s,1};
end
for s=1:num_MNA
    cons_MNA(s,:,:) = MNA_cell{s,1};
end
for s=1:num_MAFF
    cons_MAFF(s,:,:) = MAFF_cell{s,1};
end

%Calculate averages & stdv of EC for Male Control & Non-Affective
%Repeat for female control and affective

%Starting by comparing all females vs all males
for r=1:numROIs
    for c=1:numROIs
        femAverage_EC(r,c) = mean(fem_compiled_EC_post1(:,r,c));
        menAverage_EC(r,c) = mean(men_compiled_EC_post1(:,r,c));
        femStdv_EC(r,c) = std(fem_compiled_EC_post1(:,r,c));
        menStdv_EC(r,c) = std(men_compiled_EC_post1(:,r,c));
    end
end

diffMenWmn = femAverage_EC - menAverage_EC;
%In this case, the variance heavily outweighs the mean values (3 fold),
%Therefore, it is impossible to conclude that there is a statistically
%Significant difference in EC between men and women

%It is likely that the classical statistics are not the most appropriate
%Method for assessing differences between groups, and that Bayesian
%statistics should be utilized instead (as is prevalent in Literature)

%for r=1:num_ROIs
%    for c=1:num_ROIs
%    femAverage_EC(r,c) = mean(femTable.Var1(1,1).DCM.Ep.A(r,c));
%    end
%end