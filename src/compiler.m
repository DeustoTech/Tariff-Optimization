clear 
main_path = which('install_tariffopt');
main_path = replace(main_path,'install_tariffopt.m','');

cd(fullfile(main_path,'compiled'))

try 
    mcc -m P2json -a ../src -a ../data
    copyfile('../data/csv/load_curves/ex01_2013.csv','.')
    fprintf('Compilado correctamente\n')
catch 
    fprintf('Error en la compilacion\n ')
end

% test 
try 
    ! sh run_P2json.sh /Applications/MATLAB/MATLAB_Runtime/v910/ 'ex01_2013.csv' '300  100' '0.3 0.2' 'out.json'
    fprintf('Prueba pasada correctamente\n')
    ! cat out.json
catch
    fprintf('Error en la ejecucion\n ')
end
%
cd(main_path)