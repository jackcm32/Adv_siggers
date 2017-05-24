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

% Input signal for the gate (Random)
% input = rand_input_gen( T_FINAL );
input = cell2mat(struct2cell(load('input.mat')));

% % Input signal for the gate (fully lo)
% input = 0.5 * ones(1,T_FINAL);
% 
% % Input signal for the gate (fully hi)
% input = 0.3 * ones(1,T_FINAL);

% Inital conditions
h_init = [0.3; 0.1; 0.1];


y = zeros(1,T_FINAL);

h = zeros(3,1,T_FINAL + 1);
h(:,:,1) = h_init;

% Predictor model init's
x_hat_pred = zeros(3,1,T_FINAL + 1);
x_hat_pred(:,:,1) = h_init;
P_pred = zeros(3,3,T_FINAL + 1);
P_pred(:,:,1) = eye(3);
K_pred = zeros(3,1, T_FINAL);

% Filter form model init's
x_hat_FF = zeros(3,1,T_FINAL + 1);
x_hat_FF(:,:,1) = h_init;
P_FF = zeros(3,3,T_FINAL + 1);
P_FF(:,:,1) = eye(3);
K_FF = zeros(3,1, T_FINAL);

% Time inv model init's
x_hat_inv = zeros(3,1,T_FINAL + 1);
x_hat_inv(:,:,1) = h_init;
P_bar = dare(transpose(F),transpose(H),V,W);
K_bar = (F * P_bar * transpose(H)) * inv(H * P_bar * transpose(H) + W);

y_hat_pred = zeros(1,T_FINAL);
y_hat_FF = zeros(1,T_FINAL);
y_hat_inv = zeros(1,T_FINAL);

for t = 1:T_FINAL
    [y(t), h(:,:,t+1)] = simulate_system( F, G, H, W, h(:,:,t), input(t), mu, sigma_d, sigma_w );
    
    [x_hat_pred(:,:,t+1), P_pred(:,:,t+1), y_hat_pred(:,:,t), K_pred(:,:,t)] = kalman_predictor(F,G,H,W,V,input(t),y(t),x_hat_pred(:,:,t),P_pred(:,:,t));
    [x_hat_FF(:,:,t+1), P_FF(:,:,t+1), y_hat_FF(:,:,t), K_FF(:,:,t)] = kalman_FF(F,G,H,W,V,input(t),y(t),x_hat_FF(:,:,t),P_FF(:,:,t));
    [x_hat_inv(:,:,t+1), y_hat_inv(:,:,t)] = kalman_time_inv( F, G, H, W, V, input(t), y(t), x_hat_inv(:,:,t), K_bar );
end

h = h(:,:,1: end-1);
x_hat_pred = x_hat_pred(:,:,1: end-1);
P_pred = P_pred(:,:,1: end-1);

x_hat_FF = x_hat_FF(:,:,1: end-1);
P_FF = P_FF(:,:,1: end-1);

x_hat_inv = x_hat_inv(:,:,1: end-1);

% Input and how the system evolves 
plot_system( h, y, T_FINAL, input, z1, p3 )

% COMPARING
plot_estimation_error(h, y, x_hat_pred, T_FINAL, p3, 'Predictor Form')
plot_estimation_error(h, y, x_hat_FF, T_FINAL, p3, 'Filter Form')
plot_estimation_error(h, y, x_hat_inv, T_FINAL, p3, 'Time-Invariant Form')

% Kalman Gain
plot_kalman_gain(K_pred, T_FINAL);
plot_kalman_gain(K_FF, T_FINAL);


% Squared Estimation Error
plot_squared_estimation_error(x_hat_pred, h, T_FINAL);
plot_squared_estimation_error(x_hat_FF, h, T_FINAL);
plot_squared_estimation_error(x_hat_inv, h, T_FINAL);


% Covariance of estimation error
% mean(x_hat_pred(1,:) - h(1,:))^2
% mean(x_hat_pred(2,:) - h(2,:))^2
% mean(x_hat_pred(3,:) - h(3,:))^2

