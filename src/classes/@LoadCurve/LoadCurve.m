classdef LoadCurve
    
    properties (SetAccess =  immutable)
        DateTime    (1,:) datetime
        Power       (1,:) double
    end

    
    methods

        
        function obj = LoadCurve(DateTime,Power)
            
            if length(DateTime) ~= length(Power)
               error('DateTime and Power array must have the same length') 
            end
            
            obj.DateTime = DateTime;
            obj.Power    = Power;
            %%
            initDT = DateTime(1);
            initDT.Minute = 0;
            initDT.Second = 0;
            
            %%
            endDT = DateTime(end);
            endDT.Minute = 0;
            endDT.Second = 0;
            
            %%
            newDateTime = initDT:hours(1):endDT;
            newPower = interp1(obj,newDateTime);
            
            %%
            obj.DateTime = newDateTime;
            obj.Power    = newPower;
        end
        
        
        function newobj = plus(obj1,obj2)
            newDateTime = [obj1.DateTime obj2.DateTime];
            newDateTime = sort(newDateTime);
            newDateTime = newDateTime(1):hours(1):newDateTime(end);
            
            Power1 = interp1(obj1,newDateTime);
            Power2 = interp1(obj2,newDateTime);
            
            newobj = LoadCurve(newDateTime,Power1 + Power2);
        end
        %%
        function newobj = minus(obj1,obj2)
            newDateTime = [obj1.DateTime obj2.DateTime];
            newDateTime = sort(newDateTime);
            newDateTime = newDateTime(1):hours(1):newDateTime(end);
            
            Power1 = interp1(obj1,newDateTime);
            Power2 = interp1(obj2,newDateTime);
            
            newobj = LoadCurve(newDateTime,Power1 - Power2);
        end
        %%
        function newPower = interp1(obj,newDateTime)
            newPower = interp1(obj.DateTime,obj.Power,newDateTime);
            newPower(isnan(newPower)) =  0;
        end
        %%
        function obj = nonNegative(obj)
            nonNegativePower = obj.Power;
            nonNegativePower(nonNegativePower<0) = 0;
            obj = LoadCurve(obj.DateTime,nonNegativePower);
        end
        function plot(obj,varargin)
           plot(obj.DateTime,obj.Power,varargin{:})
           ylabel('Power (kWh)')
           grid on
        end
        %%
        function PC = generateElectricityTariff(obj,PowerTerms)
            PC = ElectricityTariff(obj.DateTime,PowerTerms);
        end
    end
end

