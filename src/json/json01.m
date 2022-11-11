%%
clear
name_file_csv = 'data/csv/load_curves/ex01_2013.csv';
current_power_terms = num2str([300 100]);
price_power_periods = num2str(1e-1*[3 2]);
out_file = 'out.json';
%%
results = P2json(name_file_csv,current_power_terms,price_power_periods,out_file);
%%

P2json('data/csv/load_curves/ex01_2013.csv','300  100','0.3 0.2','out.json')