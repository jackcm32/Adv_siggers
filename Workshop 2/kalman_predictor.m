function [ ] = kalman_predictor( F, U, H, W, h_init, input, mu, sigma_d, sigma_w, T_FINAL )
%KALMAN_PREDICTOR Summary of this function goes here
%   Detailed explanation goes here

    h3_output = zeros(1,T_FINAL);
    
    length(h3_output)
    
    
    h = h_init;

    for t = 1:T_FINAL 

    %   Calculate Noise
        d2 = normrnd(mu, sigma_d);
        d3 = normrnd(mu, sigma_d);
        V = [0; d2; d3];
        w3 = normrnd(mu, sigma_w);

    %   Update states  
    % SUS THIS.......
        h3_output(t) = H*h + W*w3;
        h = F*h + U*input(t) + V;
    end
    
    figure();
    plot(1:T_FINAL,h3_output, 'r')
    xlabel('Time (Minutes)')
    ylabel('z_3 water level')

end