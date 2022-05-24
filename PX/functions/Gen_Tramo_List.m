function hourly_data = Gen_Tramo_List(year,np)

days_list = Gen_Day_List_Hourly(year);

if np == 6
    [TD60_Power] = TDXX_P6_energy_calendar(year);
    %
    hourly_data = [];
    hourly_data.DateTime = days_list(:);
    hourly_data.tramo_power = TD60_Power(:);
    hourly_data.tramo_energy = TD60_Power(:);

elseif np == 2
    [TD20_Power] = TD20_power_calendar(year);
    [TD20_Energy] = TD20_energy_calendar(year);
    %
    hourly_data = [];
    hourly_data.DateTime = days_list(:);
    hourly_data.tramo_power = TD20_Power(:);
    hourly_data.tramo_energy = TD20_Energy(:);
else
    error('Solo se puede generar un calendario de tramos para contratos con términos de potencia con 2 y 6 tramos.')
end

hourly_data = struct2table(hourly_data);

end

