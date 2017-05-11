function [] = plot_estimation_error( h, y, x_hat, T_FINAL, p3 )
%PLOT_ESTIMATION_ERROR Plots the estimation error for 3 signals.

    figure()
    
    % True
    time = 1:(T_FINAL);

    plot(time, h(3,:) + p3)
    hold on
    % Measured
    plot(time, y + p3)
    hold on
    % Estimated
    plot(time, x_hat(3,:) + p3)
    hold off

    legend('True', 'Measured', 'Estimated')


end

