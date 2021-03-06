%%
clear
load('data/mat/ex01_2013')
%%
Power_1 = load_curve_2013.Power(200:19800);
DateTime_1 = years(1)+load_curve_2013.DateTime(200:19800);
%
iLC_1 = LoadCurve(DateTime_1,Power_1);

%%
np = 2;
iET_1 = generateElectricityTariff(iLC_1,np);

%%
figure
sty = {'LineWidth',2};

subplot(2,1,1)
plotEnergy(iET_1,sty{:})
subplot(2,1,2)
plotPower(iET_1,sty{:})

%%
%
iET_2 = ElectricityTariff(iLC_1.DateTime,np);
iET_2 = genHistoricalEnergyPrice(iET_2);
%%
plot(iET_2.DateTime,iET_2.PriceEnergy)
%%
iET_2.PowerTerms  = [300 100];      %
iET_2.PowerPrices = 1e-1*[3 2];     % 

%%
ibill = MonthlyBill(iLC_1,iET_2);
%%
ibill = compute(ibill);

%%
optPowerTerms = ComputeOptimalPowerTerms(ibill);

ibill.ElectricityTariff.PowerTerms = optPowerTerms;
%%
ibill = compute(ibill);
%%
clf
bar(ibill.DateTime,[ibill.Total ...
                    ibill.TotalPower ...
                    ibill.FixedPower ...
                    ibill.Energy ...
                    ibill.PowerPenalization])
legend('Total','Total Power','Fixed Power','Total Energy','Power Penalization')
ylabel('Cost (€)')
%%
clf
bar(ibill.DateTime,[ibill.Total ...
                    ibill.TotalPower ...
                    ibill.Energy])
legend('Total','Total Power','Total Energy')
ylabel('Cost (€)')
grid on