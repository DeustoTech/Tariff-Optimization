%%
clear
name_file_csv = 'data/csv/load_curves/ex01_2013.csv';
current_power_terms = num2str([300 100]);
price_power_periods = num2str(1e-1*[3 2]);
out_file = 'out.json';
%%
results = P2json(name_file_csv,current_power_terms,price_power_periods,out_file);
%%

% P2json('data/csv/load_curves/ex01_2013.csv','300  100','0.3 0.2','out.json')

%%
clear
%
% Direccion de curga de Carga en .csv en kWh
%
nfile_csv = 'data/csv/load_curves/ex01_2013.csv'; 
%
% >> !head  data/csv/load_curves/ex01_2013.csv
%
%     DateTime              , Power
%     01-Jan-2013 00:15:00  , 21
%     01-Jan-2013 00:30:00  , 19
%     01-Jan-2013 00:45:00  , 20
%     01-Jan-2013 01:00:00  , 19
%     01-Jan-2013 01:15:00  , 21
%     01-Jan-2013 01:30:00  , 23
%     01-Jan-2013 01:45:00  , 22
%     01-Jan-2013 02:00:00  , 23
%     01-Jan-2013 02:15:00  , 22
%% Terminos de potencia actuales por periodo 
% [kW] - > [P1 P2] 
c_PT = [300 100]; 
c_PT = num2str(c_PT);
%% Precio de Potencia por Tramo horario
% [euros/(kW.dia)]
PPP = 1e-1*[3 2]; 
PPP = num2str(PPP);

%% Nombre del fichero de salida
out = 'out.json'; 
%%
results = P2json(nfile_csv,c_PT,PPP,out);
%%
printstruct(results,'printcontents',0)


%%
!cat out.json
