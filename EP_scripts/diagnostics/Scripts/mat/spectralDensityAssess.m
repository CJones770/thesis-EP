%checking the power spectral density of 2nd frequency band inputs to DCM
subjectlist = fopen('/media/corey/4TB-WDBlue/data-thesis/2ndRunList_full.txt');
subnum_str = textscan(subjectlist,'%s');
sub_num = str2double(subnum_str{1,1});
subject_num=transpose(sub_num);
fclose(subjectlist);

ROI_labels = {'PCCandPrecuneus';'mPFC';'L_lPar';'R_lPar';'L_iTem';'R_iTem';'mdThal';'L_pCerb';'R_pCerb';'dmPFC';'L_aPFC';'R_aPFC';'L_sPar';'R_sPar';'dACC';'L_aPFC_SN';'R_aPFC_SN';'L_Ins';'R_Ins';'L_lPar_SN';'R_lPar_SN'};

fs = 0.8;
N = 410;
freq = 0:fs/N:fs/2;

ROIsBySub = cell(length(sub_num),21);
psdxs = cell(length(sub_num),21);
runningSum = cell(21,1);
runningSum2 = cell(21,1);

zerosPrefab = zeros(206,1);
for r=1:21
    runningSum{r} = zerosPrefab;
    runningSum2{r} = zerosPrefab;
end
for n=1:length(sub_num)
for r=1:21
    x = open(sprintf("/media/corey/4TB-WDBlue/data-thesis/fMRI/Rapidtide/%s_01_MR/PA/models/2glmNR/VOI_%s_1.mat",subnum_str{1,1}{n,1}, ROI_labels{r}));
    Y = x.Y;
    ROIsBySub{n,r} = Y;
    xdft = fft(Y);
    xdft = xdft(1:N/2+1);
    psdx = (1/(fs*N)) * abs(xdft).^2;
    psdx(2:end-1) = 2*psdx(2:end-1);
    psdxs{n,r} = psdx;
    runningSum{r} = runningSum{r} + psdxs{n,r};
end
end

average_psdxs = cell(21,1);
for r=1:21
%average_psdx = (psdxs{1,r} + psdxs{2,r}) /length(sub_num); %+ psdxs{8,r} + psdxs{9,r} + psdxs{10,r} + psdxs{11,r} + psdxs{12,r}) / length(sub_num);
%average_psdxs{r} = average_psdx;
average_psdxs{r} = runningSum{r} / length(sub_num);
end

psdxs2 = cell(length(sub_num),21);
for n=1:length(sub_num)
for r=1:21
    x = open(sprintf("/media/corey/4TB-WDBlue/data-thesis/fMRI/Rapidtide/%s_01_MR/PA/models/2glmNR2/VOI_%s_1.mat",subnum_str{1,1}{n,1}, ROI_labels{r}));
    Y = x.Y;
    ROIsBySub{n,r} = Y;
    xdft = fft(Y);
    xdft = xdft(1:N/2+1);
    psdx = (1/(fs*N)) * abs(xdft).^2;
    psdx(2:end-1) = 2*psdx(2:end-1);
    psdxs2{n,r} = psdx;
    runningSum2{r} = runningSum2{r} + psdxs2{n,r};

end
end

average_psdxs2 = cell(21,1);
for r=1:21
%average_psdx = (psdxs{1,r} + psdxs{2,r}) /length(sub_num);%
% + psdxs{5,r} + psdxs{6,r} + psdxs{7,r} + psdxs{8,r} + psdxs{9,r} + psdxs{10,r} + psdxs{11,r} + psdxs{12,r}) / length(sub_num);
%average_psdxs2{r} = average_psdx;
average_psdxs2{r} = runningSum2{r} / length(sub_num);

end





