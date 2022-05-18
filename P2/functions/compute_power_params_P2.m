function [maxPower,TD20_Power_list] = compute_power_params_P2(load_curve)

load_curve = readtable(load_curve);
n_year = unique(load_curve.DateTime.Year);

if length(n_year)>1
    error('The load profile must have a unique year')
end
year = num2str(n_year);
%%
TD20_Power_list = Gen_Tramo_List_P2(year);

power_interp_in_tramos = interp1(load_curve.DateTime,load_curve.Power,TD20_Power_list.DateTime);

%%
TD20_Power_list.power = power_interp_in_tramos;

%%
maxPower = zeros(2,1);

%%
for itramo = 1:2
    power_period = TD20_Power_list.power((TD20_Power_list.tramo_power == itramo));
    maxPower(itramo) = max(power_period);
end
%%
for itramo = 2:-1:2
    if maxPower(itramo-1) < maxPower(itramo)
         maxPower(itramo-1) =  maxPower(itramo);
    end
end


end
