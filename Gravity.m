% Import the Export Data into the workspace
Export_Data=readtable("Export Data.csv");

% Import the GDP Data into the workspace
GDP_Data=readtable("GDP Data.csv");

% Import the Distance Data into the workspace
Dist_Data=readtable("dist Data.csv");

% Access the variable (column) names in the Distance Data 
Dist_Data.Properties.VariableNames

% Select columns of interest from the Distance Data 
Dist_Data=Dist_Data(:, [1, 2, 11]);

% Access the variable (column) names in the Export Data 
Export_Data.Properties.VariableNames

% Access the variable (column) names in the GDP Data 
GDP_Data.Properties.VariableNames


% Selected countries of interest
countriesToSelect = {'JPN', 'LUX', 'MEX', 'RUS', 'ZAF', 'ITA', 'CHL', 'HUN', 'USA', 'AUS', 'FRA'};

% List of all unique values in the LOCATION column in the Export Data
unique(Export_Data.LOCATION)

% Transform the Export Data based on selected countries
Export_Data = Export_Data(ismember(Export_Data.LOCATION, countriesToSelect), :);

% List of all unique values in the LOCATION column in the GDP Data
unique(GDP_Data.LOCATION)

% Transform the GDP Data based on selected countries
GDP_Data = GDP_Data(ismember(GDP_Data.LOCATION, countriesToSelect), :);

% List of all unique values in the is_o column in the Distance Data
unique(Dist_Data.iso_o)

% Transform the Distance Data based on selected countries
Dist_Data = Dist_Data(ismember(Dist_Data.iso_o, countriesToSelect), :);


% Join the Export Data with the GDP Data using innerjoin
joinedData = innerjoin(Export_Data,GDP_Data,"Keys","LOCATION");

% Join the joinedData with the Distance Data using innerjoin
joinedData2 = innerjoin(joinedData,Dist_Data,"LeftKeys","LOCATION",...
    "RightKeys","iso_o");



