function calendar_energy_P2 = gen_energy_hourly_price_P2(energy_list_P2,year)

    calendar_energy_P2 = Gen_Tramo_List_P2(year);
    calendar_energy_P2.price = energy_list_P2(calendar_energy_P2.tramo_energy)';
    calendar_energy_P2.tramo_power = [];
    calendar_energy_P2.tramo_energy = [];
    
end

