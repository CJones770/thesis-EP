%Feature selection script (Inspired by the descriptions provided in Zargami
%et al., 2023)
function [X_outs, X_outlist, Y_outs, Y_outlist] = cca_feature_selection_zarghami(Xs, Ys, max_features)
%Xs: N-sub x N-features (connections) matrix.
%Ys: N-sub x N-behavioral/cognitive scores matrix 
%max_features: positive integer defining the maximum number of features the
%function will keep in X_outs.

%#Feature selection to avoid overfitting (as described in Zarghami et al., 2023)

%#Problem: Features (i.e., EC values) greatly outnumber the total number of subjects (76 (31 + 45))

%#Need to select most descriptive features over the best described cognitive scores.

%#See features selection (2.6.2) of Zarghami et al., 2023 for details on the method.

%#Forward selection of EC parameters

%#For each component of x and all ys, a dedicated cca model is constructed.
lowest_lambdaX = 0;
id_lowest_lambdaX = 0;

saved_Xs = zeros(max_features,1);

for x=1:numel(Xs(1,:))
single_cca = spm_cva(Ys,Xs(:,x));
lambdaX = single_cca.p;

if x == 1
    id_lowest_lambdaX = 1;
    lowest_lambdaX = lambdaX;
end

if lambdaX < lowest_lambdaX
    lowest_lambdaX = lambdaX;
    id_lowest_lambdaX = x;
end

end
saved_Xs(1) = id_lowest_lambdaX;

%#After calculating lambda(xj) for each combination, the minimum lambda value is selected and saved, this being the best x feature that predicts the cognitive scores by itself.

%#Then, the variable yielding the smallest partial lambda, adjusted for the first chosen variable is calculated as the following ratio lambda(x1, xj) / lambda(x1). 
for el=1:max_features-1
    lowest_lambda_ratio = Inf;
    for x=1:numel(Xs(1,:))
        if ismember(x,saved_Xs.')
            continue
        end
        test_features = saved_Xs(1:el).';
        test_features_full = [test_features,x];
        partial_cva = spm_cva(Ys,Xs(:,test_features_full));
        p_lambdaX = partial_cva.p(el+1);
        if el == 1
            lambda_ratio = p_lambdaX / lowest_lambdaX;
        end
        
        if el > 1
            lambda_ratio = p_lambdaX / lowest_partial;
        end

        if lambda_ratio < lowest_lambda_ratio
            lowest_lambda_ratio = lambda_ratio;
            lowest_partial = p_lambdaX;
            lowest_partial_id = x;
        end
    end
    saved_Xs(el+1) = lowest_partial_id;
end

X_outlist = saved_Xs;
X_outs = Xs(:,saved_Xs.');

%#This process is repeated until a suitable number of features are selected (which should be no more than the number of subjects / 9)

%#Backward selection of Cognitive scores

%#The backwards elimination of cognitive scores is done by recursively removing cognitive score features from models using the subset of xs generated from the foward selection and all the ys.
max_lambda_ratio = -1;
full_cva = spm_cva(Ys,Xs(:,saved_Xs.'));
full_lambda = full_cva.p(1);
redundant_ys = [];
for y_el=1:numel(Ys(1,:))
    test_redundant_ys = [redundant_ys,y_el];
    TrimYs = Ys;
    TrimYs(:,test_redundant_ys) = [];
    cva_model = spm_cva(TrimYs,Xs(:,saved_Xs.'));
    partial_lambda_Ys = cva_model.p(1); 
    lambda_ratio =  full_lambda / partial_lambda_Ys;
    if lambda_ratio > max_lambda_ratio
        max_lambda_ratio = lambda_ratio;
        max_lambda_index = y_el;
    else 
        continue
    end
    if lambda_ratio > 0.05
        redundant_ys(end+1) = y_el;
    elseif lambda_ratio <= 0.05
        break
    end
end
stored_Ys = Ys;
stored_Ys(:,redundant_ys) = [];
Y_outs = stored_Ys;
full_col_list = (1:numel(Ys(1,:)));
Y_outlist = setdiff(full_col_list,redundant_ys);
%#This process was used to remove ys one by one until the largest partial lambda yielded a significant p-value (<0.05).

%#The features that remained after these processes were kept and used in the cca models of interest.