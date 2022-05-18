function Plot_Profile_P2(TD20_Power_list,maxPower)

for itramo = 1:2
    subplot(2,1,itramo)
    
    power_period = TD20_Power_list.power((TD20_Power_list.tramo_power == itramo));
    histogram(power_period,'NumBins',30)
    %ylim([0 0.25])
    title("$P_"+num2str(itramo) + " \ |\  \omega^* = "+maxPower(itramo)+" kW$",'Interpreter','latex','FontSize',14)
    grid on
    xlabel('Power(kW)')
    xlim([0 150])
    ip = xline(maxPower(itramo),'LineWidth',2);
    legend(ip,"$\omega^*_"+itramo+"$",'Interpreter','latex','FontSize',14)
end
end

