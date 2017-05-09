function [x_hat_next, P_next, y_hat] = kalman_FF( F, U, H, W, h, input, y)


%   K_f matrix
    K_f = P*transpose(H)*inv(H*P*transpose(H) + W);

%   Caluate the innovation 
    e = y - H*x_hat_prev;
%   current estimate 
    x_hat = x_hat_prev + K_f * e;
    
    
%   Next estimate



end

