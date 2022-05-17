function festivos = holidays_list(year)

try
r = webread("https://holidayapi.com/v1/holidays?pretty&key=3b3f26d6-e02e-4515-8e33-6683792226b6&country=ES&year="+year);

festivos = arrayfun(@(i) datetime(r.holidays(i).date,'Format','yyyy/MM/dd'),1:length(r.holidays))';
catch
    festivos = datetime("01-Jan-"+year);
end

end

