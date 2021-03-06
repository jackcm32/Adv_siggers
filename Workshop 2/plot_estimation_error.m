function [] = plot_estimation_error( h, y, x_hat, T_FINAL, p3, title_str, filename )
%PLOT_ESTIMATION_ERROR Plots the estimation error for 3 signals.

    figure()
%     figure(10)
%     subplot(3,1,n)
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

    legend('True z_3', 'Measured y', 'Estimated z_3')
    title_str = strcat('Estimation Error: ', title_str);
    title(title_str)
    
    filename = strcat('figures/', filename, '.png');
    saveas(gcf, filename)

end

