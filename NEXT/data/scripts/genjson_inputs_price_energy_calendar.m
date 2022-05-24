ipc = params_energy_calendar_price;
ipc.year = 2013;

fid = fopen('data/json/input_energy_calendar.json','w');
fwrite(fid,jsonencode(ipc))
fclose(fid)