Dist_Data = readtable("dist Data.csv");


countriesToSelect = {'JPN', 'GRB', 'MEX', 'RUS', 'ZAF', 'ITA', 'CHL',...
                     'HUN', 'USA', 'AUS', 'FRA', 'SVK', 'ESP', 'NOR',...
                     'DNK', 'GRC', 'LUX', 'PRT', 'NLD', 'TUR'};

Dist_Data = Dist_Data(ismember(cepii_data.iso_o,countriesToSelect) ...
    & ...
    ismember(Dist_Data.iso_d,countriesToSelect),:);


 Dist_Data.comlang_instr = Dist_Data.comlang_off > 0;
 
% Dummy variables for countries
 iso_o_dummies = dummyvar(Dist_Data.iso_o); 
 iso_d_dummies = dummyvar(Dist_Data.iso_d);

% Merging the two dummy variables  
IV_data = [Dist_Data table(iso_o_dummies) table(iso_d_dummies)];

Dist_Data(:,3:end-1) = [];

IV_gra = Dist_Data.comlang_instr;



% 2SLS Regression
X_1 = [lnd GDP_i GDP_j border_s IV_gra];



% Instrumental variable  
Z = IV_gra;

% Endogeneous regressor
Endogeneous_regressor = lnd;

% Dependent variable 
X = lnX;

% First stage 
first_stage = fitlm(Z, endo_reg, "linear");

 Y_hat = predict(first_stage); 
 
% Second stage
second_stage = fitlm([GDP_i,GDP_j, lnd,border_s Y_hat p_j p_j], lnX, "linear");


Y_MCSE = lnd; 
X_MCSE = lnX;
Z_MCSE = IV_gra;  

% OLS estimates
b_ols = regress(X, [ones(size(Y_MCSE)) Y_MCSE]); 

% First stage 
First_stage_MCSE = fitlm(Y_MCSE ,Z_MCSE);  

Y_hat_MCSE = predict(first_stage_MCSE);

% Reduced form  
Reduced_form = regress(X, [ones(size(Y_hat_MCSE)) Y_hat_MCSE Z]);  

% Coefficients 
gamma = Reduced_form(2); 
pi = red_form(3:end);

% Weighted Matrix
W = inv(pi'*pi);

 
b_mcse = gamma + W*pi'*(X-pi*gamma);
    

V = W*pi'*pi*W;
se = sqrt(diag(V))';