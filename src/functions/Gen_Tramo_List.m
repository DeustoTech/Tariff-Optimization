function final_hourly_data = Gen_Tramo_List(DateTime_Interval,np)

years_list = num2cell(unique(year(DateTime_Interval)));

iter = 0;
for n_year = years_list
    iter = iter + 1;
    year_str = num2str(n_year{:});
    days_list = Gen_Day_List_Hourly(year_str);

    if np == 6
        [TD60_Power] = TDXX_P6_energy_calendar(year_str);
        %
        hourly_data(iter).DateTime = days_list(:);
        hourly_data(iter).tramo_power = TD60_Power(:);
        hourly_data(iter).tramo_energy = TD60_Power(:);

    elseif np == 2
        [TD20_Power] = TD20_power_calendar(year_str);
        [TD20_Energy] = TD20_energy_calendar(year_str);
        %
        hourly_data(iter).DateTime = days_list(:);
        hourly_data(iter).tramo_power = TD20_Power(:);
        hourly_data(iter).tramo_energy = TD20_Energy(:);
    else
        error('Solo se puede generar un calendario de tramos para contratos con términos de potencia con 2 y 6 tramos.')
    end

    %hourly_data(iter) = struct2table(hourly_data(iter));
end

final_hourly_data.DateTime = vertcat(hourly_data(:).DateTime);
final_hourly_data.tramo_power = vertcat(hourly_data(:).tramo_power);
final_hourly_data.tramo_energy = vertcat(hourly_data(:).tramo_energy);

final_hourly_data = struct2table(final_hourly_data);

%%
ib1 = final_hourly_data.DateTime >= DateTime_Interval(1);
ib2 = final_hourly_data.DateTime <= DateTime_Interval(end);


final_hourly_data = final_hourly_data(logical(ib1.*ib2),:);

end

