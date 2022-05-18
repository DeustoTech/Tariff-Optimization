# Optimización de Tarifa

En este repositorio se presenta dos funciones principales para el cálculo de potencia de contratación óptimas, dado un perfil de carga anual con una frecuencia de muestreo horaria. 

- Tarifas TD2.0


`P2/scripts/Tarifas_P2`



Parametros de entrada 

- load_curve_csv : path donde se encuentra el csv con la curva de carga en kW (template - > data/price_table_2013.csv)
- price_table_hourly : path donde se encuentra el csv de precios de energía €/MWh (template - > data/ex01_2013.csv)
- input_json: ficharo json con el formato presentado en `data/input_P2.json` donde se encuentra los precios de la potencia contratada por periodo

Ejemplo de ejecución 

```matlab

price_table_hourly  = 'data/price_table_2013.csv';     % ejemplo de curva de precio de la energía (€/MWh) 
load_curve_csv      = 'data/ex01_2013.csv';            % ejemplo de curva de carga (MW)
input_json          = 'data/input_P2.json';            % path

compute_tarrif_P2(load_curve_csv,price_table_hourly,input_json);
```

El programa escribe los ficheros:
* hourly_data.csv:      Columnas: `{'cost'}    {'energy'}    {'DateTime'}`     
* monthly_data:         Columnas:  `{'DateTime'}    {'tramo_power'}    {'tramo_energy'}    {'power'}    {'price'}    {'energy_cost'}    {'power_cost_by_kW'}    {'power_cost'}    {'cost'}`
* tariff_P2_output.json: 
```json
{"PowerPrice":[0.0034874999999999997,0.002954166666666667],"Potencia_de_contratacion_opt":[130,88]}
```

A continuación se muestra la potencia máxima  de contratación para el periodo P1, punta y P2 valle.

<img src="https://user-images.githubusercontent.com/41575404/168993012-0121fd28-9928-4cdc-9fd3-f16df5e97605.png" width="600" >

Dado estos parámetros y el precio de la energía podemos calcular el costo total diario y mensual

<img src="https://user-images.githubusercontent.com/41575404/168993012-0121fd28-9928-4cdc-9fd3-f16df5e97605.png" width="600">


# Ejecucion fuera de MATLAB

En el fichero `compiler` se encuentran las instrucciones para compilar esta función en un ejecutable independiente de la MATLAB. Es necesario tener instalado MATLAB Runtime (no requiere licencia de MATLAB)

https://es.mathworks.com/help/compiler/standalone-applications.html

