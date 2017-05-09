function [ x_hat_next, P_next, y_hat ] = kalman_predictor( F, G, H, W, V, input, y, x_hat, P )
%KALMAN_PREDICTOR 

    
    y_hat = (H * x_hat);
    
    e = (y - y_hat);

    K = (F * P * transpose(H)) * inv(H * P * transpose(H) + W);
    
    x_hat_next = (F * x_hat) + (G * input) + (K * e);

%   P_NEXT can be calculated externally, but chose to do it each step
%   here.
    P_next = (F * P * transpose(F)) + V - (F * P * transpose(H)) * inv(H * P * transpose(H) + W) * (H * P * transpose(F));

end