%Bayesian model reduction [depends on running prepDataStruct and prep_PEB first]

test_sw_bmr_1 = spm_dcm_bmr(P1);
test_sw_bmr_2 = spm_dcm_bmr(P2);

peb_bmr_1 = spm_dcm_bmr(PEB1);
peb_bmr_2 = spm_dcm_bmr(PEB2);
