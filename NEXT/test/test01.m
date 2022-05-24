%%
% Comprobamos que los construtores funcionan ademas de la suma
%%
clear
load('NEXT/data/mat/ex01_2013')
%%
Power_1 = load_curve_2013.Power(1:100);
DateTime_1 = load_curve_2013.DateTime(1:100);
%
iLC_1 = LoadCurve(DateTime_1,Power_1);

%%
Power_2 = load_curve_2013.Power(90:200);
DateTime_2 = load_curve_2013.DateTime(90:200);
%
iLC_2 = LoadCurve(DateTime_2,Power_2);
%%
iLC_sum = iLC_1 + iLC_2;
%%
iLC_minus = iLC_1 - iLC_2;
%%
iLC_minus_sat = nonNegative(iLC_minus);
%%

sty = {'LineWidth',2,'Marker','o'};
figure(1)
clf
plot(iLC_1,sty{:})
hold on
plot(iLC_2,sty{:})
plot(iLC_sum,sty{:})
plot(iLC_minus,sty{:})
plot(iLC_minus_sat,sty{:})
legend('LC_1','LC_2','LC_{+}','LC_{-}','LC_{-}^{sat}')