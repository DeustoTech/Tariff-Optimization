classdef MonthlyBill
    %BILL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        LoadCurve           LoadCurve
        ElectricityTariff   ElectricityTariff
        Total
        DateTime
        Energy
        TotalPower
        FixedPower
        PowerPenalization
    end
    
    methods
        
        function obj = MonthlyBill(LoadCurve,ElectricityTariff)

            LC = LoadCurve;
            ET = ElectricityTariff;
            %
            if sum(days(LC.DateTime - ET.DateTime)) ~= 0;
                error('La propiedad DateTime de LoadCurve y ElectricityTariff debe ser la misma.')
            end
            
            if isempty(ET.PriceEnergy)
               error('Debe fijarse el precio de la energía en la lista de hora definidas en DateTime.') 
            end
            obj.LoadCurve = LC;
            obj.ElectricityTariff = ET;
            %

            if isempty(ET.PowerTerms)
               error('La variable PowerTerms esta vacia. Debe asignar un termino de potencia para cada periodo') 
            end
            if isempty(ET.PowerPrices)
               error('La variable PowerPrices esta vacia. Debe asignar un precio de potencia para cada periodo') 
            end           
            
            
        end
        
        function obj = compute(obj)
            ET = obj.ElectricityTariff;
            LC = obj.LoadCurve;
            
            PowerBill = PowerFixedCost(ET);
            %%
            
            %%
            % CORREGIR - DIFERENCIAR ENTRE MESES DE DIFERENTES ANOS
%             months_list = unique(month(ET.DateTime));
            months_list = unique(month(ET.DateTime)+"-"+year(ET.DateTime),'stable');
            EnergyCostHourly = 1e-3*ET.PriceEnergy.*LC.Power;
            
            EnergyBillMonthly = zeros(length(months_list),1);
            %
            iter = 0;
            
            RealPowerTerm = zeros(length(months_list),ET.np);
            for imonth = months_list
                iter = iter + 1;
                imonth =  split(imonth,'-');
                iyear = str2num(imonth{2});
                imonth = str2num(imonth{1});
                EnergyBillMonthly(iter)  = sum(EnergyCostHourly( LC.DateTime.Month == imonth));

                for ip = 1:ET.np
                    id_y = (LC.DateTime.Year == iyear);
                    id_m = (LC.DateTime.Month == imonth);
                    id_b = logical(id_m.*id_y.*(ET.PowerPeriod == ip));
                    if sum(id_b) == 0
                    else
                    RealPowerTerm(iter,ip) = max(LC.Power( id_b));
                    end
                end
            end
            %%
            
            %%
            penalization_bill = PowerFixedCostWithTerms(ET,2*sat(RealPowerTerm - ET.PowerTerms));
            %%
            obj.PowerPenalization = penalization_bill.cost;
            obj.FixedPower   = PowerBill.cost ;
            obj.TotalPower   = PowerBill.cost + penalization_bill.cost;
            obj.Energy  = EnergyBillMonthly;
            obj.DateTime    = PowerBill.DateTime;
            for jj = 1:length(obj.DateTime)
                    obj.DateTime(jj).Day = 1;
            end

            obj.Total        = obj.TotalPower + obj.Energy;
        end
        
        function optPowerTerms = ComputeOptimalPowerTerms(obj)
            ET = obj.ElectricityTariff;
            LC = obj.LoadCurve;
            
            %%
            months_list = unique(month(ET.DateTime));
            
            EnergyCostHourly = 1e-3*ET.PriceEnergy.*LC.Power;
            
            EnergyBillMonthly = zeros(length(months_list),1);
            %
            iter = 0;
            
            RealPowerTerm = zeros(length(months_list),ET.np);
            for imonth = months_list
                iter = iter + 1;
                EnergyBillMonthly(iter)  = sum(EnergyCostHourly( LC.DateTime.Month == imonth));
                for ip = 1:ET.np
                    id_b = logical((LC.DateTime.Month == imonth).*(ET.PowerPeriod == ip));
                    RealPowerTerm(iter,ip) = max(LC.Power( id_b));
                end
            end
            optPowerTerms = max(RealPowerTerm);
        end
    end
end


function r = sat(x)
    r = x;
    r(r < 0) = 0;
end
