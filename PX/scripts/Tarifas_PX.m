
clear
%
!cat data/json/input_P2.json
%
%% inputs
price_table_hourly  = 'data/csv/price_curves/price_table_2013.csv';
load_curve_csv      = 'data/csv/load_curves/ex01_2013.csv';
input_json          = 'data/json/input_P2.json';

%%
OptmizeTariff(load_curve_csv,price_table_hourly,input_json);
%
hourly_data  = readtable('hourly_data.csv');
monthly_data = readtable('monthly_data.csv');
%
fid = fopen('tariff_output.json','r');
OptPower = jsondecode(fscanf(fid,'%s'));
%%
figure(1)
clf
plotResults(monthly_data,hourly_data)

%%


!cat data/json/input_P6.json
%
%% inputs
price_table_hourly  = 'data/csv/price_curves/price_table_2013.csv';
load_curve_csv      = 'data/csv/load_curves/ex01_2013.csv';
input_json          = 'data/json/input_P6.json';

%%
OptmizeTariff(load_curve_csv,price_table_hourly,input_json);
%%
hourly_data  = readtable('hourly_data.csv');
monthly_data = readtable('monthly_data.csv');
%
%%
clf

plotResults(monthly_data,hourly_data)

