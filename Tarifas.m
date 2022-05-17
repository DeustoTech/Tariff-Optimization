clear
%
ndays = 365;
%
year = "2016";
TD20_Potencia   = TD20_power_calendar(year);
TD20_Energia    = TD20_energy_calendar(year);
TD60_Power      = TDXX_P6_energy_calendar(year);


%%
TD20_Potencia_tabla  = Matrix2Table_calendar(TD20_Potencia,year);
TD20_Energia_tabla   = Matrix2Table_calendar(TD20_Energia,year);
TD60_Poten_tabla     = Matrix2Table_calendar(TD60_Power,year);

%%

writetable(TD60_Poten_tabla,'csv/3.0TD-6.1TD-Potencia-Energia.csv')
writetable(TD20_Energia_tabla,'csv/2.0TD-Energia.csv')
writetable(TD20_Potencia_tabla,'csv/2.0TD-Potencia.csv')

%% Energia y Potencia
fig1 = figure('unit','norm','pos',[0 0 1 1]);

surf((0:23),TD60_Poten_tabla.Date(1:ndays),TD60_Poten_tabla{1:ndays,3:end});view(0,-90)
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
surf(0:23,TD20_Energia_tabla.Date( 1:ndays),TD20_Energia_tabla{1:ndays,3:end});view(0,-90)
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
fig3 = figure('unit','norm','pos',[0 0 1 1]);
surf(0:23,TD20_Potencia_tabla.Date( 1:ndays),TD20_Potencia_tabla{1:ndays,3:end});view(0,-90)
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