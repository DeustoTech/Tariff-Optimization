function TD20_Energia = TD20_energy_calendar(year)


dini = datetime(year+"-01-01 00:00:00");
dend = datetime(year+"-12-31 00:00:00");

alldays = dini:dend;

ndays = length(alldays);

%%
festivos = holidays_list(year);
%%


%% Energia 
% 1- Punta 
% 2 - Lanno 
% 3 - Valle 

TD20_Energia = zeros(24,ndays);

%
for id = 1:ndays
   for in = 1:24
       fin_de_semana = ismember(weekday(alldays(id)),[7 1]);
       festivo = ismember(alldays(id),festivos);
       if (fin_de_semana ||festivo)
           TD20_Energia(in,id) = 3;
       else
           if in <= 8
              TD20_Energia(in,id) = 3;
           else
              % Llano 
              if ismember(in,[9 10 15:18 23 24])
                  TD20_Energia(in,id) = 2;
              else 
                  TD20_Energia(in,id) = 1;
              end
           end
       end 
   end
end

end

