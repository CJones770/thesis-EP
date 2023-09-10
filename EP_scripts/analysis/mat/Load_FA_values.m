%Load FA values

%Average weighted tract density in ICs from O'muircheartaigh paper
subject_list_dti = load('/media/corey/4TB-WDBlue/data-thesis/subsWithDTI.txt');
num_subs_dti = numel(subject_list_dti);


for n=1:num_subs_dti
    if ismember(subject_list_dti(n),subs_in_table) == false
        subject_list_dti(n) = 0;
    end
end

new_dti_list = subject_list_dti(~(subject_list_dti==0),:);
new_num_subs_dti = numel(new_dti_list);

FA_data_struct = cell(new_num_subs_dti,50);
for n=1:new_num_subs_dti
    for t=0:49
        curr_sub = new_dti_list(n);
        FA_data = niftiread(sprintf('/media/corey/2_4TB-WDBlue/DTI_merged_data/%d/4o/averageFAs/Omuircheartaigh/tract_%d_wt.nii',curr_sub,t));
        FA_data_struct{n,t+1} = max(FA_data,[],'all');
    end
end

