function [ y , h ] = simulate_system_outflow_B( F, U, H, W, h, input, mu, sigma2_d, sigma2_w, q_out, q_out2)
% System Simulator

    %   Calculate Noise
        d2 = normrnd(mu, sigma2_d);
        d3 = normrnd(mu, sigma2_d);
%         d4 = normrnd(mu, sigma4_d);
        V = [0; d2 - q_out; d3-q_out2];
        w3 = normrnd(mu, sigma2_w);

    %   Update states  

        y = H*h + W*w3;
        h = F*h + U*input + V;

end