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
A = [0 0 0 0; 0 0 1 0; c1 0 c2+1 0; 0 c3 0 1+c4];
B = [0;0;d2;d3];
C = [0 0 1 0];
D = w3;
Ts = [];

sys = ss(A,B,C,D,Ts);

tfinal = 6*60;
T = [0:1:tfinal];
U = ones(size(T));

lsim(sys,U,T, Inital)

    


