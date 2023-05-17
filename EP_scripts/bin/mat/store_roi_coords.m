ROI_coords = [0 -52 7; -1 54 27; -46 -63 33; 49 -63 33; -61 -24 -9; 58 -24 -9;0 -12 9;-25 -81 -33;25 -81 -33;0 24 46;-44 45 0;44 45 0;-50 -51 45;50 -51 45;0 21 36;-35 45 30; 32 45 30;-41 3 6;41 3 6;-62 -45 30;62 -45 30];
ROI_labels = {'PCC';'mPFC';'LlPar';'RlPar';'LiTem';'RiTem';'mdThal';'LpCer';'RpCer';'dmPFC';'LaPFC';'RaPFC';'LsPar';'RsPar';'dACC';'LaPFCsn';'RaPFCsn';'LIns';'RIns';'LlParSN';'RlParSN'};
ROI_radii = [3;4;4;4;4;4;3;2;2;4;4;4;4;4;3;4;4;3;3;4;4];
vp_coords = [45 37 40; 45 90 50; 22 30 51; 70 32 53; 15 51 32; 74 51 32; 45 57 41; 33 23 20; 58 23 20; 45 75 59; 23 86 38; 67 86 36; 20 38 59; 70 38 59; 45 74 54; 28 86 51; 61 86 51; 25 65 39; 66 65 39; 14 41 51; 76 41 51];
ROI_info = cell(21,8);
for r=1:21
    ROI_info{r,1} = ROI_coords(r,1);
    ROI_info{r,2} = ROI_coords(r,2);
    ROI_info{r,3} = ROI_coords(r,3);
    ROI_info{r,4} = ROI_labels{r,1};
    ROI_info{r,5} = ROI_radii(r,1);
    ROI_info{r,6} = vp_coords(r,1);
    ROI_info{r,7} = vp_coords(r,2);
    ROI_info{r,8} = vp_coords(r,3);
end