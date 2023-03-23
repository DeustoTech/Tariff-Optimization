

clear
InitDates = datetime('01-Jan-2014'):days(28):datetime('15-Feb-2023');
% InitDates = datetime('01-Jan-2014'):days(28):datetime('01-Sep-2022');
%InitDates = datetime('01-Jan-2022'):days(20):datetime('01-May-2022');

%%
figure(6)
clf
hold on
ylabel('€/MWh')
opt = weboptions;
opt.Timeout = 15;
for j = 1:length(InitDates)-1

InitDate = InitDates(j);
EndDate  = InitDates(j+1) - hours(1);
%%
r = webread("https://apidatos.ree.es/es/datos/mercados/precios-mercados-tiempo-real?start_date="+ ...
                datestr(InitDate,'yyyy-mm-ddThh:MM')+ ...
                "&end_date=" + ...
                datestr(EndDate,'yyyy-mm-ddThh:MM') + ...
                "&time_trunc=hour",opt);
if length(r.included)>1
    r.included(2)
    data = r.included(2).attributes.values;
else
    r.included(1)
    data = r.included(1).attributes.values;
end
%%
DateTime = vertcat(data.datetime);
DateTime(:,11) = ' ';
GMT = DateTime(:,24:end);

DateTime = DateTime(:,1:23);
DateTime = datetime(DateTime);
Values = [data.value];

price_table{j}.DateTime = DateTime;
price_table{j}.price = Values';
price_table{j}= struct2table(price_table{j});
%
%%
plot(price_table{j}.DateTime,price_table{j}.price)

%%
pause(0.1)
end


all_price_table = vertcat(price_table{:});

all_price_table(diff(all_price_table.DateTime) == 0,:) = [];

%%

save('data/mat/price_energy','all_price_table')

%% 
load('data/mat/price_energy')
price_table_2013 = all_price_table;
price_table_2013.DateTime = price_table_2013.DateTime - years(8);

price_table_2013(diff(price_table_2013.DateTime) == 0,:) = [];

save('data/mat/price_table_2013','price_table_2013')

writetable(price_table_2013,'data/csv/price_table_2013.csv')


