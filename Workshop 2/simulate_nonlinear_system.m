function [ y , h ] = simulate_nonlinear_system( F, U, H, W, h, input, mu, sigma2_d, sigma2_w )
% System Simulator
    c1 =  0.025;
    c2 = -0.025;
    c3 =  0.05;
    c4 = -0.05;



    %   Calculate Noise
        d2 = normrnd(mu, sigma2_d);
        d3 = normrnd(mu, sigma2_d);
        V = [0; d2; d3];
        w3 = normrnd(mu, sigma2_w);

    %   Update states  
        y = H*h + W*w3;
        
%       Initialise F*h
        Fh = [0;0;0]; 
        Fh(1) = h(2);
        Fh(2) = c2 * (h(2)^1.5) + h(2);
        Fh(3) = c3 * (h(1)^1.5) + c4 * (h(3)^1.5) + h(3);
        
        h = Fh + U*input + V;

end