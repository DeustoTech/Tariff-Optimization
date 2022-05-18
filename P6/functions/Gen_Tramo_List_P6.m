function TD60_Power_list = Gen_Tramo_List_P6(year)


[TD60_Power] = TDXX_P6_energy_calendar(year);
days_list = Gen_Day_List_Hourly(year);

%%
TD60_Power_list = [];
TD60_Power_list.DateTime = days_list(:);
TD60_Power_list.tramo_power = TD60_Power(:);
TD60_Power_list.tramo_energy = TD60_Power(:);

TD60_Power_list = struct2table(TD60_Power_list);


end

