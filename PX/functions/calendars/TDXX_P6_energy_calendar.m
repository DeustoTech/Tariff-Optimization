function [TD60_Poten] = TDXX_P6_energy_calendar(year)



dini = datetime(year+"-01-01 00:00:00");
dend = datetime(year+"-12-31 00:00:00");

alldays = dini:dend;

ndays = length(alldays);

%%
festivos = holidays_list(year);
%%
%% Energia y Potencia 3.0TD 6.1TD 6.2TD, ...
%
% P1
% P2 
% P3 
% P4 
% P5 
% P6

TD60_Poten = zeros(24,ndays);

%
for id = 1:ndays
   for in = 1:24
       fin_de_semana = ismember(weekday(alldays(id)),[7 1]);
       festivo = ismember(alldays(id),festivos);
       
       type_of_mo = [];
       if ismember(alldays(id).Month,[1 2 7 12])
            type_of_mo = 'ALTA';
       elseif ismember(alldays(id).Month,[3 11])
            type_of_mo = 'MEDIA_ALTA';
       elseif ismember(alldays(id).Month,[6 8 9])
            type_of_mo = 'MEDIA';
       elseif  ismember(alldays(id).Month,[4 5 10])
            type_of_mo = 'BAJA';
       end
       
       
       if (fin_de_semana ||festivo)
           TD60_Poten(in,id) = 6;
       else
           if in <= 8
              TD60_Poten(in,id) = 6;
           else

              if ismember(in,[10:14 19:22])
                    switch type_of_mo
                        case 'ALTA'
                            TD60_Poten(in,id) = 1;
                        case 'MEDIA_ALTA'
                            TD60_Poten(in,id) = 2;
                        case 'MEDIA'
                            TD60_Poten(in,id) = 3;
                        case 'BAJA'
                            TD60_Poten(in,id) = 4;
                    end
              elseif  ismember(in,[9 15:18 23 24])
                    switch type_of_mo
                        case 'ALTA'
                            TD60_Poten(in,id) = 2;
                        case 'MEDIA_ALTA'
                            TD60_Poten(in,id) = 3;
                        case 'MEDIA'
                            TD60_Poten(in,id) = 4;
                        case 'BAJA'
                            TD60_Poten(in,id) = 5;
                    end
              end
           end
       end
   end 
end

end

