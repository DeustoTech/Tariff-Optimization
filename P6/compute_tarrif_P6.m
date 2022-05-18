function [hourly_data,monthly_data] = compute_tarrif_P6(load_curve_csv,price_table_hourly,json_path)

json_fileID = fopen(json_path,'r');

p_P6 = jsondecode(fscanf(json_fileID,'%s'));
[maxPower,hourly_data] = compute_power_params(load_curve_csv);

price_table_hourly = readtable(price_table_hourly);
%%
hourly_data.price = interp1(price_table_hourly.DateTime,price_table_hourly.price,hourly_data.DateTime);

%%
hourly_data.energy_cost = hourly_data.power.*hourly_data.price*1e-3;

PPP6 = p_P6.PowerPrice(:)';
hourly_data.power_cost_by_kW = PPP6(hourly_data.tramo_power)';

%%
hourly_data.power_cost = hourly_data.power_cost_by_kW.*maxPower(hourly_data.tramo_power);
%%
hourly_data.cost = hourly_data.power_cost + hourly_data.energy_cost ;
%%
% month cost
month_cost_cum = zeros(size(hourly_data.cost));
month_cost_cum(1) = 0;
monthly_data = [];

month_energy_cum = zeros(size(hourly_data.cost));
month_energy_cum(1) = 0;

iter = 0;
for it = 2:length(month_cost_cum)
    if ~isnan(hourly_data.cost(it))
        month_cost_cum(it)   =  month_cost_cum(it-1) + hourly_data.cost(it);
        month_energy_cum(it) =  month_energy_cum(it-1) + hourly_data.power(it);
    else
        month_cost_cum(it) =  month_cost_cum(it-1);
        month_energy_cum(it) =  month_energy_cum(it-1);
    end
    %
    if hourly_data.DateTime(it).Month - hourly_data.DateTime(it-1).Month ~= 0
       month_energy_cum(it) = 0;
       month_cost_cum(it) = 0; 
       iter = iter + 1;
       monthly_data(iter).cost   = month_cost_cum(it-1);
       monthly_data(iter).energy   = month_energy_cum(it-1);
       monthly_data(iter).DateTime = hourly_data.DateTime(it-1);
       monthly_data(iter).DateTime.Day = 1;
    end
end

iter = iter + 1;
monthly_data(iter).cost   = month_cost_cum(it-1);
monthly_data(iter).energy   = month_energy_cum(it-1);
monthly_data(iter).DateTime = hourly_data.DateTime(it-1);
monthly_data(iter).DateTime.Day = 1;
%
monthly_data = struct2table(monthly_data);


writetable(monthly_data,'monthly_data.csv');
writetable(hourly_data,'hourly_data.csv');

p_P6.Potencia_de_contratacion_opt = maxPower;
FID = fopen('tariff_output.json','w');
fwrite(FID,jsonencode(p_P6));
%
end

