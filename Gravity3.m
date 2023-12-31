%%% DATA ON GDP %%%


%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: /Users/ibrahimtiamiyu/Downloads/ECO 5333/Data on Export.csv
%
% Auto-generated by MATLAB on 20-Sep-2023 08:12:27

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 19, "Encoding", "UTF-8");

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["LOCATION", "ReporterCountry", "FLOW", "Flow", "PARTNER", "PartnerCountry", "FREQUENCY", "Frequency", "TIME", "Time", "UnitCode", "Unit", "PowerCodeCode", "PowerCode", "ReferencePeriodCode", "ReferencePeriod", "Value", "FlagCodes", "Flags"];
opts.VariableTypes = ["categorical", "categorical", "categorical", "categorical", "categorical", "categorical", "categorical", "categorical", "double", "double", "categorical", "categorical", "double", "categorical", "string", "string", "double", "string", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["ReferencePeriodCode", "ReferencePeriod", "FlagCodes", "Flags"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["LOCATION", "ReporterCountry", "FLOW", "Flow", "PARTNER", "PartnerCountry", "FREQUENCY", "Frequency", "UnitCode", "Unit", "PowerCode", "ReferencePeriodCode", "ReferencePeriod", "FlagCodes", "Flags"], "EmptyFieldRule", "auto");

% Import the data
DataonExport = readtable("/Users/ibrahimtiamiyu/Downloads/ECO 5333/Data on Export.csv", opts);


%% Clear temporary variables
clear opts



% Selected countries of interest
countriesToSelect = {'JPN', 'GRB', 'MEX', 'RUS', 'ZAF', 'ITA', 'CHL',...
                     'HUN', 'USA', 'AUS', 'FRA', 'SVK', 'ESP', 'NOR',...
                     'DNK', 'GRC', 'LUX', 'PRT', 'NLD', 'TUR'};


% Transform the Export Data based on selected countries
DataonExport = DataonExport(ismember(DataonExport.LOCATION, ...
              countriesToSelect), :);




% Select the 'LOCATION', 'PARTNER', and 'Value' columns
DataonExport = DataonExport(:, {'LOCATION', 'PARTNER', 'Value'});

% Rename the 'Value' column to 'Exports'
DataonExport.Properties.VariableNames{'Value'} = 'EXPORTS';











%%% DATA ON GDP %%%


%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: /Users/ibrahimtiamiyu/Downloads/ECO 5333/Data on GDP.csv
%
% Auto-generated by MATLAB on 20-Sep-2023 08:24:01

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 17, "Encoding", "UTF-8");

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["LOCATION", "Country", "TRANSACT", "Transaction", "MEASURE", "Measure", "TIME", "Year", "UnitCode", "Unit", "PowerCodeCode", "PowerCode", "ReferencePeriodCode", "ReferencePeriod", "Value", "FlagCodes", "Flags"];
opts.VariableTypes = ["categorical", "categorical", "double", "categorical", "categorical", "categorical", "double", "double", "categorical", "categorical", "double", "categorical", "double", "double", "double", "categorical", "categorical"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["LOCATION", "Country", "Transaction", "MEASURE", "Measure", "UnitCode", "Unit", "PowerCode", "FlagCodes", "Flags"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, "TRANSACT", "TrimNonNumeric", true);
opts = setvaropts(opts, "TRANSACT", "ThousandsSeparator", ",");

% Import the data
DataonGDP = readtable("/Users/ibrahimtiamiyu/Downloads/ECO 5333/Data on GDP.csv", opts);


%% Clear temporary variables
clear opts


% Transform the GDP Data based on selected countries
DataonGDP = DataonGDP(ismember(DataonGDP.LOCATION, countriesToSelect), :);



% Select 'LOCATION' and 'Value' columns
DataonGDP = DataonGDP(:, {'LOCATION', 'Value'});

% Rename 'Value' to 'GDP'
DataonGDP.Properties.VariableNames{'Value'} = 'GDP';











%%% DATA ON DISTANCE %%%


%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: /Users/ibrahimtiamiyu/Downloads/ECO 5333/Data on Distance.csv
%
% Auto-generated by MATLAB on 20-Sep-2023 08:27:40

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 14, "Encoding", "UTF-8");

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["iso_o", "iso_d", "contig", "comlang_off", "comlang_ethno", "colony", "comcol", "curcol", "col45", "smctry", "dist", "distcap", "distw", "distwces"];
opts.VariableTypes = ["categorical", "string", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "iso_d", "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["iso_o", "iso_d"], "EmptyFieldRule", "auto");

% Import the data
DataonDistance = readtable("/Users/ibrahimtiamiyu/Downloads/ECO 5333/Data on Distance.csv", opts);


%% Clear temporary variables
clear opts


% Select columns of interest from the Distance Data 
DataonDistance=DataonDistance(:, [1, 2, 11]);

% Transform the Distance Data based on selected countries
DataonDistance = DataonDistance(ismember(DataonDistance.iso_o, ...
                 countriesToSelect), :);

% Rename columns 'iso_o' to 'LOCATION, 'iso_d' to PARTNER, and 
% 'dist' to'DISTANCE'
DataonDistance.Properties.VariableNames{'iso_o'} = 'LOCATION';
DataonDistance.Properties.VariableNames{'iso_d'} = 'PARTNER';
DataonDistance.Properties.VariableNames{'dist'} = 'DISTANCE';






% Convert to DataonEXPORT to matrix form
LOCATION_EXPORT = string(DataonExport.LOCATION);
PARTNER_EXPORT = string(DataonExport.PARTNER);
EXPORTS = DataonExport.EXPORTS;
DataonExportMatrix = [LOCATION_EXPORT, PARTNER_EXPORT, EXPORTS];





% Convert to DataonGDP to matrix form
LOCATION_GDP = string(DataonGDP.LOCATION);  
GDP = DataonGDP.GDP;
DataonGDPMatrix = [LOCATION_GDP, GDP];





% Convert to DataonDistance to matrix form
LOCATION_DISTANCE = string(DataonDistance.LOCATION);
PARTNER_DISTANCE = string(DataonDistance.PARTNER);
DISTANCE = DataonDistance.DISTANCE;
DataonDistanceMatrix = [LOCATION_DISTANCE, PARTNER_DISTANCE, DISTANCE];



% Check the dimension of the Matrices 
size(DataonExportMatrix)
size(DataonGDPMatrix)
size(DataonDistanceMatrix)







% Reshape the DataonDistanceMatrix 
reshapedDataonDistanceMatrix = reshape(DataonDistanceMatrix, 6384, 2);

