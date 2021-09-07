%% TD 2.0
r = webread('https://holydayapi.herokuapp.com/holidays/city_code/50297/year/2021');


festivos = arrayfun(@(i) datetime(r(i).day,'Format','dd/MM/yyyy'),1:length(r))';

dini = datetime('2021-01-01 00:00:00');
dend = datetime('2021-12-31 00:00:00');

alldays = dini:dend;

ndays = length(alldays);

%%

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
              % Lano 
              if ismember(in,[9 10 15:18 23 24])
                  TD20_Energia(in,id) = 2;
              else 
                  TD20_Energia(in,id) = 1;
              end
           end
       end 
   end
end

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


%%
[~,weekday_all] = weekday(alldays,'local');
%
Table_all_weekday = table(weekday_all,'VariableNames',{'Day'});

%%
name_vars = [repmat('T-',24,1),num2str((0:23)','%.2d'),repmat('-',24,1),num2str(1+(0:23)','%.2d')];
name_vars = arrayfun(@(i)name_vars(i,:),1:24,'UniformOutput',0);
%
Table_all_days = array2table(alldays','VariableNames',{'Date'});
%%
TD60_Poten_tabla = array2table(TD60_Poten','VariableNames',name_vars);
TD60_Poten_tabla = [Table_all_days,Table_all_weekday, TD60_Poten_tabla];

writetable(TD60_Poten_tabla,'csv/3.0TD-6.1TD-Potencia-Energia.csv')
%%
TD20_Energia_tabla = array2table(TD20_Energia','VariableNames',name_vars);
TD20_Energia_tabla = [Table_all_days,Table_all_weekday, TD20_Energia_tabla];

writetable(TD20_Energia_tabla,'csv/2.0TD-Energia.csv')
%%
TD20_Potencia_tabla = array2table(TD20_Potencia','VariableNames',name_vars);
TD20_Potencia_tabla = [Table_all_days,Table_all_weekday, TD20_Potencia_tabla];

writetable(TD20_Potencia_tabla,'csv/2.0TD-Potencia.csv')
%% Energia y Potencia
fig1 = figure('unit','norm','pos',[0 0 1 1]);

ndays = 365;
surf((0:23),alldays( 1:ndays),TD60_Poten_tabla{1:ndays,3:end});view(0,-90)
xlabel('hours')
colormap('jet')
xlim([0 23])
xticks(0:23)

colorbar 
colormap([1 0 0;
          1 1 0;
          0 0 1;
          1 0 1;
          1 0.5 0;
          0 1 0])
  title('Energia-Potencia 3.0TD-6.1TD ')
   
 caxis([1 6])
  print(fig1,'img/3.0TD-6.1TD-Energia-Potencia.png','-dpng')

 %% Energia
fig2 = figure('unit','norm','pos',[0 0 1 1]);
ndays = 365;
surf(0:23,alldays( 1:ndays),TD20_Energia_tabla{1:ndays,3:end});view(0,-90)
xlabel('hours')
colormap('jet')
xlim([0 23])
xticks(0:23)
colorbar 
colormap([1 0 0;
          1 1 0;
          0 1 0])
      
 caxis([1 3])
 title('Energia 2.0TD')
 print(fig2,'img/2.0TD-Energia.png','-dpng')
 %% Potencia
 ndays = 365;
fig3 = figure('unit','norm','pos',[0 0 1 1]);
surf(0:23,alldays( 1:ndays),TD20_Potencia_tabla{1:ndays,3:end});view(0,-90)
xlabel('hours')
colormap('jet')
xlim([0 23])
xticks(0:23)

title('Potencia 2.0TD')
colorbar 
colormap([1 0 0;
          0 1 0])
      
 caxis([1 2])
 
 print(fig3,'img/2.0TD-Potencia.png','-dpng')