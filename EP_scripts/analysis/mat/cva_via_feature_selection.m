%single_cca = spm_cva(cog_cva_arr_1(:,2),cog_desMat(:,1:8));
%[Xouts_scz1, X_outlist_scz1, Youts_scz1, Y_outlist_scz1] = cca_feature_selection_zarghami(scz_cva_arr_f1,scz_cog_scores(:,[6,10,14,15:16,18:23,27:32,38:44]),3);
%[Xouts_scz2, X_outlist_scz2, Youts_scz2, Y_outlist_scz2] = cca_feature_selection_zarghami(scz_cva_arr_f2,scz_cog_scores(:,[6,10,14,15:16,18:23,27:32,38:44]),3);

[Xouts_scz1, X_outlist_scz1, Youts_scz1, Y_outlist_scz1] = cca_feature_selection_zarghami(scz_cva_arr_f1,scz_cog_scores(:,[25,54,91]),3);
[Xouts_scz2, X_outlist_scz2, Youts_scz2, Y_outlist_scz2] = cca_feature_selection_zarghami(scz_cva_arr_f2,scz_cog_scores(:,[25,54,91]),3);

[Xouts_scz1_clin, X_outlist_scz1_clin, Youts_scz1_clin, Y_outlist_scz1_clin] = cca_feature_selection_zarghami(scz_cva_arr_f1,scz_cog_scores(:,46:49),3);
[Xouts_scz2_clin, X_outlist_scz2_clin, Youts_scz2_clin, Y_outlist_scz2_clin] = cca_feature_selection_zarghami(scz_cva_arr_f2,scz_cog_scores(:,46:49),3);
%[Xouts_con1, test_Youts] = cca_feature_selection_zarghami(control_cva_arr_f1,con_cog_scores(:,[6,10,14,15:16,18:23,27:32,38:44]),8);
%[Xouts_con2, test_Youts] = cca_feature_selection_zarghami(control_cva_arr_f2,con_cog_scores(:,[6,10,14,15:16,18:23,27:32,38:44]),8);

%Selective cvas
scz_1_cva_selective = spm_cva(Youts_scz1, Xouts_scz1);
scz_2_cva_selective = spm_cva(Youts_scz2, Xouts_scz2);

scz_1_clin_cva_sel = spm_cva(Youts_scz1_clin,Xouts_scz1_clin);
scz_2_clin_cva_sel = spm_cva(Youts_scz2_clin,Xouts_scz2_clin);

%Graphing the results of the selective models:

ROI_list = {'PCC','mPFC','LlPar','RlPar','LiTem','RiTem','mdThal','LpCerb','RpCerb','dmPFC','LaPFC','RaPFC','LsPar','RsPar','dACC','LaPFC\_SN','RaPFC_SN','L\_Ins','R\_Ins','LlPar\_SN','RlPar\_SN'};
connectivity_labels = cell(441,1);
count = 0;
for r=1:21
    for c=1:21
        count = count + 1;
        connectivity_labels{count,1} = string(ROI_list{r}) + '->' + string(ROI_list{c});
    end
end

slow_5_ec_labels(1) = connectivity_labels{X_outlist_scz1(1),1};
slow_5_ec_labels(2) = connectivity_labels{X_outlist_scz1(2),1};
slow_5_ec_labels(3) = connectivity_labels{X_outlist_scz1(3),1};

s5_ec_labs = categorical(slow_5_ec_labels);

slow_4_ec_labels(1) = connectivity_labels{X_outlist_scz2(1),1};
slow_4_ec_labels(2) = connectivity_labels{X_outlist_scz2(2),1};
slow_4_ec_labels(3) = connectivity_labels{X_outlist_scz2(3),1};

s4_ec_labs = categorical(slow_4_ec_labels);


s5_clin_ec_labels(1) = connectivity_labels{X_outlist_scz1_clin(1),1};
s5_clin_ec_labels(2) = connectivity_labels{X_outlist_scz1_clin(2),1};
s5_clin_ec_labels(3) = connectivity_labels{X_outlist_scz1_clin(3),1};

s5_clin_ec_labs = categorical(s5_clin_ec_labels);

s4_clin_ec_labels(1) = connectivity_labels{X_outlist_scz2_clin(1),1};
s4_clin_ec_labels(2) = connectivity_labels{X_outlist_scz2_clin(2),1};
s4_clin_ec_labels(3) = connectivity_labels{X_outlist_scz2_clin(3),1};

s4_clin_ec_labs = categorical(s4_clin_ec_labels);

cognitive_labels = categorical({'Fluid & Crystallized Cog.','Comp. Emot. Recog.'});
clinical_labels = categorical({'PANSS-g','PANSS-p','PANSS-n'});
clin_labs4 = categorical({'PANSS-p','PANSS-n'});
slow5_Yvec1 = scz_1_cva_selective.V(:,1);
slow5_Yvec2 = scz_1_cva_selective.V(:,2);

slow5_Xvec1 = scz_1_cva_selective.W(:,1);
slow5_Xvec2 = scz_1_cva_selective.W(:,2);

slow5_Y_variates1 = scz_1_cva_selective.v(:,1);
slow5_X_variates1 = scz_1_cva_selective.w(:,1);

slow5_Y_variates2 = scz_1_cva_selective.v(:,2);
slow5_X_variates2 = scz_1_cva_selective.w(:,2);


s5_clin_Yvec1 = scz_1_clin_cva_sel.V(:,1);
s5_clin_Yvec2 = scz_1_clin_cva_sel.V(:,2);

s5_clin_Xvec1 = scz_1_clin_cva_sel.W(:,1);
s5_clin_Xvec2 = scz_1_clin_cva_sel.W(:,2);

s5_clin_Y_variates1 = scz_1_clin_cva_sel.v(:,1);
s5_clin_X_variates1 = scz_1_clin_cva_sel.w(:,1);

s5_clin_Y_variates2 = scz_1_clin_cva_sel.v(:,2);
s5_clin_X_variates2 = scz_1_clin_cva_sel.w(:,2);

s5_Cv1 = figure;
scatter(slow5_X_variates1, slow5_Y_variates1);
title('Slow 5 first canonical variates')
xlabel('Effective Connectivity')
ylabel('Cognitive Scores')

s5_Cv2 = figure;
scatter(slow5_X_variates2, slow5_Y_variates2);
title('Slow 5 second canonical variates')
xlabel('Effective Connectivity')
ylabel('Cognitive Scores')

figure;
bar(cognitive_labels,slow5_Yvec1);
title('Cognitive scores (First Canonical Vector) Slow 5')
ylabel('Canonical Weight')
xtickangle(90)

figure;
bar(cognitive_labels,slow5_Yvec2);
title('Cognitive scores (Second Canonical Vector) Slow 5')
ylabel('Canonical Weight')
xtickangle(90)

figure;
bar(s5_ec_labs,slow5_Xvec1);
title('Effective Connectivity (First Canonical Vector) Slow 5');
ylabel('Canonical Weight');
xtickangle(90)

figure;
bar(s5_ec_labs,slow5_Xvec2);
title('Effective Connectivity (Second Canonical Vector) Slow 5')
ylabel('Canonical Weight')
xtickangle(90)

figure;
scatter(s5_clin_X_variates1, s5_clin_Y_variates1);
title('Slow 5 Clinical first canonical variates')
xlabel('Effective Connectivity')
ylabel('Clinical Scores')

figure;
scatter(s5_clin_X_variates2, s5_clin_Y_variates2);
title('Slow 5 Clinical second canonical variates')
xlabel('Effective Connectivity')
ylabel('Clinical Scores')

figure;
bar(clinical_labels,s5_clin_Yvec1);
title('Clinical scores (First Canonical Vector) Slow 5')
ylabel('Canonical Weight')
xtickangle(90)

figure;
bar(clinical_labels, s5_clin_Yvec2);
title('Clinical Scores (2nd Canonical Vector) Slow 5')
ylabel('Canonical Weight')
xtickangle(90)

figure;
bar(s5_clin_ec_labs, s5_clin_Xvec1);
title('Effective Connectivity (Clinical, 1st Canonical Vector) Slow 5')
ylabel('Canonical Weight')
xtickangle(90)

figure;
bar(s5_clin_ec_labs, s5_clin_Xvec2);
title('Effective Connectivity (Clinical, 2nd Canonical Vector) Slow 5')
ylabel('Canonical Weight')
xtickangle(90)


slow4_Yvec1 = scz_2_cva_selective.V(:,1);
slow4_Yvec2 = scz_2_cva_selective.V(:,2);

slow4_Xvec1 = scz_2_cva_selective.W(:,1);
slow4_Xvec2 = scz_2_cva_selective.W(:,2);

slow4_Y_variates1 = scz_2_cva_selective.v(:,1);
slow4_X_variates1 = scz_2_cva_selective.w(:,1);

slow4_Y_variates2 = scz_2_cva_selective.v(:,2);
slow4_X_variates2 = scz_2_cva_selective.w(:,2);

s4_clin_Yvec1 = scz_2_clin_cva_sel.V(:,1);
s4_clin_Yvec2 = scz_2_clin_cva_sel.V(:,2);

s4_clin_Xvec1 = scz_2_clin_cva_sel.W(:,1);
s4_clin_Xvec2 = scz_2_clin_cva_sel.W(:,2);

s4_clin_Y_variates1 = scz_2_clin_cva_sel.v(:,1);
s4_clin_X_variates1 = scz_2_clin_cva_sel.w(:,1);

s4_clin_Y_variates2 = scz_2_clin_cva_sel.v(:,2);
s4_clin_X_variates2 = scz_2_clin_cva_sel.w(:,2);

figure;
scatter(slow4_X_variates1, slow4_Y_variates1);
title('Slow 4 first canonical variates')
xlabel('Effective Connectivity')
ylabel('Cognitive Scores')

figure;
scatter(slow4_X_variates2, slow4_Y_variates2);
title('Slow 4 second canonical variates')
xlabel('Effective Connectivity')
ylabel('Cognitive Scores')

figure;
bar(cognitive_labels,slow4_Yvec1);
title('Cognitive scores (First Canonical Vector) Slow 4')
ylabel('Canonical Weight')
xtickangle(90)

figure;
bar(cognitive_labels,slow4_Yvec2);
title('Cognitive scores (Second Canonical Vector) Slow 4')
ylabel('Canonical Weight')
xtickangle(90)

figure;
bar(s4_ec_labs,slow4_Xvec1);
title('Effective Connectivity (First Canonical Vector) Slow 4');
ylabel('Canonical Weight');
xtickangle(90)

figure;
bar(s4_ec_labs,slow4_Xvec2);
title('Effective Connectivity (Second Canonical Vector) Slow 4')
ylabel('Canonical Weight')
xtickangle(90)

figure;
scatter(s4_clin_X_variates1, s4_clin_Y_variates1)
title('Slow 4 Clinical 1st Canonical Variates')
xlabel('Effective Connectivity')
ylabel('Clinical Scores')



figure;
bar(clin_labs4,s4_clin_Yvec1)
title('Clinical Scores (1st Canonical Vector) Slow 4')
ylabel('Canonical Weight')
xtickangle(90)



figure;
bar(s4_clin_ec_labs,s4_clin_Xvec1)
title('Effective Connectivity (1st Clinical Canonical Vector) Slow 4')
ylabel('Canonical Weight')
xtickangle(90)

figure;
bar(s4_clin_ec_labs, s4_clin_Xvec2)
title('Effective Connectivity (2nd Clinical Canonical Vector) Slow 4')
ylabel('Canonical Weight')
xtickangle(90)

figure;
bar(clin_labs4,s4_clin_Yvec2)
title('Clinical Scores (2nd Canonical Vector) Slow 4')
ylabel('Canonical Weight')
xtickangle(90)

figure;
scatter(s4_clin_X_variates2, s4_clin_Y_variates2)
title('Slow 4 Clinical 2nd Canonical Variates')
xlabel('Effective Connectivity')
ylabel('Clinical Scores')

