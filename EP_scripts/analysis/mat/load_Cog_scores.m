%Load cognitive data and create matrix using values from 'good' subjects
file = '/media/corey/4TB-WDBlue/data-thesis/cognitive_data_251.csv';
clin_file = '/home/corey/Downloads/subject_DATA_backup.xlsx';

cog_data = readtable(file);
clin_data = readtable(clin_file);
Nsubs = height(cog_data);

for n=1:Nsubs
    if ismember(cog_data.Var1(n),subs_in_table) == false
        cog_data.Var1(n) = 0;
    end
    if ismember(clin_data.Var5(n),subs_in_table) == false
        clin_data.Var5(n) = 0;
    end
end
 
new_cog_data = cog_data(~(cog_data.Var1 == 0),:);
new_clin_data = clin_data(~(clin_data.Var5 == 0),:);

no_nan_table = new_cog_data(~any(ismissing(new_cog_data),2),:);
no_na_clin_table = new_clin_data(~any(ismissing(new_clin_data),2),:);

non_nan_subs = sort(no_nan_table.Var1);
no_na_clin_subs = sort(no_na_clin_table.Var5);