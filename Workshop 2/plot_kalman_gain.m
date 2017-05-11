function [] = plot_kalman_gain( K, T_FINAL )
%PLOT_KALMAN_GAIN 
    
    time = 1:(T_FINAL);
    
    figure()
    plot(time, K(1,:))
    hold on
    plot(time, K(2,:))
    hold on
    plot(time, K(3,:))
    hold off

    legend('h_2[t]', 'h_2[t+1]', 'h_3[t+1]')
    title('Kalman Gain')


end

