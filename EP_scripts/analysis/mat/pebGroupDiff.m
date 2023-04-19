%Assessing differences in EC between groups (M vs F, P vs C, F1 vs F2)


%Weight estimated average differences in connectivity strength 
%Against its corresponding posterior covariance to test for 
%Statistically significant differences in region specific connectivity 
%between groups (Male vs Female, Patient vs Control)

%Within 1st Frequency Band:
Ep1 = PEB(1).Ep;
Cp1 = PEB(1).Cp;
Ep2 = PEB(2).Ep;
Cp2 = PEB(2).Cp;
dimsize = size(Ep1);
num_connections = dimsize(1); %number of connections
num_variables = dimsize(2); %number of covariates

diagCp1 = diag(Cp1);  %Store diagonal elements of Cp1
rsDiagCp1 = reshape(diagCp1,num_connections,num_variables); %reshape into covariance matrix of size num_connections x num_variables 

diagCp2 = diag(Cp2);
rsDiagCp2 = reshape(diagCp2,num_connections,num_variables);

Ts1 = zeros(size(Ep1));
Ps1 = zeros(size(Ts1));
Ts2 = zeros(size(Ep2));
Ps2 = zeros(size(Ts2));
binarySigMat1 = zeros(size(Ts1));
bianrySigMat2 = zeros(size(Ts2));
%Searching for statistically significant beta values
for r=1:length(Ts1)
    for v=1:num_variables
        Ts1(r,v) = Ep1(r,v) / sqrt(rsDiagCp1(r,v)^2/num_subs);
        Ps1(r,v) = 1-tcdf(Ts1(r,v),num_subs-1);
        Ts2(r,v) = Ep2(r,v) / sqrt(rsDiagCp2(r,v)^2/num_subs);
        Ps2(r,v) = 1-tcdf(Ts2(r,v),num_subs-1);
        if Ps1(r,v)*2646 < 0.025
            binarySigMat1(r,v) = 1;
        end
        if Ps2(r,v)*2646 < 0.025
            bianrySigMat2(r,v) = 1;
        end
    end
end

diffFs = Ep1 - Ep2;
weightedSE = sqrt((rsDiagCp1.^2 / num_subs) + (rsDiagCp2.^2 / num_subs));
diffFs_test = zeros(size(diffFs)); %diffFs / weightedSE;
diffFs_test_Ps = zeros(size(diffFs)); %1-tcdf(diffFs_test,num_subs*2 - 2);
BFC_diffFs_test = zeros(size(diffFs)); %diffFs_test_Ps * 1323;
binary_BFC_diffFs_test = zeros(size(BFC_diffFs_test));
for r=1:length(Ts1)
    for v=1:num_variables
        diffFs_test(r,v) = diffFs(r,v) / weightedSE(r,v);
        diffFs_test_Ps(r,v) = 1-tcdf(diffFs_test(r,v),num_subs*2 - 2);
        BFC_diffFs_test = diffFs_test_Ps * 1323;
        if BFC_diffFs_test(r,v) < 0.025
            binary_BFC_diffFs_test(r,v) = 1;
        end
    end
end
%Interaction terms may be added (multiply binary design matrix column 
%values to create interaction terms