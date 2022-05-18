function TD20_Potencia = TD20_power_calendar(year)


dini = datetime(year+"-01-01 00:00:00");
dend = datetime(year+"-12-31 00:00:00");

alldays = dini:dend;

ndays = length(alldays);

%%
festivos = holidays_list(year);
%%

TD20_Potencia = zeros(24,ndays);

%% Potencia 
% 1 - Punta 
% 2 - Valle
%
for id = 1:ndays
   for in = 1:24
       fin_de_semana = ismember(weekday(alldays(id)),[7 1]);
       festivo = ismember(alldays(id),festivos);
       if (fin_de_semana ||festivo)
           TD20_Potencia(in,id) = 2;
       else
           if in < 8
              TD20_Potencia(in,id) = 2;
           else
              TD20_Potencia(in,id) = 1;
           end
       end 
   end
end


end

