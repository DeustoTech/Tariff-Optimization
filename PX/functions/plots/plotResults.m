function plotResults(monthly_data,hourly_data)


subplot(4,3,1)
hold on
plot(hourly_data.DateTime,hourly_data.price*1e-3)
title('Price(€/kWh)')
subplot(4,3,2)
hold on

plot(hourly_data.DateTime,hourly_data.power)
title('Load Profile (kW)')

subplot(4,3,3)
hold on

plot(hourly_data.DateTime,hourly_data.tramo_energy)
title('tramo horario')

subplot(4,3,4)
hold on

plot(hourly_data.DateTime,hourly_data.energy_cost)
title('Energy Cost(€)')
%
subplot(4,3,5)
hold on


subplot(4,3,6)
hold on

%ip = plot(hourly_data.DateTime,hourly_data.cost);
title('Total Cost(€)')

subplot(4,3,7)
hold on

bar([monthly_data.DateTime],[monthly_data.cost monthly_data.current_cost])

title('Monthly  Total Cost(€)')
legend('opt','current')
%xticks(ip.Parent.XTick(1:end-1))
grid on
ylim([0 1.2e4])

subplot(4,3,8)
hold on
bar([monthly_data.DateTime],[monthly_data.energy])
title('Monthly  Total Energy(kWh)')
grid on
%xticks(ip.Parent.XTick(1:end-1))

subplot(4,3,9)

bar([monthly_data.DateTime],[monthly_data.saving_cost])
title('Monthly  Saving Cost(€)')
%xticks(ip.Parent.XTick(1:end-1))
grid on


end

