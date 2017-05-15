function [] = plot_system( h, y, T_FINAL, input )

    figure()
    
    % True
    time = 1:(T_FINAL);

    subplot(2,1,1)
    plot(time, input)
    title('Input')
    ylim([0.25 0.65])
    
    % Estimated
    subplot(2,1,2)
    plot(time, y)
    title('Output (y(t))')
    
    
    


end

