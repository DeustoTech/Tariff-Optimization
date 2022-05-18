%%
clear
%
%%
[maxPower,TD60_Power_list] = compute_power_params('data/ex01_2013.csv');

%%
figure(3)
Plot_Profile(TD60_Power_list,maxPower)
%%

load('price_table_2013')
%%
figure(6)
plot(price_table_2013.DateTime,price_table_2013.price)
ylabel('€/MWh')

%%
TD60_Power_list.price = interp1(price_table_2013.DateTime,price_table_2013.price,TD60_Power_list.DateTime);

%%
TD60_Power_list.energy_cost = TD60_Power_list.power.*TD60_Power_list.price*1e-3;

p_P6 = params_P6;

TD60_Power_list.power_cost_by_kW = p_P6.PowerPrice(TD60_Power_list.tramo_power)';

%%
TD60_Power_list.power_cost = TD60_Power_list.power_cost_by_kW.*maxPower(TD60_Power_list.tramo_power)
%%
TD60_Power_list.cost = TD60_Power_list.power_cost + TD60_Power_list.energy_cost ;
%%
% month cost
month_cost_cum = zeros(size(TD60_Power_list.cost));
month_cost_cum(1) = 0;
monthly_data = [];

month_energy_cum = zeros(size(TD60_Power_list.cost));
month_energy_cum(1) = 0;

iter = 0;
for it = 2:length(month_cost_cum)
    if ~isnan(TD60_Power_list.cost(it))
        month_cost_cum(it)   =  month_cost_cum(it-1) + TD60_Power_list.cost(it);
        month_energy_cum(it) =  month_energy_cum(it-1) + TD60_Power_list.power(it);
    else
        month_cost_cum(it) =  month_cost_cum(it-1);
        month_energy_cum(it) =  month_energy_cum(it-1);
    end
    %
    if TD60_Power_list.DateTime(it).Month - TD60_Power_list.DateTime(it-1).Month ~= 0
       month_energy_cum(it) = 0;
       month_cost_cum(it) = 0; 
       iter = iter + 1;
       monthly_data(iter).cost   = month_cost_cum(it-1);
       monthly_data(iter).energy   = month_energy_cum(it-1);
       monthly_data(iter).DateTime = TD60_Power_list.DateTime(it-1);
       monthly_data(iter).DateTime.Day = 1;
    end
end

iter = iter + 1;
monthly_data(iter).cost   = month_cost_cum(it-1);
monthly_data(iter).energy   = month_energy_cum(it-1);
monthly_data(iter).DateTime = TD60_Power_list.DateTime(it-1);
monthly_data(iter).DateTime.Day = 1;
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
ip = plot(TD60_Power_list.DateTime,TD60_Power_list.cost)
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
