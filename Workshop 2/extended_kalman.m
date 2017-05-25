function [x_hat_next, P_N_next, y_hat, K_f ] = extended_kalman( F, G, H, W, V, input, y, x_hat, P_N)
% P(N+1) = P_N_next
% 
% P(N|N) = P_NN
% 
% P(N) = P_N

%     c1 =  0.025;
    c2 = -0.025;
    c3 =  0.05;
    c4 = -0.05;
    
    
%   K_f matrix
    K_f = P_N*transpose(H)*inv(H*P_N*transpose(H) + W);

%   Caluate the innovation 
    y_hat = (H * x_hat);
    
    e = y - y_hat;
     
    
%   current estimate 

    x_hat_NN = x_hat + K_f * e;
    
    P_NN = P_N - P_N * transpose(H) * inv(H * P_N * transpose(H) + W) * H * P_N;
    
    
%      Work HERE::::;

    F = [ 0, 1, 0;  0, 1.5 * c2 * sqrt(x_hat_NN(2)) + 1, 0; 1.5 * c3 * sqrt((x_hat_NN(1))),   0, 1.5 * c4 * sqrt((x_hat_NN(3))) + 1];
 
 
    x_hat_next = F * x_hat_NN + (G * input);
    
    P_N_next = F * P_NN * transpose(F) + V;
    
end



