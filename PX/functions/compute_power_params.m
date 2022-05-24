function [maxPotenciaContratada,hourly_data] = compute_power_params(load_curve,np)

load_curve = readtable(load_curve);

n_year = unique(load_curve.DateTime.Year);

if length(n_year)>1
    error('The load profile must have a unique year')
end

year = num2str(n_year);
%%
hourly_data = Gen_Tramo_List(year,np);

power_interp_in_tramos = interp1(load_curve.DateTime,load_curve.Power,hourly_data.DateTime);

%%
hourly_data.power = power_interp_in_tramos;

%%
maxPotenciaContratada = zeros(np,1);

%%
for itramo = 1:np
    power_period = hourly_data.power((hourly_data.tramo_power == itramo));
    maxPotenciaContratada(itramo) = max(power_period);
end
%%
for itramo = np:-1:2
    if maxPotenciaContratada(itramo-1) < maxPotenciaContratada(itramo)
         maxPotenciaContratada(itramo-1) =  maxPotenciaContratada(itramo);
    end
end


end

