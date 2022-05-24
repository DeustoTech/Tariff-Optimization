clear 


Power_Price = [0.0837 0.0709]/24;
Current_Power_Term = [20 10];

p_P = params(2,Power_Price,Current_Power_Term);

r = jsonencode(struct(p_P));

fileID = fopen('data/json/input_P2.json','w');

fwrite(fileID,r);
fclose(fileID);
%%
!cat data/json/input_P2.json
%%
% Plan Negocio a Medida 6.1TD de Naturgy
% Periodo	Energía	Potencia
% P1	0.1802 €kWh	0.0837 €/kW día
% P2	0.1606 €kWh	0.0709 €/kW día
% P3	0.1368 €kWh	0.0408 €/kW día
% P4	0.1188 €kWh	0.0331 €/kW día
% P5	0.0985 €kWh	0.0108 €/kW día
% P6	0.0991 €kWh	0.0058 €/kW día

Power_Price = [0.0837 0.0709 0.0408 0.0331 0.0108 0.0058]/24;
Current_Power_Term = [50 10 5 4 2 1];

p_P = params(6,Power_Price,Current_Power_Term);

r = jsonencode(struct(p_P));

fileID = fopen('data/json/input_P6.json','w');

fwrite(fileID,r);
fclose(fileID);

%%
!cat data/json/input_P6.json


