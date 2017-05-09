close all

% Inital values
c1 =  0.04;
c2 = -0.04;
c3 =  0.08;
c4 = -0.08;

z1 = 3.00;
% p1 = 2.7 or 2.5
p2 = 1.50;
p3 = 1.75;

% h1 = z1-p1;
% h2 = z2-p2;
% h3 = z3-p3;

mu = 0;
sigma_d = 0.00500;
sigma_w = 0.00375;

d2 = normrnd(mu, sigma_d);
d3 = normrnd(mu, sigma_d);
w3 = normrnd(mu, sigma_w);


% Set up the state space matricies
F = [ 0 1 0; 0 c2+1 0; c3 0 1+c4];
U = [0;c1;0];
V = [0;d2;d3];
H = [0 0 1];
W = [1];

T_FINAL = 6*60;

% Input signal for the gate
input = 0.5 * ones(1,T_FINAL);

% Inital conditions
h_init = [0.3; 0.1; 0.1];


y = zeros(1,T_FINAL);
h = h_init;

for t = 1:T_FINAL
    [y(t), h] = simulate_system( F, U, H, W, h, input(t), mu, sigma_d, sigma_w );
%     kalman_predictor( F, U, H, W, h_init, input, mu, sigma_d, sigma_w, T_FINAL )    
end


figure();
plot(1:T_FINAL, y, 'r')
xlabel('Time (Minutes)')
ylabel('z_3 water level')
