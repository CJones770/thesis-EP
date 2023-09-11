%spm filter implementation

%Values for repition rate (TR) and the lowpass cutoff frequencies are adjustable 
% Insert value of 1/f, f being the cutoff frequency in Hz to replace the values of 37 or 13.69, respectively.
TR = 0.8;
K_input = struct('RT',TR,'HParam',37,'row',ones(1,410));
K = spm_filter(K_input);
R = K.X0;

save('/home/corey/thesis-EP/EP_scripts/DCT_basis_sets/K_Filter_DCT1_slow5.mat',"R");

TR = 0.8;
K_input = struct('RT',TR,'HParam',13.69,'row',ones(1,410));
K = spm_filter(K_input);
R = K.X0;

save('/home/corey/thesis-EP/EP_scripts/DCT_basis_sets/K_Filter_DCT2_slow4.mat',"R");
