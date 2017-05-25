function [] = plot_outflow_info( h, P, x_hat, T_FINAL, p2, q_c, sigma2_d_4 )
%PLOT_ESTIMATION_ERROR Plots the estimation error for 3 signals.

    value_string = strcat( ' d_4 var = ', num2str(sigma2_d_4) , ' q_{out} init mu = ', num2str(x_hat(4,1)), ' var = ', num2str(P(4,4,1)) );
    save_string = strcat( ' Part2_q_c_',num2str(q_c),'_d_4_', num2str(sigma2_d_4) , '_q_out_init_mu_', num2str(x_hat(4,1)), '_var_', num2str(P(4,4,1)) );
    save_string = strrep(save_string, '.','');
    
    figure()
    
    subplot(2,1,1)
    % True z2
    time = 1:(T_FINAL);

    plot(time, h(2,:) + p2)
    hold on
    % Estimated z2
    plot(time, x_hat(2,:) + p2)
    hold on
    p_2_vector = p2*ones(1,T_FINAL);
    plot(time, p_2_vector)
    hold off
    
    legend('z_2 True', 'z_2 Kalman Estimation', 'p_2 level', 'Location','southeast')
    title_str1 = strcat('Z_2 True value vs. Estimated value: ', value_string);
    title(title_str1)
    
    
    subplot(2,1,2)
    % Actual q_c
    q_c_vector = q_c*ones(1,T_FINAL);
    plot(time, q_c_vector)
    hold on 
    
    % Estimated q_c
    plot(time, x_hat(4,:))
    hold off

    legend('Actual q_c', 'Estimated q_c')
    
    title_str2 = strcat('q_c True value vs. Estimated value: ', value_string);
    title(title_str2)
   
    filename = strcat('figures/', save_string, '.png');
    saveas(gcf, filename)

end

