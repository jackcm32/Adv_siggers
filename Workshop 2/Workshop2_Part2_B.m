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
sigma_w = 0.00375;

q_c = 0.008; % constant flow between 
q_c_2 = 0.008;

% Set up the state space matricies
F_sym = [ 0 1 0; 0 c2+1 0; c3 0 1+c4];
% F = [ 0 1 0; 0 c2+1-q_out 0; c3 0 1+c4];
G_sym = [0;c1;0];
H_sym = [0 0 1];
W_sym = [1];

T_FINAL = 12*60;

% Input signal for the gate (Random)
% input = rand_input_gen( T_FINAL );
% input = cell2mat(struct2cell(load('input2.mat')));
input = 0.3 * ones(1,T_FINAL);

% Inital conditions
h_init_sym = [0.3; 0.1; 0.1];

y = zeros(1,T_FINAL);

h_sym = zeros(3,1,T_FINAL + 1);
h_sym(:,:,1) = h_init_sym;


for t = 1:T_FINAL    
    
    [y(t), h_sym(:,:,t+1)] = simulate_system_outflow_B( F_sym, G_sym, H_sym, W_sym, h_sym(:,:,t), input(t), mu, sigma2_d, sigma_w, q_c, q_c_2 );
    
end

% Input and how the system evolves 
plot_system( h_sym, y, T_FINAL, input, z1, p3 )


% Simulations 
% Simulations 
sigma2_d_4 = 0.000100;
sigma2_d_5_1 = 0.1000;
sigma2_d_5_2 = 0.0100;
sigma2_d_5_3= 0.000100;
q_out_4 = 0.008;  % Inital value for q_out;
q_out_5 = 0;
q_out_6 = 0.1;   

% Kalman Filter with outflow modeled
F = [ 0 1 0 0 0; 0 c2+1 0 -1 0; c3 0 1+c4 0 -1; 0 0 0 1 0; 0 0 0 0 1];
G = [0;c1;0; 0; 0];
H = [0 0 1 0 0];
W = [1];
V_1 = [0 0 0 0 0; 0 (sigma2_d) 0 0 0; 0 0 sigma2_d 0 0; 0 0 0 sigma2_d_4 0; 0 0 0 0 sigma2_d_5_1];
V_2 = [0 0 0 0 0; 0 (sigma2_d) 0 0 0; 0 0 sigma2_d 0 0; 0 0 0 sigma2_d_4 0; 0 0 0 0 sigma2_d_5_2];
V_3 = [0 0 0 0 0; 0 (sigma2_d) 0 0 0; 0 0 sigma2_d 0 0; 0 0 0 sigma2_d_4 0; 0 0 0 0 sigma2_d_5_3];

h_init_4 = [0.3; 0.1; 0.1; 0.1; q_out_4];
h_init_5 = [0.3; 0.1; 0.1; 0.1; q_out_5];
h_init_6 = [0.3; 0.1; 0.1; 0.1; q_out_6];

h = zeros(5,1,T_FINAL + 1);
h(:,:,1) = h_init_6;

x_hat_pred_1 = zeros(5,1,T_FINAL + 1);
x_hat_pred_1(:,:,1) = h_init_6;
P_pred_1 = zeros(5,5,T_FINAL + 1);
P_pred_1(:,:,1) = eye(5);
K_pred_1 = zeros(5,1, T_FINAL);

y_hat_pred_1 = zeros(1,T_FINAL);


x_hat_pred_2 = zeros(5,1,T_FINAL + 1);
x_hat_pred_2(:,:,1) = h_init_6;
P_pred_2 = zeros(5,5,T_FINAL + 1);
P_pred_2(:,:,1) = eye(5);
K_pred_2 = zeros(5,1, T_FINAL);

y_hat_pred_2 = zeros(1,T_FINAL);


x_hat_pred_3 = zeros(5,1,T_FINAL + 1);
x_hat_pred_3(:,:,1) = h_init_6;
P_pred_3 = zeros(5,5,T_FINAL + 1);
P_pred_3(:,:,1) = eye(5);
K_pred_3 = zeros(5,1, T_FINAL);

y_hat_pred_3 = zeros(1,T_FINAL);


x_hat_pred_4 = zeros(5,1,T_FINAL + 1);
x_hat_pred_4(:,:,1) = h_init_4;
P_pred_4 = zeros(5,5,T_FINAL + 1);
P_pred_4(:,:,1) = eye(5);
K_pred_4 = zeros(5,1, T_FINAL);

y_hat_pred_4 = zeros(1,T_FINAL);

x_hat_pred_5 = zeros(5,1,T_FINAL + 1);
x_hat_pred_5(:,:,1) = h_init_5;
P_pred_5 = zeros(5,5,T_FINAL + 1);
P_pred_5(:,:,1) = eye(5);
K_pred_5 = zeros(5,1, T_FINAL);

y_hat_pred_5 = zeros(1,T_FINAL);

x_hat_pred_6 = zeros(5,1,T_FINAL + 1);
x_hat_pred_6(:,:,1) = h_init_6;
P_pred_6 = zeros(5,5,T_FINAL + 1);
P_pred_6(:,:,1) = eye(5);
K_pred_6 = zeros(5,1, T_FINAL);

y_hat_pred_6 = zeros(1,T_FINAL);



for t = 1:T_FINAL
    
    [x_hat_pred_1(:,:,t+1), P_pred_1(:,:,t+1), y_hat_pred_1(:,:,t), K_pred_1(:,:,t)] = kalman_predictor(F,G,H,W,V_1,input(t),y(t),x_hat_pred_1(:,:,t),P_pred_1(:,:,t));
    [x_hat_pred_2(:,:,t+1), P_pred_2(:,:,t+1), y_hat_pred_2(:,:,t), K_pred_2(:,:,t)] = kalman_predictor(F,G,H,W,V_2,input(t),y(t),x_hat_pred_2(:,:,t),P_pred_2(:,:,t));
    [x_hat_pred_3(:,:,t+1), P_pred_3(:,:,t+1), y_hat_pred_3(:,:,t), K_pred_3(:,:,t)] = kalman_predictor(F,G,H,W,V_3,input(t),y(t),x_hat_pred_3(:,:,t),P_pred_3(:,:,t));
    
    [x_hat_pred_4(:,:,t+1), P_pred_4(:,:,t+1), y_hat_pred_4(:,:,t), K_pred_4(:,:,t)] = kalman_predictor(F,G,H,W,V_1,input(t),y(t),x_hat_pred_4(:,:,t),P_pred_4(:,:,t));
    [x_hat_pred_5(:,:,t+1), P_pred_5(:,:,t+1), y_hat_pred_5(:,:,t), K_pred_5(:,:,t)] = kalman_predictor(F,G,H,W,V_1,input(t),y(t),x_hat_pred_5(:,:,t),P_pred_5(:,:,t));
    [x_hat_pred_6(:,:,t+1), P_pred_6(:,:,t+1), y_hat_pred_6(:,:,t), K_pred_6(:,:,t)] = kalman_predictor(F,G,H,W,V_1,input(t),y(t),x_hat_pred_6(:,:,t),P_pred_6(:,:,t));
    
end

h = h(:,:,1: end-1);
h_sym = h_sym(:,:,1: end-1);
x_hat_pred_1 = x_hat_pred_1(:,:,1: end-1);
x_hat_pred_2 = x_hat_pred_2(:,:,1: end-1);
x_hat_pred_3 = x_hat_pred_3(:,:,1: end-1);
P_pred_1 = P_pred_1(:,:,1: end-1);
P_pred_2 = P_pred_2(:,:,1: end-1);
P_pred_3 = P_pred_3(:,:,1: end-1);
x_hat_pred_4 = x_hat_pred_4(:,:,1: end-1);
x_hat_pred_5 = x_hat_pred_5(:,:,1: end-1);
x_hat_pred_6 = x_hat_pred_6(:,:,1: end-1);
P_pred_4 = P_pred_4(:,:,1: end-1);
P_pred_5 = P_pred_5(:,:,1: end-1);
P_pred_6 = P_pred_6(:,:,1: end-1);


% COMPARING
% plot_estimation_error(h_sym, y, x_hat_pred, T_FINAL, p3, 'Kalman Filter With Outflow', 'K_outflow_comparison')
% plot_estimation_error(h, y, x_hat_FF, T_FINAL, p3)


plot_outflow_info_B(h_sym, P_pred_1, x_hat_pred_1, T_FINAL, p2, q_c, sigma2_d_4, sigma2_d_5_1 )
plot_outflow_info_B(h_sym, P_pred_2, x_hat_pred_2, T_FINAL, p2, q_c, sigma2_d_4, sigma2_d_5_2 )
plot_outflow_info_B(h_sym, P_pred_3, x_hat_pred_3, T_FINAL, p2, q_c, sigma2_d_4, sigma2_d_5_3 )
plot_outflow_info_B(h_sym, P_pred_4, x_hat_pred_4, T_FINAL, p2, q_c, sigma2_d_4, sigma2_d_5_1 )
plot_outflow_info_B(h_sym, P_pred_5, x_hat_pred_5, T_FINAL, p2, q_c, sigma2_d_4, sigma2_d_5_1 )
plot_outflow_info_B(h_sym, P_pred_6, x_hat_pred_6, T_FINAL, p2, q_c, sigma2_d_4, sigma2_d_5_1 )
