function [] = plot_system( h, y, T_FINAL, input, z1, p3)

    figure()
    
    % True
    time = 1:(T_FINAL);

    subplot(2,1,1)
    plot(time, z1 - input)
    title('Input')
    ylim([2.4 2.8])
    xlabel('Minutes')
    ylabel('Input water level')
    
    % Estimated
    subplot(2,1,2)
    plot(time, y + p3)
    title('Output (y(t))')
    xlabel('Minutes')
    ylabel('Output water level')
    
    
    


end

