function Plot_Profile(TD60_Power_list,maxPower)

for itramo = 1:6
    subplot(2,3,itramo)
    
    power_period = TD60_Power_list.power((TD60_Power_list.tramo_power == itramo));
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

