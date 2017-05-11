function [ output_args ] = plot_squared_estimation_error( x_hat, h, T_FINAL )
%PLOT_SQUARED_ESTIMATION_ERROR 

    time = 1:(T_FINAL);

    figure()
    % Predicted - true squared.
    plot(time,(x_hat(3,:) - h(3,:)).^2)
    hold on
    plot(time,(x_hat(1,:) - h(1,:)).^2)
    hold off
    legend('z3', 'z2')


end

