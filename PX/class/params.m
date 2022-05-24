classdef params
    
%     Plan Negocio a Medida 6.1TD de Naturgy
% Periodo	Energía	Potencia
% P1	0.1802 €kWh	0.0837 €/kW día
% P2	0.1606 €kWh	0.0709 €/kW día
% P3	0.1368 €kWh	0.0408 €/kW día
% P4	0.1188 €kWh	0.0331 €/kW día
% P5	0.0985 €kWh	0.0108 €/kW día
% P6	0.0991 €kWh	0.0058 €/kW día

    properties (SetAccess = immutable)
        Number_Of_Power_Periods {mustBeMember(Number_Of_Power_Periods,[2,6])} = 2
    end 
    properties
         
        Power_Price       
        Current_Power_Term 
        Optimal_Power_Term
        Total_Current_Cost  double 
        Total_Opti_Cost     double
        Total_Saving        double
    end
    
    
    methods
        function obj = params(Number_Of_Power_Periods,Power_Price,Current_Power_Term)
            
            obj.Number_Of_Power_Periods = Number_Of_Power_Periods;
            obj.Power_Price = Power_Price;
            obj.Current_Power_Term = Current_Power_Term;

        end
        %%
        function obj = set.Power_Price(obj,value)
            if length(value) ~=obj.Number_Of_Power_Periods
               error('El número de elementos  de la lista de precios de la potencia máxima contratada [€/kWh] no coincide con el número de tramos de potencia') 
            end
            
            if ~prod(diff(value)<=0)
                error('El precio de los periodos debe estar ordenado de mayor a menor.')
            end
            %
            obj.Power_Price = value; 
        end
        %%
        function obj = set.Current_Power_Term(obj,value)
            if length(value) ~=obj.Number_Of_Power_Periods
               error('El número de elementos  de la lista de precios de la potencia máxima contratada [€/kWh] no coincide con el número de tramos de potencia') 
            end
            
            if ~prod(diff(value)<=0)
                error('El precio de los periodos debe estar ordenado de mayor a menor.')
            end
            
            obj.Current_Power_Term = value; 
        end
        %%
        function obj = set.Optimal_Power_Term(obj,value)
            if length(value) ~=obj.Number_Of_Power_Periods
               error('El número de elementos  de la lista de precios de la potencia máxima contratada [€/kWh] no coincide con el número de tramos de potencia') 
            end
            
            if ~prod(diff(value)<=0)
                error('El precio de los periodos debe estar ordenado de mayor a menor.')
            end
            
            obj.Optimal_Power_Term = value; 
        end
    end
end

