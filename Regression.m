countriesToSelect = {'JPN', 'GRB', 'MEX', 'RUS', 'ZAF', 'ITA', 'CHL',...
                     'HUN', 'USA', 'AUS', 'FRA', 'SVK', 'ESP', 'NOR',...
                     'DNK', 'GRC', 'LUX', 'PRT', 'NLD', 'TUR'};


Base_country = 'AUS';


Log_Pi = zeros(length(countriesToSelect), 1);
for i = 1:length(countriesToSelect)
    Log_Pi(i) = strcmp(countriesToSelect{i}, Base_country);
end


Log_Pj = zeros(length(countriesToSelect), 1);
for j = 1:length(countriesToSelect)
    Log_Pj(j) = strcmp(countriesToSelect{j}, Base_country);
end


disp('Log_Pi:');
disp(Log_Pi);

disp('Log_Pj:');
disp(Log_Pj);


P_i = repmat(Log_Pi, 15, 1);
P_j = repmat(Log_Pj, 15, 1);

% Regression 
X_var = [GDP_i GDP_j lnd P_i P_j b_s];
Y_var = lnX;


[beta, ~, ~, ~, stats] = regress(Y_var, X_var);
standard_errors = sqrt(diag(stats(1:4)));

