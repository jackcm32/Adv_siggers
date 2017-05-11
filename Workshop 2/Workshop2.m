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

% Input signal for the gate
input = 0.5 * ones(1,T_FINAL);

% Inital conditions
h_init = [0.3; 0.1; 0.1];


y = zeros(1,T_FINAL);

h = zeros(3,1,T_FINAL + 1);
h(:,:,1) = h_init;

x_hat_pred = zeros(3,1,T_FINAL + 1);
x_hat_pred(:,:,1) = h_init;
P_pred = zeros(3,3,T_FINAL + 1);
P_pred(:,:,1) = eye(3);
K_pred = zeros(3,1, T_FINAL);

x_hat_FF = zeros(3,1,T_FINAL + 1);
x_hat_FF(:,:,1) = h_init;
P_FF = zeros(3,3,T_FINAL + 1);
P_FF(:,:,1) = eye(3);
K_FF = zeros(3,1, T_FINAL);


y_hat_pred = zeros(1,T_FINAL);
y_hat_FF = zeros(1,T_FINAL);

for t = 1:T_FINAL
    [y(t), h(:,:,t+1)] = simulate_system( F, G, H, W, h(:,:,t), input(t), mu, sigma_d, sigma_w );
    
    [x_hat_pred(:,:,t+1), P_pred(:,:,t+1), y_hat_pred(:,:,t), K_pred(:,:,t)] = kalman_predictor(F,G,H,W,V,input(t),y(t),x_hat_pred(:,:,t),P_pred(:,:,t));
    [x_hat_FF(:,:,t+1), P_FF(:,:,t+1), y_hat_FF(:,:,t+1), K_FF(:,:,t+1)] = kalman_predictor(F,G,H,W,V,input(t),y(t),x_hat_FF(:,:,t+1),P_FF(:,:,t+1));
    
end

h = h(:,:,1: end-1);
x_hat_pred = x_hat_pred(:,:,1: end-1);
P_pred = P_pred(:,:,1: end-1);


% COMPARING
figure()
% True
time = 1:(T_FINAL);

plot(time, h(3,:) + p3)
hold on
% Measured
plot(time, y + p3)
hold on
% Estimated
plot(time, x_hat_pred(3,:) + p3)
hold off

legend('True', 'Measured', 'Estimated')


% Kalman Gain
figure()
plot(time, K_pred(1,:))
hold on
plot(time, K_pred(2,:))
hold on
plot(time, K_pred(3,:))
hold off

legend('h_2[t]', 'h_2[t+1]', 'h_3[t+1]')


% Squared Estimation Error
figure()
% Predicted - true squared.
plot(time,(x_hat_pred(3,:) - h(3,:)).^2)
hold on
plot(time,(x_hat_pred(1,:) - h(1,:)).^2)
hold off
legend('z3', 'z2')


% Covariance of estimation error
mean(x_hat_pred(1,:) - h(1,:))^2
mean(x_hat_pred(2,:) - h(2,:))^2
mean(x_hat_pred(3,:) - h(3,:))^2



% figure();
% plot(1:T_FINAL, y, 'r')
% hold on;
% plot(1:T_FINAL, y_hat_pred)
% plot(1:T_FINAL, y_hat_FF, 'g')
% xlabel('Time (Minutes)')
% ylabel('z_3 water level')
% 
% figure()
% plot(1:T_FINAL, y_hat_pred - y_hat_FF)
