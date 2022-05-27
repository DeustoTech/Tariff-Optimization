clear
%
pathtest = which('run_all_test_tariff_optimization');
pathtest = replace(pathtest,'run_all_test_tariff_optimization.m','');

r = what(pathtest);

rm_indx = strcmp('run_all_test_tariff_optimization.m',r.m);

mfiles = r.m(~rm_indx);

%
for itest =  mfiles'
   close all
   save('TEST_WS.mat')

   try 
        eval(replace(itest{:},'.m',''))
        load('TEST_WS.mat')
        fprintf("Pass Test = "+itest{:}+"\n")
        fprintf("-----------------\n")
   catch err
        load('TEST_WS.mat')
        fprintf("Error Test = "+itest{:}+"\n")
        fprintf("-----------------\n")
   end
   load('TEST_WS.mat')
end