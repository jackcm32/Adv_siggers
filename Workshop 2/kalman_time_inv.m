function [ x_hat_next, y_hat ] = kalman_time_inv( F, G, H, W, V, input, y, x_hat, K )
%KALMAN_TIME_INVARIANT 

    
    y_hat = (H * x_hat);
    
    e = (y - y_hat);

%     Use pre-calculated K value
    
    x_hat_next = (F * x_hat) + (G * input) + (K * e);
    
end

