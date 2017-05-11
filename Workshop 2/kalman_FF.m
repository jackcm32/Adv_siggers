function [x_hat_next, P_N_next, y_hat, K_f ] = kalman_FF( F, G, H, W, V, input, y, x_hat, P_N)
% P(N+1) = P_N_next
% 
% P(N|N) = P_NN
% 
% P(N) = P_N



%   K_f matrix
    K_f = P*transpose(H)*inv(H*P*transpose(H) + W);

%   Caluate the innovation 
    y_hat = (H * x_hat);
    
    e = y - y_hat;
     
    
%   current estimate 

    x_hat_NN = x_hat + K_f * e;

    x_hat_next = F * x_hat_NN;
    
    P_NN = P_N - P_N * transpose(H) * inv(H * P_N * transpose(H) + W) * H * P_N;
    
    P_N_next = F * P_NN * transpose(F) + V;
    
end



