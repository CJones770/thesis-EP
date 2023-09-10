%Assess time series data for stationarity

subjectlist = fopen('/media/corey/4TB-WDBlue/data-thesis/2ndRunList_full.txt');
subnum_str = textscan(subjectlist,'%s');
sub_num = str2double(subnum_str{1,1});
subject_num=transpose(sub_num);
fclose(subjectlist);

ROI_labels = {'PCCandPrecuneus';'mPFC';'L_lPar';'R_lPar';'L_iTem';'R_iTem';'mdThal';'L_pCerb';'R_pCerb';'dmPFC';'L_aPFC';'R_aPFC';'L_sPar';'R_sPar';'dACC';'L_aPFC_SN';'R_aPFC_SN';'L_Ins';'R_Ins';'L_lPar_SN';'R_lPar_SN'};

stationarity_test_matrix = cell(length(subject_num),21);

test_data = x;
detrended_test_data = detrend(test_data.Y);
test_stationarity_val = vratiotest(test_data.Y);