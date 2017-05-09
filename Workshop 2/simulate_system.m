function [ y , h ] = simulate_system( F, U, H, W, h, input, mu, sigma_d, sigma_w )
% System Simulator

    %   Calculate Noise
        d2 = normrnd(mu, sigma_d);
        d3 = normrnd(mu, sigma_d);
        V = [0; d2; d3];
        w3 = normrnd(mu, sigma_w);

    %   Update states  
        y = H*h + W*w3;
        h = F*h + U*input + V;

end