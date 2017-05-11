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
G = [0;c1;0];
V = [0 0 0; 0 sigma_d 0; 0 0 sigma_d];
H = [0 0 1];
W = [1];

T_FINAL = 6*60;

% Input signal for the gate
input = 0.5 * ones(1,T_FINAL);

% Inital conditions
h_init = [0.3; 0.1; 0.1];


y = zeros(1,T_FINAL);
h = h_init;

x_hat_pred = h_init;
P_pred = eye(3);

x_hat_FF = h_init;
P_FF = eye(3);

% 
% x_hat_pred(1) = 


y_hat_pred = zeros(1,T_FINAL);
y_hat_FF = zeros(1,T_FINAL);

for t = 1:T_FINAL
    [y(t), h] = simulate_system( F, U, H, W, h, input(t), mu, sigma_d, sigma_w );
    
    [x_hat_pred, P_pred, y_hat_pred(t)] = kalman_predictor(F,G,H,W,V,input(t),y(t),x_hat_pred,P_pred);
    [x_hat_FF, P_FF, y_hat_FF(t)] = kalman_predictor(F,G,H,W,V,input(t),y(t),x_hat_FF,P_FF);
    
end


figure();
plot(1:T_FINAL, y, 'r')
hold on;
plot(1:T_FINAL, y_hat_pred)
plot(1:T_FINAL, y_hat_FF, 'g')
xlabel('Time (Minutes)')
ylabel('z_3 water level')

figure()
plot(1:T_FINAL, y_hat_pred - y_hat_FF)
