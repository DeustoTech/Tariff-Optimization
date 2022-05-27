clear
load('NEXT/data/mat/ex01_2013')
%%
Power = load_curve_2013.Power;
DateTime = load_curve_2013.DateTime;
%
iLC = LoadCurve(DateTime,Power);

%%
figure
plot(iLC)