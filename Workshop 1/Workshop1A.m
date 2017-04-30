%% A.1
% RLS without noise

clear all
close all
clc
load('data1.mat');

Fs = 8192; %sampling freq
D1 = 1 * Fs; % delay 1
D2 = 2.5 * Fs; % delay 2
timespan = [0: 1/Fs: length(loudspeaker)/Fs - 1/Fs]; % Timespan for time-axis


% RLS with inital params = 0

init_params = [1; 0; 0];
P_init_scale = 1;

[output, theta_hat] = RLS_function(loudspeaker, mike1, init_params, P_init_scale);

figure(1)
subplot(2,1,1)
hold on
plot(timespan,theta_hat(1,:))
plot(timespan,theta_hat(2,:))
plot(timespan, theta_hat(3,:))
hold off

title('Parameter values (RLS no noise) b_2=b_3 = 0')
xlabel('Seconds')
ylabel('Parameter value')
legend('b_1', 'b_2', 'b_3')
ylim([0 1])


% RLS with inital params = 1

init_params = [1; 1; 1];
P_init_scale = 1;

[output, theta_hat] = RLS_function(loudspeaker, mike1, init_params, P_init_scale);


subplot(2,1,2)
hold on
plot(timespan,theta_hat(1,:))
plot(timespan,theta_hat(2,:))
plot(timespan, theta_hat(3,:))
hold off

title('Parameter values (RLS no noise) b_2=b_3 = 1')
xlabel('Seconds')
ylabel('Parameter value')
legend('b_1', 'b_2', 'b_3')
ylim([0 1])

saveas(gcf, 'figures/q1a_params.png')

%%
% RLS P scaling
clear all
close all
clc
load('data1.mat');

Fs = 8192; %sampling freq
D1 = 1 * Fs; % delay 1
D2 = 2.5 * Fs; % delay 2
timespan = [0: 1/Fs: length(loudspeaker)/Fs - 1/Fs]; % Timespan for time-axis


% RLS with P_init_scale = 1
init_params = [1; 0; 0];
P_init_scale = 1;

[output1, theta_hat] = RLS_function(loudspeaker, mike1, init_params, P_init_scale);

figure(2)
subplot(3,1,1)
hold on
plot(timespan,theta_hat(1,:))
plot(timespan,theta_hat(2,:))
plot(timespan, theta_hat(3,:))
hold off

title('Parameter values (RLS no noise) Init P scale = 1')
xlabel('Seconds')
ylabel('Parameter value')
legend('b_1', 'b_2', 'b_3')
ylim([0 1.01])


% RLS with P_init_scale = 0.01
init_params = [1; 0; 0];
P_init_scale = 0.01;

[output001, theta_hat] = RLS_function(loudspeaker, mike1, init_params, P_init_scale);

figure(2)
subplot(3,1,2)
hold on
plot(timespan,theta_hat(1,:))
plot(timespan,theta_hat(2,:))
plot(timespan, theta_hat(3,:))
hold off

title('Parameter values (RLS no noise) Init P scale = 0.01')
xlabel('Seconds')
ylabel('Parameter value')
legend('b_1', 'b_2', 'b_3')
ylim([0 1.01])

% RLS with P_init_scale = 100
init_params = [1; 0; 0];
P_init_scale = 100;

[output100, theta_hat] = RLS_function(loudspeaker, mike1, init_params, P_init_scale);

figure(2)
subplot(3,1,3)
hold on
plot(timespan,theta_hat(1,:))
plot(timespan,theta_hat(2,:))
plot(timespan, theta_hat(3,:))
hold off

title('Parameter values (RLS no noise) Init P scale = 100')
xlabel('Seconds')
ylabel('Parameter value')
legend('b_1', 'b_2', 'b_3')
ylim([0 1.01])

saveas(gcf, 'figures/q1a_Pinit.png')

figure(6)
subplot(3,1,1)
plot(timespan, transpose(loudspeaker) - output1)
title('Amplitude Difference (RLS without noise) Pinit = 1*I')
xlabel('Seconds')
ylabel('Amplitude')

subplot(3,1,2)
plot(timespan, transpose(loudspeaker) - output001)
title('Amplitude Difference (RLS without noise) Pinit = 0.01*I')
xlabel('Seconds')
ylabel('Amplitude')

subplot(3,1,3)
plot(timespan, transpose(loudspeaker) - output100)
title('Amplitude Difference (RLS without noise) Pinit = 100*I')
xlabel('Seconds')
ylabel('Amplitude')

saveas(gcf, 'figures/q1a_Pinit_output_diff.png')

%% A.1
% RLS with noise

clear all
close all
clc
load('data1.mat');

Fs = 8192; %sampling freq
D1 = 1 * Fs; % delay 1
D2 = 2.5 * Fs; % delay 2
timespan = [0: 1/Fs: length(loudspeaker)/Fs - 1/Fs]; % Timespan for time-axis


init_params = [0; 0; 0];
P_init_scale = 1;

[output, theta_hat] = RLS_function(loudspeaker, mike1, init_params, P_init_scale);
[noisy_output, noisy_theta_hat] = RLS_function(loudspeaker, noisymike1, init_params, P_init_scale);

% sound(noisy_output)


figure(4)
subplot(2,1,1)
hold on
plot(timespan,theta_hat(1,:))
plot(timespan,theta_hat(2,:))
plot(timespan, theta_hat(3,:))
hold off

title('Parameter values (RLS no noise)')
xlabel('Seconds')
ylabel('Parameter value')
legend('b_1', 'b_2', 'b_3')
ylim([0 1])

subplot(2,1,2)
hold on
plot(timespan,noisy_theta_hat(1,:))
plot(timespan,noisy_theta_hat(2,:))
plot(timespan, noisy_theta_hat(3,:))
hold off

title('Parameter values (RLS with noise)')
xlabel('Seconds')
ylabel('Parameter value')
legend('b_1', 'b_2', 'b_3')
ylim([0 1])

figure(5)
subplot(2,1,1)
plot(timespan, transpose(loudspeaker) - output)
title('Amplitude Difference between Loudspeaker and output signal(RLS without noise)')
xlabel('Seconds')
ylabel('Amplitude')
ylim([-0.1 0.15])
subplot(2,1,2)
plot(timespan, transpose(loudspeaker) - noisy_output)
title('Amplitude Difference between Loudspeaker and output signal(RLS with noise)')
xlabel('Seconds')
ylabel('Amplitude')
ylim([-0.1 0.15])



%% A.2 
% LMS without noise

clear all
clc
load('data1.mat');

Fs = 8192; %sampling freq
D1 = 1 * Fs; % delay 1
D2 = 2.5 * Fs; % delay 2


% LMS no noise with mu = 3
init_params = [1; 0; 0];
mu = 3;

[output, theta_hat] = LMS_function(loudspeaker, mike1, init_params, mu);

figure(2)
subplot(3,1,2)
hold on
plot(timespan,theta_hat(1,:))
plot(timespan,theta_hat(2,:))
plot(timespan, theta_hat(3,:))
hold off

title('Parameter values (LMS no noise) mu = 0.01')
xlabel('Seconds')
ylabel('Parameter value')
legend('b_1', 'b_2', 'b_3')
ylim([0 1.01])


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

noisy_output  = zeros(1,length(loudspeaker));

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
   
    noisy_output(i) = noisymike1(i) - theta_hat(2)*loudspeakerDelay1 - theta_hat(3)*loudspeakerDelay2; 
    
end

% sound(loudspeaker)
% pause
% sound(noisymike1)
% pause
% sound(noisy_output)

