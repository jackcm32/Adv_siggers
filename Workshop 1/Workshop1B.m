%% B.1
% Time varying RLS without noise

clear all
clc
load('data1.mat');
load('data2.mat');

Fs = 8192; %sampling freq
D1 = 1 * Fs; % delay 1
D2 = 2.5 * Fs; % delay 2

loudspeakerDelay1 = 0;
loudspeakerDelay2 = 0;

a1 = 0;
a2 = 0;
a3 = 0;

theta_hat = [a1; a2; a3];

lambda = 0.995;

P = eye(3);

output  = zeros(1,length(loudspeaker));

for i=1:length(loudspeaker)
    if (i > D1)
        loudspeakerDelay1 = loudspeaker(i - D1);
    end
       
    if (i > D2)
        loudspeakerDelay2 = loudspeaker(i - D2);
    end 
    
    phi = [loudspeaker(i); loudspeakerDelay1;  loudspeakerDelay2];
    
    P = (1/lambda)*(P - (P*phi*transpose(phi)*P)/(lambda + transpose(phi)*P*phi));
    
    G = P*phi;

    theta_hat = theta_hat + G*(mike2(i) - transpose(phi)*theta_hat);
    
    output(i) = mike2(i) - theta_hat(2)*loudspeakerDelay1 - theta_hat(3)*loudspeakerDelay2;
    
end


%% B.1
% Time varying RLS with noise

clear all
clc
load('data1.mat');
load('data2.mat');

Fs = 8192; %sampling freq
D1 = 1 * Fs; % delay 1
D2 = 2.5 * Fs; % delay 2

loudspeakerDelay1 = 0;
loudspeakerDelay2 = 0;

a1 = 0;
a2 = 0;
a3 = 0;

theta_hat = [a1; a2; a3];

lambda = 0.995;

P = eye(3);

noisy_output  = zeros(1,length(loudspeaker));

for i=1:length(loudspeaker)
    if (i > D1)
        loudspeakerDelay1 = loudspeaker(i - D1);
    end
       
    if (i > D2)
        loudspeakerDelay2 = loudspeaker(i - D2);
    end 
    
    phi = [loudspeaker(i); loudspeakerDelay1;  loudspeakerDelay2];
    
    P = (1/lambda)*(P - (P*phi*transpose(phi)*P)/(lambda + transpose(phi)*P*phi));
    
    G = P*phi;

    theta_hat = theta_hat + G*(noisymike2(i) - transpose(phi)*theta_hat);
    
    noisy_output(i) = noisymike2(i) - theta_hat(2)*loudspeakerDelay1 - theta_hat(3)*loudspeakerDelay2; 
    
end

% sound(loudspeaker)
% pause
% sound(noisymike2)
% pause
% sound(noisy_output)

%% B.2 
% Time varying LMS without noise

clear all
clc
load('data1.mat');
load('data2.mat');

Fs = 8192; %sampling freq
D1 = 1 * Fs; % delay 1
D2 = 2.5 * Fs; % delay 2

loudspeakerDelay1 = 0;
loudspeakerDelay2 = 0;

a1 = 0;
a2 = 0;
a3 = 0;

theta_hat = [a1; a2; a3];

P = eye(3);

output  = zeros(1,length(loudspeaker));

% Estimating mu
upper_mu = 1/mean(mike2.^2);
disp(['Upper mu = ' num2str(upper_mu)])
mu = 3;


for i=1:length(loudspeaker)
    if (i > D1)
        loudspeakerDelay1 = loudspeaker(i - D1);
    end
       
    if (i > D2)
        loudspeakerDelay2 = loudspeaker(i - D2);
    end 
    
    phi = [loudspeaker(i); loudspeakerDelay1;  loudspeakerDelay2];
    
    G = mu*phi;

    theta_hat = theta_hat + G*(mike2(i) - transpose(phi)*theta_hat);
    
    output(i) = mike2(i) - theta_hat(2)*loudspeakerDelay1 - theta_hat(3)*loudspeakerDelay2; 
end


% sound(loudspeaker)
% pause
% sound(mike2)
% pause
% sound(output)

%% A.2 
% Time varying LMS with noise

clear all
clc
load('data1.mat');
load('data2.mat');

Fs = 8192; %sampling freq
D1 = 1 * Fs; % delay 1
D2 = 2.5 * Fs; % delay 2

loudspeakerDelay1 = 0;
loudspeakerDelay2 = 0;

a1 = 0;
a2 = 0;
a3 = 0;

theta_hat = [a1; a2; a3];

P = eye(3);

noisy_output  = zeros(1,length(loudspeaker));

% Estimating mu
upper_mu = 1/mean(noisymike2.^2);
disp(['Upper mu = ' num2str(upper_mu)])
mu = 3;

for i=1:length(loudspeaker)
    if (i > D1)
        loudspeakerDelay1 = loudspeaker(i - D1);
    end
       
    if (i > D2)
        loudspeakerDelay2 = loudspeaker(i - D2);
    end 
    
    phi = [loudspeaker(i); loudspeakerDelay1;  loudspeakerDelay2];
    
    G = mu*phi;

    theta_hat = theta_hat + G*(noisymike2(i) - transpose(phi)*theta_hat);
   
    noisy_output(i) = noisymike2(i) - theta_hat(2)*loudspeakerDelay1 - theta_hat(3)*loudspeakerDelay2; 
end

% 
% sound(loudspeaker)
% pause
% sound(noisymike2)
% pause
% sound(noisy_output)

