# 1. Optimizador de términos de potencia (MATLAB)

Abrimos una consola de MATLAB y escribimos el siguiente comando para descargar la librería
```matlab
unzip('https://github.com/DeustoTech/Tariff-Optimization/archive/refs/heads/main.zip','')
```
Entramos en la carpeta que se ha descargado 
```
cd Tariff-Optimization-main
```

Indicamos la direccion de la curva de carga 

```matlab
nfile_csv = 'data/csv/load_curves/ex01_2013.csv'; 
```
 La curva de Carga debera estar en fomato `.csv`. Deerá tener dos columnas: `DateTime`(dd-MM-yyyy) y `Power`[kWh]. Podemos ver un ejemplo escribiendo en una consola de bash
```bash
 >> !head  data/csv/load_curves/ex01_2013.csv
```
```
     DateTime              , Power 
     01-Jan-2013 00:15:00  , 21
     01-Jan-2013 00:30:00  , 19
     01-Jan-2013 00:45:00  , 20
     01-Jan-2013 01:00:00  , 19
     01-Jan-2013 01:15:00  , 21
     01-Jan-2013 01:30:00  , 23
     01-Jan-2013 01:45:00  , 22
     01-Jan-2013 02:00:00  , 23
     01-Jan-2013 02:15:00  , 22
```

Selecionamos los términos de potencia actuales por periodo. En este caso son dos periodes 
```matlab
c_PT = [300 100];  % [P1 P2]  en kW
c_PT = num2str(c_PT) % convertimos de number a tipo string
```
Además es necesario cargar el precio de la potencia por kilovatio y dia
```matlab
PPP = 1e-1*[3 2];  % [euros/(kW.dia)]
PPP = num2str(PPP) % convertimos de number a tipo string 
```
Se debe convertir a tipo `string` debido a que cuando compilemos este algoritmo todo será interpretado como `string`. 

Por último selecionamos el nombre del fichero de salida 
```matlab
out = 'out.json'; 
```
Ejecutamos el algoritmo llamando a la función `P2json`
```matlab
results = P2json(nfile_csv,c_PT,PPP,out);
```
Para ver la estructura que tiene los resultados podemos escribir lo siguiente en una consola de MATLAB:
```
printstruct(results,'printcontents',0)
```
```matlab
results
   |    
   |--- current                                        % Costes con término de potencia actuales
   |       |    
   |       |------------ FixedPower_cost___euros                 % Coste mensual fijo de la potencia  
   |       |----- PowerPenalization_cost___euros                 % Coste mensual de penalizacion
   |       |-- PowerTerms_price___MW_euros_hours                 % términos de potencia
   |       |------------ Power_part_cost___euros                 % Coste mensual potencial (Fijo + penalizacion)
   |       |----------------- Total_cost___euros                 % Coste total mensual (potencia + energia)
   |    
   |--- optimun                                        % Costes con término de potencia optimos
   |       |    
   |       |------------ FixedPower_cost___euros                 % Coste mensual fijo de la potencia  
   |       |----- PowerPenalization_cost___euros                 % Coste mensual de penalizacion
   |       |-- PowerTerms_price___MW_euros_hours                 % términos de potencia
   |       |------------ Power_part_cost___euros                 % Coste mensual potencial (Fijo + penalizacion)
   |       |----------------- Total_cost___euros                 % Coste total mensual (potencia + energia)
   |    
   |------------------ DateTime                        % Timestamp 
   |-- Energy_part_cost___euros                        % coste mensual de energía (sin potencia)

```

Además esta función habrá creado un fichero con el nombre dicho.  Para ver el resultado del algoritmo escribimos en una consola de bash
```bash
!cat out.json
```
En windows 
```
type out.json
```
El resultado será:
```json
{
  "current": 
  {
    "Total_cost___euros": [5656.7768564,4161.7512868000013,4760.5503532,4515.6508284,5470.406572,5199.1355980000008,5298.356218,4761.82147149091,5818.5834956,6017.6229888,5655.0253716000007,5265.6144159999994],
    "Power_part_cost___euros": [3658,3318.7840000000006,3622.784,3492.0000000000005,3585.584,3300.0000000000005,3445.216,3410,3418.0800000000004,3534,3538.0800000000004,3459.84],
    "PowerTerms_price___MW_euros_hours": [300,100],
    "PowerPenalization_cost___euros": [248,238.78400000000011,212.78399999999996,192,175.58399999999997,0,35.216000000000044,0,118.08000000000004,124,238.08000000000004,159.83999999999992],
    "FixedPower_cost___euros": [3410,3080.0000000000005,3410,3300.0000000000005,3410,3300.0000000000005,3410,3410,3300.0000000000005,3410,3300.0000000000005,3300.0000000000005]
  },
  "optimun": {
    "Total_cost___euros": [3966.6568564,2620.4072868000003,3105.6463532000007,2928.0508284000002,3852.702572,3803.5355980000004,3821.0202179999997,3319.7014714909096,4304.9034956,4451.502988799999,4021.3453716000004,3710.174416],
    "Power_part_cost___euros": [1967.88,1777.4400000000003,1967.88,1904.4000000000003,1967.88,1904.4000000000003,1967.88,1967.88,1904.4000000000003,1967.88,1904.4000000000003,1904.4000000000003],
    "PowerTerms_price___MW_euros_hours": [130.72,121.32000000000001],
    "PowerPenalization_cost___euros": [0,0,0,0,0,0,0,0,0,0,0,0],
    "FixedPower_cost___euros": [1967.88,1777.4400000000003,1967.88,1904.4000000000003,1967.88,1904.4000000000003,1967.88,1967.88,1904.4000000000003,1967.88,1904.4000000000003,1904.4000000000003]
  },
  "Energy_part_cost___euros": [ 1998.7768564, 842.96728680000024, 1137.7663532000004, 1023.6508283999999, 1884.822572, 1899.1355979999998, 1853.1402179999998, 1351.8214714909095, 2400.5034955999995, 2483.6229887999993, 2116.9453716, 1805.7744159999995
  ],
  "DateTime": [
    "01-Jan-2014 01:00:00",
    "01-Feb-2014 01:00:00",
    "01-Mar-2014 01:00:00",
    "01-Apr-2014 01:00:00",
    "01-May-2014 01:00:00",
    "01-Jun-2014 01:00:00",
    "01-Jul-2014 01:00:00",
    "01-Aug-2014 01:00:00",
    "01-Sep-2014 01:00:00",
    "01-Oct-2014 01:00:00",
    "01-Nov-2014 01:00:00",
    "01-Dec-2014 01:00:00"
  ]
} 
```


# 2. Ejecucion fuera de MATLAB

Para ejecutar este código fuera de matlab se debera compilar el el sistema operativo que luego se desea ejecutar. En la carpeta principal del código podemos compilar con el siguiente comando.
```matlab
compiler
```

Esto creará una carpeta en la misma carpeta donde cuelga la carpeta del `compiled`. Si entramos en esta carpeta en una consola de sistema operativo podemos ejecutar el algoritmo con el siguiente comando

```bash
>> !sh run_P2json.sh /Applications/MATLAB/MATLAB_Runtime/v910/ 'ex01_2013.csv' '300  100' '0.3 0.2' 'out.json'
```
Parametros: 
1. Dirección de la curva e carga: `'ex01_2013.csv'` (se ha copiado el fichero `ex01_2013.csv` de prueba)
2. Términos de potencia actuales:  `'300  100'`
3. Coste de potencia:  `'0.3 0.2' `
4. Nombre del fichero de salida:   `'out.json'`

Se creará un fichero `.json ` en la carpeta donde se ejecuta el comando 

## MATLAB Runtime (MATLAB sin licencia)

Es importante localizar correctamente el ejecutador de MATLAB en esta caso en el sistema operatico MacOS, la carpeta de MATLAB runtime esta en `/Applications/MATLAB/MATLAB_Runtime/v910/`

El enlace de ejecutador de matlab: 
[MATLAB Runtime (2021b)](https://es.mathworks.com/products/compiler/matlab-runtime.html). Se deberá instalar en el sistema operation y como mímimo la version (2021b)

En la documentacion de MATLAB ponen estas direcciones donde se encontrará la carpeta de matlab runtime.

| Operating System	| MATLAB Runtime Installation Folder      |
| ------- | ------ | 
| Windows	| "C:\Program Files\MATLAB\MATLAB Runtime\R2022b"     |
| Linux	| "/usr/local/MATLAB/MATLAB_Runtime/R2022b"           |
| macOS	| "/Applications/MATLAB/MATLAB_Runtime/R2022b"        |


[more info](https://es.mathworks.com/help/compiler/install-the-matlab-runtime.html)



#
#
# 
# 
# Mas Contenido de interes 

En esta librería hay una función de MATLAB para el cálculo de las potencias máximas a contratar además de una simulación del coste de la energía y una estimación de facturas mensuales. Para la ejecución de este algoritmo es necesario lo siguiente:

- Perfil de carga anual con una frecuencia de muestreo horario [en kW]
- Precio de la energía [€/MWh] a lo largo de timestamp de la curva de carga
- Precio de la potencia [kW/€/h]

En este repositorio se encuentra un historico de precios de la energía, sin embargo si se quiere realizar ejecuciones de este algoritmo fuera del rango de los datos, se puede generar un perfil de precio anuales. Este es una función de este repositorio que dado un precio de la energía para cada tramo horario (punta, llano y valle), además del año en el que queremos estos precios, generamos la curva de precios en el formato requerido para la ejecución del algoitmo anterior.


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
