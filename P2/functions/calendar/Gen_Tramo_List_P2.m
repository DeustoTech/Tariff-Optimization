function TD20_Power_list = Gen_Tramo_List_P2(year)

    TD20_Power  = TD20_power_calendar(year);
    TD20_Energy = TD20_energy_calendar(year);

    days_list = Gen_Day_List_Hourly(year);

    %%
    TD20_Power_list = [];
    TD20_Power_list.DateTime = days_list(:);
    TD20_Power_list.tramo_power = TD20_Power(:);
    TD20_Power_list.tramo_energy = TD20_Energy(:);

    TD20_Power_list = struct2table(TD20_Power_list);

end

