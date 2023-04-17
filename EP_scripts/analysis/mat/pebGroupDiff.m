%Assessing differences in EC between groups (M vs F, P vs C, F1 vs F2)


%Weight estimated average differences in connectivity strength 
%Against its corresponding posterior covariance to test for 
%Statistically significant differences in region specific connectivity 
%between groups (Male vs Female, Patient vs Control)

%Within 1st Frequency Band:
Ep1 = PEB(1).Ep;
Cp1 = PEB(1).Cp;

dimsize = size(Ep1);
num_connections = dimsize(1); %number of connections
num_variables = dimsize(2); %number of covariates

diagCp1 = diag(Cp1);  %Store diagonal elements of Cp1
rsDiagCp1 = reshape(diagCp1,num_connections,num_variables); %reshape into covariance matrix of size num_connections x num_variables 

Ts = zeros(size(Ep1));
Ps = zeros(size(Ts));
binarySigMat = zeros(size(Ts));
%Searching for statistically significant beta values
for r=1:length(Ts)
    for v=1:num_variables
        Ts(r,v) = Ep1(r,v) / sqrt(rsDiagCp1(r,v)/num_subs);
        Ps(r,v) = 1-tcdf(Ts(r,v),num_subs-1);
        if Ps(r,v)*1323 < 0.025
            binarySigMat(r,v) = 1;
        end
    end
end
%Interaction terms may be added (multiply binary design matrix column 
%values to create interaction terms