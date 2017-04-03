%% A.1
% RLS without noise

clear all
clc
load('data1.mat');

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

for i=1:length(loudspeaker)
    if (i > D1)
        loudspeakerDelay1 = loudspeaker(i - D1);
    end
       
    if (i > D2)
        loudspeakerDelay2 = loudspeaker(i - D2);
    end 
    
    phi = [loudspeaker(i); loudspeakerDelay1;  loudspeakerDelay2];
    
    P = P - (P*phi*transpose(phi)*P)/(1 + transpose(phi)*P*phi);
    
    G = P*phi;

    theta_hat = theta_hat + G*(mike1(i) - transpose(phi)*theta_hat);
    
    output(i) = mike1(i) - theta_hat(2)*loudspeakerDelay1 - theta_hat(3)*loudspeakerDelay2;
end


loudspeakerDelay1 = 0;
loudspeakerDelay2 = 0;

% for i=1:length(loudspeaker)
%     if (i > D1)
%         loudspeakerDelay1 = loudspeaker(i - D1);
%     end
%        
%     if (i > D2)
%         loudspeakerDelay2 = loudspeaker(i - D2);
%     end 
%     
%     output(i) = mike1(i) - theta_hat(2)*loudspeakerDelay1 - theta_hat(3)*loudspeakerDelay2; 
% 
% end

%% A.1
% RLS with noise

clear all
clc
load('data1.mat');

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

for i=1:length(loudspeaker)
    if (i > D1)
        loudspeakerDelay1 = loudspeaker(i - D1);
    end
       
    if (i > D2)
        loudspeakerDelay2 = loudspeaker(i - D2);
    end 
    
    phi = [loudspeaker(i); loudspeakerDelay1;  loudspeakerDelay2];
    
    P = P - (P*phi*transpose(phi)*P)/(1 + transpose(phi)*P*phi);
    
    G = P*phi;

    theta_hat = theta_hat + G*(noisymike1(i) - transpose(phi)*theta_hat);
    
end

noisy_output  = zeros(1,length(loudspeaker));
loudspeakerDelay1 = 0;
loudspeakerDelay2 = 0;

for i=1:length(loudspeaker)
    if (i > D1)
        loudspeakerDelay1 = loudspeaker(i - D1);
    end
       
    if (i > D2)
        loudspeakerDelay2 = loudspeaker(i - D2);
    end 
    
    noisy_output(i) = noisymike1(i) - theta_hat(2)*loudspeakerDelay1 - theta_hat(3)*loudspeakerDelay2; 

end

% sound(loudspeaker)
% pause
% sound(noisymike1)
% pause
% sound(noisy_output)

%% A.2 
% LMS without noise

clear all
clc
load('data1.mat');

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

% Estimating mu
upper_mu = 1/mean(mike1.^2);
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

    theta_hat = theta_hat + G*(mike1(i) - transpose(phi)*theta_hat);
    
end


output  = zeros(1,length(loudspeaker));
loudspeakerDelay1 = 0;
loudspeakerDelay2 = 0;

for i=1:length(loudspeaker)
    if (i > D1)
        loudspeakerDelay1 = loudspeaker(i - D1);
    end
       
    if (i > D2)
        loudspeakerDelay2 = loudspeaker(i - D2);
    end 
    
    output(i) = mike1(i) - theta_hat(2)*loudspeakerDelay1 - theta_hat(3)*loudspeakerDelay2; 

end

% sound(loudspeaker)
% pause
% sound(mike1)
% pause
% sound(output)

%% A.2 
% LMS with noise

clear all
clc
load('data1.mat');

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

% Estimating mu
upper_mu = 1/mean(noisymike1.^2);
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

    theta_hat = theta_hat + G*(noisymike1(i) - transpose(phi)*theta_hat);
    
end


noisy_output  = zeros(1,length(loudspeaker));
loudspeakerDelay1 = 0;
loudspeakerDelay2 = 0;

for i=1:length(loudspeaker)
    if (i > D1)
        loudspeakerDelay1 = loudspeaker(i - D1);
    end
       
    if (i > D2)
        loudspeakerDelay2 = loudspeaker(i - D2);
    end 
    
    noisy_output(i) = noisymike1(i) - theta_hat(2)*loudspeakerDelay1 - theta_hat(3)*loudspeakerDelay2; 

end

% sound(loudspeaker)
% pause
% sound(noisymike1)
% pause
% sound(noisy_output)

