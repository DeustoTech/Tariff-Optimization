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

<img width="600" alt="Screenshot 2022-05-19 at 08 32 25" src="https://user-images.githubusercontent.com/41575404/169225695-051302fd-6043-4ce3-99fe-e2e99000a4b8.png">


# Ejecucion fuera de MATLAB

En el fichero `compiler` se encuentran las instrucciones para compilar esta función en un ejecutable independiente de la MATLAB. Es necesario tener instalado MATLAB Runtime (no requiere licencia de MATLAB)

https://es.mathworks.com/help/compiler/standalone-applications.html


# Generacion de calendario de tarifa

Si no tenemos el precio horario de la energía en el año de interes, podemos generar un calendario solo definiendo el precio de la energía por periodo. Este se ejecuta de la siguiente manera en la consola de comandos de MATLAB
``` matlab
jsonfile = 'data/json/input_energy_calendar.json'
>> gen_energy_hourly_price_P2_json(jsonfile)
```
Donde `data/json/input_energy_calendar.json` tiene el siguiente formato:
```
>> type data/json/input_energy_calendar.json
```

```json
{"energy_list_P2":[0.1,0.05,0.01],"year":2013}
>> 
```

Parámetros 
- energy_list_P2: Lista de precios de la energía para los periodos P1 (punta), P2(llano) ,P3(valle) en [€/MWh]
- year: Año en el que se quiere generar el calendario de precios

La ejecución de este programa genera un fichero .csv llamado `energy_price_table.csv` con el siguiente formato:

```matlab
>> !more energy_price_table.csv

DateTime,price

01-Jan-2013 00:00:00,0.01

01-Jan-2013 01:00:00,0.01

01-Jan-2013 02:00:00,0.01

01-Jan-2013 03:00:00,0.01

01-Jan-2013 04:00:00,0.01

01-Jan-2013 05:00:00,0.01

01-Jan-2013 06:00:00,0.01

01-Jan-2013 07:00:00,0.01
```
