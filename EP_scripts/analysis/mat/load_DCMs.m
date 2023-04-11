%Load DCM output files
subjectlist = fopen(sprintf('%s',pathList));
subject_num_string = textscan(subjectlist,'%s');
subject_num = str2double(subject_num_string{1,1});
subject_num=transpose(subject_num);
fclose(subjectlist);
subTable = readtable(sprintf('%s',pathInfo));
num_subs=numel(subject_num);
DCM_array = cell(num_subs,3);
%Load DCM.mat files and store in cell array
for idx=1:num_subs
    curr_sub=subject_num(idx);
    DCM_array{idx,1} = open(sprintf("%s/%d%s/%s/models/glmNR/DCM_21Roi.mat",pathDir,curr_sub,suff,encdir));
    DCM_array{idx,2} = open(sprintf("%s/%d%s/%s/models/glmNR/DCM_21Roi.mat",pathDir,curr_sub,suff,encdir));
    DCM_array{idx,3} = curr_sub;
end

num_ROIs = length(DCM_array{1,1}.DCM.xY); 

%Remove subjects from loaded table not represented in DCM array
subs_in_table = subTable{:,"src_subject_id"};
boolIn = ismember(subs_in_table,subject_num);
for idx=1:numel(subs_in_table)
    if boolIn(idx) == false
    empty_sub = subs_in_table(idx);
    [ia, ~] = ismember(string(subTable.src_subject_id),string({empty_sub}));
    subTable(ia,:) = [];
    end
end

%Sort resulting table of subject info and DCM array by subject ID
%Here, the 5 is hardcoded as it represents the subject ID variable
%In the subject information text file I am using
%Replace 5 with the column your subject ID is in if appropriate
sortedTable = sortrows(subTable,5);
sortedDCM = sortrows(DCM_array,3);

joinedTable = horzcat(sortedDCM,sortedTable);

subs_in_table = joinedTable{:,"src_subject_id"};

Male = 'M';
Female = 'F';
[ia, ~] = ismember(joinedTable.sex,{Male});
femTable = joinedTable;
menTable = joinedTable;
femTable(ia,:) = [];

[ia, ~] = ismember(joinedTable.sex,{Female});
menTable(ia,:) = [];



	
