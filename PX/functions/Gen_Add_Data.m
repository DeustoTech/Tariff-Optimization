function [hourly_data,monthly_data] = Gen_Add_Data(hourly_data,price_table_hourly,p_P,PowerTerms)

hourly_data.price = interp1(price_table_hourly.DateTime,price_table_hourly.price,hourly_data.DateTime);

%%
hourly_data.energy_cost = hourly_data.power.*hourly_data.price*1e-3;

PPP = p_P.Power_Price(:)';
hourly_data.power_cost_by_kW = PPP(hourly_data.tramo_power)';

%%

%% up power points
%%
ss =find(logical(diff(hourly_data.DateTime.Month)));
ss = [ ss ;length(hourly_data.DateTime) ];
id_start = 1;
%
month_energy_cost   = 0*ss;
month_energy_cum = 0*ss;
max_power_month  = 0*ss;

iter = 0;

for id_end = ss'
    iter = iter + 1;
    sl = id_start:id_end;
    month_energy_cum(iter)  = sum(hourly_data.power(sl),'omitnan');
    month_energy_cost(iter) = sum(hourly_data.energy_cost(sl),'omitnan');

    subselect = hourly_data(sl,:);

    for ip = 1:p_P.Number_Of_Power_Periods
        imax = max(subselect.power(subselect.tramo_power == ip));
        %
        if isempty(imax)
            imax = 0;
        end
        max_power_month(iter,ip)  = imax;
    end
    id_start = id_end + 1;
end

number_of_days = round(diff([1;ss])/24);
%%

monthly_data.power_cost = sum(number_of_days.*p_P.Power_Price',2);
monthly_data.energy_cost = month_energy_cost;

monthly_data.energy = month_energy_cum;
for j=1:size(max_power_month,2)
    monthly_data.("max_power_P"+j) = max_power_month(:,j);
end
monthly_data.DateTime = [hourly_data.DateTime(1); hourly_data.DateTime(ss(1:end-1))+days(1)];


monthly_data.penalization_power_cost = sum(200*(max_power_month > PowerTerms').*( max_power_month - PowerTerms').*p_P.Power_Price'.*number_of_days,2);

monthly_data.cost = monthly_data.penalization_power_cost + monthly_data.energy_cost;
%%
% month cost;
%

monthly_data = struct2table(monthly_data);

end