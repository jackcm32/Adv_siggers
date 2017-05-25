function [ output_args ] = plot_squared_estimation_error( x_hat, h, T_FINAL, title_str, filename )
%PLOT_SQUARED_ESTIMATION_ERROR 

    time = 1:(T_FINAL);

    figure()
%     figure(11)
%     subplot(3,1,n)
    
    % Predicted - true squared.
    plot(time,(x_hat(3,:) - h(3,:)).^2)
    hold on
    plot(time,(x_hat(1,:) - h(1,:)).^2)
    hold off
    legend('z3', 'z2')
    
    title_str = strcat('Squared Estimation Error: ', title_str);
    title(title_str)
    
    ylim([0 0.003])
    
%     filename = strcat('figures/', filename, '.png');
%     saveas(gcf, filename)

end

