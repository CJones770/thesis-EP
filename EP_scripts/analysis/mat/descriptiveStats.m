%Descriptive statistics

%Load subject list:
subjectlist = fopen('/media/corey/4TB-WDBlue/data-thesis/subject_list_2analyze.txt');
subject_num_string = textscan(subjectlist,'%s');
subject_num = str2double(subject_num_string{1,1});
subject_num=transpose(subject_num);
fclose(subjectlist);
num_subs=numel(subject_num);
DCM_array = cell(num_subs,2);
%Load DCM.mat files and store in cell array
for idx=1:num_subs
    curr_sub=subject_num(idx);
    DCM_array{idx,1} = open(sprintf("/media/corey/4TB-WDBlue/data-thesis/fMRI/Rapidtide/%d_01_MR/PA/models/glmNR/DCM_21Roi.mat",curr_sub));
    DCM_array{idx,2} = open(sprintf("/media/corey/4TB-WDBlue/data-thesis/fMRI/Rapidtide/%d_01_MR/PA/models/glmNR2/DCM_21Roi.mat",curr_sub));
end
num_ROIs = length(DCM_array{1,1}.DCM.xY); 

%Calculate mean and std dev of posterior expectiation of EC values

compiled_EC_post1 = size(num_subs,num_ROIs,num_ROIs);
compiled_EC_post2 = size(num_subs,num_ROIs,num_ROIs);
for idx=1:num_subs
    for r=1:num_ROIs
        for c=1:num_ROIs
        compiled_EC_post1(idx,r,c)= DCM_array{idx,1}.DCM.Ep.A(r,c);
        compiled_EC_post2(idx,r,c)= DCM_array{idx,2}.DCM.Ep.A(r,c);
        end
    end
end


%Difference in means
difference_abs = compiled_EC_post1 - compiled_EC_post2;
mean_diff_array = size(num_ROIs,num_ROIs);
stdev_diff = size(num_ROIs,num_ROIs);
for r=1:num_ROIs
    for c=1:num_ROIs
        mean_diff_array(r,c) = mean(difference_abs(:,r,c));
        stdev_diff(r,c) = std(difference_abs(:,r,c));
    end   
end

%Difference in medians
median_diff_array = size(num_ROIs,num_ROIs);
Qrt1 = size(num_ROIs,num_ROIs);
Qrt3 = size(num_ROIs,num_ROIs);
for r=1:num_ROIs
    for c=1:num_ROIs
    median_diff_array(r,c) = median(difference_abs(:,r,c));
    Qrt1(r,c) = prctile(difference_abs(:,r,c),25);
    Qrt3(r,c) = prctile(difference_abs(:,r,c),75);
    end
end
IQR_diff = Qrt3 - Qrt1;

controllist = fopen('/media/corey/4TB-WDBlue/data-thesis/Control_SubList.txt');
control_num_string = textscan(controllist,'%s');
control_num = str2double(control_num_string{1,1});
control_num=transpose(control_num);
fclose(controllist);

patientlist_NA = fopen('/media/corey/4TB-WDBlue/data-thesis/NA_psychList.txt');
patient_num_string_NA = textscan(patientlist_NA,'%s');
patient_num_NA = str2double(patient_num_string_NA{1,1});
patient_num_NA = transpose(patient_num_NA);
fclose(patientlist_NA);

patientlist_AFF = fopen('/media/corey/4TB-WDBlue/data-thesis/Aff_psychList.txt');
pat_string = textscan(patientlist_AFF,'%s');
patient_num_AFF = str2double(pat_string{1,1});
patient_num_AFF = transpose(patient_num_AFF);
fclose(patientlist_AFF);

membership_cell = size(subject_num,3);
for idx=1:num_subs
    if ismember(subject_num(idx),control_num)
        membership_cell(idx,1) = subject_num(idx);
    elseif ismember(subject_num(idx),patient_num_NA)
        membership_cell(idx,2) = subject_num(idx);
    elseif ismember(subject_num(idx),patient_num_AFF)
        membership_cell(idx,3) = subject_num(idx);
    end
end
%C_group = ismember(subject_num, control_num);
%NA_group= ismember(subject_num,patient_num_NA);
%AFF_group = ismember(subject_num,patient_num_AFF);

num_C = nnz(membership_cell(:,1));
num_NA = nnz(membership_cell(:,2));
num_AFF = nnz(membership_cell(:,3));

controls = nonzeros(membership_cell(:,1));
NonAff = nonzeros(membership_cell(:,2));
Affective = nonzeros(membership_cell(:,3));

compil_EC_C1 = zeros(num_C,num_ROIs,num_ROIs);
compil_EC_NA1 = zeros(num_NA,num_ROIs,num_ROIs);
compil_EC_AFF1 = zeros(num_AFF,num_ROIs,num_ROIs);
compil_EC_C2 = zeros(num_C,num_ROIs,num_ROIs);
compil_EC_NA2 = zeros(num_NA,num_ROIs,num_ROIs);
compil_EC_AFF2 = zeros(num_AFF,num_ROIs,num_ROIs);

C_cell = {};%cell(numel(controls),2);
NA_cell = {};
AFF_cell = {};
for s=1:num_subs   
    if ismember(subject_num(s),controls)
        C_cell{end+1,1} = compiled_EC_post1(s,:,:);
        C_cell{end,2} = compiled_EC_post2(s,:,:);
    elseif ismember(subject_num(s),NonAff)
        NA_cell{end+1,1} = compiled_EC_post1(s,:,:);
        NA_cell{end,2} = compiled_EC_post2(s,:,:);
    elseif ismember(subject_num(s),Affective)
        AFF_cell{end+1,1} = compiled_EC_post1(s,:,:);
        AFF_cell{end,2} = compiled_EC_post2(s,:,:);
    end
end

for s=1:num_C
    compil_EC_C1(s,:,:) = C_cell{s,1};
    compil_EC_C2(s,:,:) = C_cell{s,2};
end
for s=1:num_NA
    compil_EC_NA1(s,:,:) = NA_cell{s,1};
    compil_EC_NA2(s,:,:) = NA_cell{s,2};
end
for s=1:num_AFF
    compil_EC_AFF1(s,:,:) = AFF_cell{s,1};
    compil_EC_AFF2(s,:,:) = AFF_cell{s,2};
end
mean_C1 = zeros(num_ROIs,num_ROIs);
mean_C2 = zeros(num_ROIs,num_ROIs);
mean_N1 = zeros(num_ROIs,num_ROIs);
mean_N2 = zeros(num_ROIs,num_ROIs);
stdv_C1 = zeros(num_ROIs,num_ROIs);
stdv_C2 = zeros(num_ROIs,num_ROIs);
stdv_N1 = zeros(num_ROIs,num_ROIs);
stdv_N2 = zeros(num_ROIs,num_ROIs);
diff_means_1 = zeros(num_ROIs,num_ROIs);
diff_means_2 = zeros(num_ROIs,num_ROIs);
for r=1:num_ROIs
    for c=1:num_ROIs
        mean_C1(r,c) = mean(compil_EC_C1(:,r,c));
        mean_C2(r,c) = mean(compil_EC_C2(:,r,c));
        mean_N1(r,c) = mean(compil_EC_NA1(:,r,c));
        mean_N2(r,c) = mean(compil_EC_NA2(:,r,c));
        stdv_C1(r,c) = std(compil_EC_C1(:,r,c));
        stdv_C2(r,c) = std(compil_EC_C2(:,r,c));
        stdv_N1(r,c) = std(compil_EC_NA1(:,r,c));
        stdv_N2(r,c) = std(compil_EC_NA2(:,r,c));
        diff_means_1(r,c) = mean_C1(r,c) - mean_N1(r,c);
        diff_means_2(r,c) = mean_C2(r,c) - mean_N2(r,c);
    end
end





%for s=1:num_subs
%    for r=1:num_ROIs
%        for c=1:num_ROIs
%            if ismember(subject_num(s),controls)
%              compil_EC_C1(s,r,c) = compiled_EC_post1(s,r,c);
%              compil_EC_C2(s,r,c) = compiled_EC_post2(s,r,c);  
%            elseif ismember(subject_num(s),NonAff)
%              compil_EC_NA1(s,r,c) = compiled_EC_post1(s,r,c);
%              compil_EC_NA1(s,r,c) = compiled_EC_post2(s,r,c);
%            elseif ismember(subject_num(s),Affective)
%              compil_EC_AFF1(s,r,c) = compiled_EC_post1(s,r,c);
%              compil_EC_AFF2(s,r,c) = compiled_EC_post2(s,r,c);
%            end
%        end
%    end
%end
