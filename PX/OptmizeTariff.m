function [opt_hourly_data,opt_monthly_data] = OptmizeTariff(load_curve_csv,price_table_hourly,json_path)

json_fileID = fopen(json_path,'r');

p_P = jsondecode(fscanf(json_fileID,'%s'));
%
Number_of_Power_Periods = length(p_P.Power_Price);

p_P = params(   Number_of_Power_Periods     , ...
                p_P.Power_Price             , ...
                p_P.Current_Power_Term      );

%%
[maxPower,opt_hourly_data] = compute_power_params(load_curve_csv,p_P.Number_Of_Power_Periods);

price_table_hourly = readtable(price_table_hourly);
%%

[opt_hourly_data,opt_monthly_data]   = Gen_Add_Data(opt_hourly_data,price_table_hourly,p_P,maxPower);
[~,curr_monthly_data]                = Gen_Add_Data(opt_hourly_data,price_table_hourly,p_P,p_P.Current_Power_Term);

opt_monthly_data.current_cost     = curr_monthly_data.cost;
opt_monthly_data.saving_cost = opt_monthly_data.current_cost - opt_monthly_data.cost;
%

writetable(opt_monthly_data,'monthly_data.csv');
writetable(opt_hourly_data,'hourly_data.csv');
%
%

%
p_P.Optimal_Power_Term = maxPower;

        
p_P.Total_Current_Cost = sum(curr_monthly_data.cost);
p_P.Total_Opti_Cost    = sum(opt_monthly_data.cost); 
p_P.Total_Saving       = sum(opt_monthly_data.saving_cost);

FID = fopen('tariff_output.json','w');
fwrite(FID,jsonencode(p_P));
%
end

