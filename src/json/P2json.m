function results = P2json(name_file_csv,current_power_terms,price_power_periods,out)
%%
    load_curve_ = readtable(name_file_csv);

    %%
    %%
    Power_1 = load_curve_.Power;
    DateTime_1 = years(1)+load_curve_.DateTime;
    %
    iLC_1 = LoadCurve(DateTime_1,Power_1);

    %%
    np = 2;
    %%
    %
    iET_2 = ElectricityTariff(iLC_1.DateTime,np);
    iET_2 = genHistoricalEnergyPrice(iET_2);
    %%
    iET_2.PowerTerms  = current_power_terms;      %
    iET_2.PowerPrices = price_power_periods ;     % 

    %% 
    current_bill = MonthlyBill(iLC_1,iET_2);
    current_bill = compute(current_bill);

    %%
    optPowerTerms = ComputeOptimalPowerTerms(current_bill);
    new_bill = current_bill;
    new_bill.ElectricityTariff.PowerTerms = optPowerTerms;
    %
    new_bill = compute(new_bill);

    %%
    results.current = current_bill;
    results.optimun = new_bill;
    %%
    results = jsondecode(jsonencode(results));
    %%

    results.Energy_part_cost___euros = results.current.Energy;
    results.FixedPower_cost__euros = results.current.FixedPower;
    results.DateTime = results.current.DateTime;

    for ist = {'current','optimun'}

        results.(ist{:}) = rmfield(results.(ist{:}),'LoadCurve');

        results.(ist{:}).PowerTerms =  results.(ist{:}).ElectricityTariff.PowerTerms;
        results.(ist{:}) = rmfield(results.(ist{:}),'ElectricityTariff');
        results.(ist{:}) = rmfield(results.(ist{:}),'Energy');
        results.(ist{:}) = rmfield(results.(ist{:}),'DateTime');
        results.(ist{:}) = rmfield(results.(ist{:}),'FixedPower');

        results.(ist{:}) = renamefield(results.(ist{:}),'Total','Total_cost___euros');
        results.(ist{:}) = renamefield(results.(ist{:}),'TotalPower','Power_part_cost___euros');
        results.(ist{:}) = renamefield(results.(ist{:}),'PowerTerms','PowerTerms_price___MW_euros_hours');
        results.(ist{:}) = renamefield(results.(ist{:}),'PowerPenalization','PowerPenalization_cost___euros');


    end
    
    fid = fopen(out,'w');
    fprintf(fid,'%s',jsonencode(results,'PrettyPrint',true));
    fclose(fid);

end