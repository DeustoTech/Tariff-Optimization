
clear
%
%%

price_table_hourly  = 'data/json/price_table_2013.csv';

price_table_hourly = 'energy_price_table.csv';
load_curve_csv      = 'data/csv/ex01_2013.csv';
input_json          = 'data/json/input_P2.json';


compute_tarrif_P2(load_curve_csv,price_table_hourly,input_json);
%

%%
TD60_Power_list = readtable('hourly_data.csv');
monthly_data = readtable('monthly_data.csv');
%%
fid = fopen('tariff_output.json','r');
OptPower = jsondecode(fscanf(fid,'%s'));
%%

figure(1)
clf
subplot(4,2,1)
plot(TD60_Power_list.DateTime,TD60_Power_list.price*1e-3)
title('Price(€/kWh)')
subplot(4,2,2)
plot(TD60_Power_list.DateTime,TD60_Power_list.power)
title('Load Profile (kW)')

subplot(4,2,3)
plot(TD60_Power_list.DateTime,TD60_Power_list.tramo_energy)
title('tramo horario')

subplot(4,2,4)
plot(TD60_Power_list.DateTime,TD60_Power_list.energy_cost)
title('Energy Cost(€)')
%
subplot(4,2,5)
plot(TD60_Power_list.DateTime,TD60_Power_list.power_cost)
title('Power Cost(€)')

subplot(4,2,6)
ip = plot(TD60_Power_list.DateTime,TD60_Power_list.cost);
title('Total Cost(€)')

subplot(4,2,7)

%plot(TD60_Power_list.DateTime,month_cost_cum)
bar([monthly_data.DateTime],[monthly_data.cost])
title('Monthly  Total Cost(€)')
xticks(ip.Parent.XTick(1:end-1))
grid on
ylim([0 1.2e4])

subplot(4,2,8)

%plot(TD60_Power_list.DateTime,month_cost_cum)
bar([monthly_data.DateTime],[monthly_data.energy])
title('Monthly  Total Energy(kWh)')
grid on
xticks(ip.Parent.XTick(1:end-1))

%%
figure(2)
Plot_Profile_P2(TD60_Power_list,OptPower.Potencia_de_contratacion_opt)