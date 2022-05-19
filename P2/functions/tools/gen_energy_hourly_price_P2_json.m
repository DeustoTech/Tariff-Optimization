function gen_energy_hourly_price_P2_json(jsonfile)


fid = fopen(jsonfile,'r');
params = jsondecode(fscanf(fid,'%s'));

list_price = reshape(params.energy_list_P2,1,3);
table =gen_energy_hourly_price_P2(list_price,params.year);

writetable(table,'energy_price_table.csv')

end

