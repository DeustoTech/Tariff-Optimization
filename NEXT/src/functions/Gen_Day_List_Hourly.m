function days_list = Gen_Day_List_Hourly(year)


dini = datetime(year+"-01-01 00:00:00");

dend = dini;
dend.Year = dend.Year + 1;

days_list = dini:hours(1):dend;
days_list(end) = [];

end

