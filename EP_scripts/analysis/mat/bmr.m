%Bayesian model reduction [depends on running prepDataStruct first]

%Prepare model space of DCMs
dcm_array1 = cell(size(DCM_array(:,1)));
for c=1:size(dcm_array1,1)
    dcm_array1{c,1} = DCM_array{c,1}.DCM;
end

%Bayesian model reduction
[rmc, bmc, bma] = spm_dcm_bmr(dcm_array1);