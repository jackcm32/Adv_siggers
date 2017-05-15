close all; clc; clear all;

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
sigma2_d = 0.00500;
sigma2_d_4 = 0.00500;
sigma_w = 0.00375;

% d2 = normrnd(mu, sigma_d);
% d3 = normrnd(mu, sigma_d);
% w3 = normrnd(mu, sigma_w);

q_c = 0.01;
q_out = 0.1;  % Chosen by setting input = low and checking output doesn't go below 0;

% Set up the state space matricies
F_sym = [ 0 1 0; 0 c2+1 0; c3 0 1+c4];
% F = [ 0 1 0; 0 c2+1-q_out 0; c3 0 1+c4];
G_sym = [0;c1;0];
H_sym = [0 0 1];
W_sym = [1];

% Kalman Filter
F = [ 0 1 0 0; 0 c2+1 0 -1; c3 0 1+c4 0; 0 0 0 1];
G = [0;c1;0; 0];
H = [0 0 1 0];
W = [1];
V = [0 0 0 0; 0 (sigma2_d) 0 0; 0 0 sigma2_d 0; 0 0 0 sigma2_d_4];

T_FINAL = 12*60;

% Input signal for the gate (Random)
input = rand_input_gen( T_FINAL );

% % Input signal for the gate (fully lo)
% input = 0.5 * ones(1,T_FINAL);
% 
% % Input signal for the gate (fully hi)
% input = 0.3 * ones(1,T_FINAL);

% Inital conditions
h_init_sym = [0.3; 0.1; 0.1];
h_init = [0.3; 0.1; 0.1; q_out];




y = zeros(1,T_FINAL);

h_sym = zeros(3,1,T_FINAL + 1);
h_sym(:,:,1) = h_init_sym;

h = zeros(4,1,T_FINAL + 1);
h(:,:,1) = h_init;



x_hat_pred = zeros(4,1,T_FINAL + 1);
x_hat_pred(:,:,1) = h_init;
P_pred = zeros(4,4,T_FINAL + 1);
P_pred(:,:,1) = eye(4);
K_pred = zeros(4,1, T_FINAL);

x_hat_FF = zeros(4,1,T_FINAL + 1);
x_hat_FF(:,:,1) = h_init;
P_FF = zeros(4,4,T_FINAL + 1);
P_FF(:,:,1) = eye(4);
K_FF = zeros(4,1, T_FINAL);


y_hat_pred = zeros(1,T_FINAL);
y_hat_FF = zeros(1,T_FINAL);

for t = 1:T_FINAL    
    
    [y(t), h_sym(:,:,t+1)] = simulate_system_outflow( F_sym, G_sym, H_sym, W_sym, h_sym(:,:,t), input(t), mu, sigma2_d, sigma_w, q_c );
    
    [x_hat_pred(:,:,t+1), P_pred(:,:,t+1), y_hat_pred(:,:,t), K_pred(:,:,t)] = kalman_predictor(F,G,H,W,V,input(t),y(t),x_hat_pred(:,:,t),P_pred(:,:,t));
%     [x_hat_FF(:,:,t+1), P_FF(:,:,t+1), y_hat_FF(:,:,t), K_FF(:,:,t)] = kalman_FF(F,G,H,W,V,input(t),y(t),x_hat_FF(:,:,t),P_FF(:,:,t));
    
end




h = h(:,:,1: end-1);
h_sym = h_sym(:,:,1: end-1);
x_hat_pred = x_hat_pred(:,:,1: end-1);
P_pred = P_pred(:,:,1: end-1);

x_hat_FF = x_hat_FF(:,:,1: end-1);
P_FF = P_FF(:,:,1: end-1);


% Input and how the system evolves 
plot_system( h_sym, y, T_FINAL, input, z1, p3 )




% COMPARING
plot_estimation_error(h_sym, y, x_hat_pred, T_FINAL, p3, 'Kalman Filter With Outflow')
% plot_estimation_error(h, y, x_hat_FF, T_FINAL, p3)

% Kalman Gain
plot_kalman_gain(K_pred, T_FINAL);
% plot_kalman_gain(K_FF, T_FINAL);


% Squared Estimation Error
plot_squared_estimation_error(x_hat_pred, h, T_FINAL);
% plot_squared_estimation_error(x_hat_FF, h, T_FINAL);


% Covariance of estimation error
% mean(x_hat_pred(1,:) - h(1,:))^2
% mean(x_hat_pred(2,:) - h(2,:))^2
% mean(x_hat_pred(3,:) - h(3,:))^2

