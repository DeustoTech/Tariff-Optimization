function tabla = Matrix2Table_calendar(tabla,year)

dini = datetime(year+"-01-01 00:00:00");
dend = datetime(year+"-12-31 00:00:00");

alldays = dini:dend;

[~,weekday_all] = weekday(alldays,'local');
%
Table_all_weekday = table(weekday_all,'VariableNames',{'Day'});

%%
name_vars = [repmat('T-',24,1),num2str((0:23)','%.2d'),repmat('-',24,1),num2str(1+(0:23)','%.2d')];
name_vars = arrayfun(@(i)name_vars(i,:),1:24,'UniformOutput',0);
%
Table_all_days = array2table(alldays','VariableNames',{'Date'});
%%
tabla = array2table(tabla','VariableNames',name_vars);
tabla = [Table_all_days,Table_all_weekday, tabla];

end

