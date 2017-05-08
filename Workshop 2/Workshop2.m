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
U = [0;c2;0];
V = [0;d2;d3];
H = [0 1 0];
W = w3;

tfinal = 6*60;

% Input signal for the gate
u = 0.25 * ones(1,tfinal);

% Inital conditions
h = [0.25; 0.01; 0.01];

h3 = zeros(1,tfinal);

for t = 1:1:tfinal
   
    h_next = F*h + U*u(t) + V;
    h3(t) = H*h_next + W;
    
    
    d2 = normrnd(mu, sigma_d);
    d3 = normrnd(mu, sigma_d);
    w3 = normrnd(mu, sigma_w);
    V = [0;d2;d3];
    W = w3;
    h = h_next;
end

plot(1:tfinal,h3)
hold on

sys = ss(F,U,H,W,[]);

tfinal = 6*60;
T = [1:1:tfinal];
% U = ones(size(T));


lsim(sys,u,T,[0.25; 0.01; 0.01]);
hold off

    


