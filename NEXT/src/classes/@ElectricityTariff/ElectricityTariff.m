classdef ElectricityTariff
    
    properties (SetAccess =  immutable)
        DateTime        (1,:)   datetime
        PowerPeriod     (1,:)   double
        EnergyPeriod    (1,:)   double
        np              (1,1)   double 
    end

    properties 
        PriceEnergy  (1,:) double
        PowerPrices        double
        PowerTerms         double

    end
    methods

        
        function obj = ElectricityTariff(DateTime,np)
            %np = length(PowerPrices);
            DateTime_interval = [DateTime(1) DateTime(end)];
            tramos = Gen_Tramo_List(DateTime_interval,np);
            
            obj.DateTime = tramos.DateTime;
            obj.PowerPeriod = tramos.tramo_power;
            obj.EnergyPeriod = tramos.tramo_energy;
            %
            obj.np = np;
            %obj.PowerPrices = PowerPrices;
        end
        %%
        function plotEnergy(obj,varargin) 
           plot(obj.DateTime,obj.EnergyPeriod,varargin{:})
           ylabel('Energy Periods')
           yticks(unique(obj.EnergyPeriod))
           yticklabels("P_"+unique(obj.EnergyPeriod))
           grid on
        end
        %%
        function plotPower(obj,varargin)
            
           plot(obj.DateTime,obj.PowerPeriod,varargin{:})
           ylabel('Power Periods')
           yticks(unique(obj.PowerPeriod))
           yticklabels("P_"+unique(obj.PowerPeriod))
           grid on
        end        
        %%
        function obj = genEnergyPrice(obj,prices_list)
            price_curve = arrayfun(@(i)prices_list(i)*(obj.EnergyPeriod == i),1:length(prices_list),'UniformOutput',false);
            price_curve = sum([price_curve{:}],2);
            obj.PriceEnergy = price_curve;
        end
        %%
        function obj = genHistoricalEnergyPrice(obj)
           path_file =  fullfile(replace(which('Tar_Opt_main_script'),'Tar_Opt_main_script.m',''),'data','mat','price_energy.mat');
           price_table = load(path_file);
           price_table = price_table.all_price_table;
           %
           if obj.DateTime(1) <  price_table.DateTime(1)
              error("No hay datos para "+string(obj.DateTime(1))) 
           end
           
          if obj.DateTime(end) >  price_table.DateTime(end)
              error("No hay datos para "+string(obj.DateTime(end)))
          end
           
           %
           PriceObj = interp1(price_table.DateTime,price_table.price,obj.DateTime);
           obj.PriceEnergy = PriceObj;
        end
        %%
        function bill = PowerFixedCost(obj)
            if isempty(obj.PowerTerms)
               error('La variable PowerTerms esta vacia. Debe asignar un termino de potencia para cada periodo') 
            end
  
            bill = PowerFixedCostWithTerms(obj,obj.PowerTerms);
           
        end
        
        %%
       function bill = PowerFixedCostWithTerms(obj,PowerTerms)

            if isempty(obj.PowerPrices)
               error('La variable PowerPrices esta vacia. Debe asignar un precio de potencia para cada periodo') 
            end           
            
            DateChangeMonth = days(1) + obj.DateTime(logical(diff(obj.DateTime.Month)));
            
            if DateChangeMonth(1) ~= obj.DateTime(1)
                DateChangeMonth = [obj.DateTime(1) DateChangeMonth];
            end
            if DateChangeMonth(end) ~= obj.DateTime(end)
                DateChangeMonth = [DateChangeMonth obj.DateTime(end)];
            end
            for i = 1:length(DateChangeMonth)
                DateChangeMonth(i).Hour = 1;
                DateChangeMonth(i).Minute = 0;
                DateChangeMonth(i).Second = 0;
            end
            ndays = days(diff(DateChangeMonth));
            
            
            bill.cost = sum(obj.PowerPrices.*ndays'.*PowerTerms,2);
            bill.DateTime   = DateChangeMonth(1:end-1)';
        end      
        
    end
end

