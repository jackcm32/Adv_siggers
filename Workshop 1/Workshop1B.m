%% B.1
% ----------------------------------- %
%     RLS: Time Varying. No noise
% ----------------------------------- %

clear all
close all
clc
load('data1.mat');
load('data2.mat');

Fs = 8192; %sampling freq
D1 = 1 * Fs; % delay 1
D2 = 2.5 * Fs; % delay 2
timespan = [0: 1/Fs: length(loudspeaker)/Fs - 1/Fs]; % Timespan for time-axis


% RLS with inital params = 0

init_params = [1; 0; 0];
P_init_scale = 1;
lambda = 0.995;


[output, theta_hat] = RLS_function2(loudspeaker, mike2, init_params, P_init_scale, lambda);

figure(1)
hold on
plot(timespan,theta_hat(1,:))
plot(timespan,theta_hat(2,:))
plot(timespan, theta_hat(3,:))
hold off

title('Time varying Parameter values (RLS no noise)')
xlabel('Seconds')
ylabel('Parameter value')
legend('b_1', 'b_2', 'b_3')
ylim([0 1])

saveas(gcf, 'figures/q1b_params.png')

%%
% ----------------------------------- %
%     RLS: Time Varying.  Lambda changing
% ----------------------------------- %
clear all
close all
clc
load('data1.mat');
load('data2.mat')

Fs = 8192; %sampling freq
D1 = 1 * Fs; % delay 1
D2 = 2.5 * Fs; % delay 2
timespan = [0: 1/Fs: length(loudspeaker)/Fs - 1/Fs]; % Timespan for time-axis


% RLS with P_init_scale = 1
init_params = [1; 0; 0];
P_init_scale = 1;
lambda = 0.999;

[output1, theta_hat] = RLS_function2(loudspeaker, mike2, init_params, P_init_scale, lambda);

figure(2)
subplot(3,1,1)
hold on
plot(timespan,theta_hat(1,:))
plot(timespan,theta_hat(2,:))
plot(timespan, theta_hat(3,:))
hold off

title('Time varying Parameter values (RLS no noise) Lambda = 0.999')
xlabel('Seconds')
ylabel('Parameter value') 
legend('b_1', 'b_2', 'b_3')
ylim([0 1.01])


% RLS with lambda = 0.990;
lambda = 0.990;

[output001, theta_hat] = RLS_function2(loudspeaker, mike2, init_params, P_init_scale, lambda);

figure(2)
subplot(3,1,2)
hold on
plot(timespan,theta_hat(1,:))
plot(timespan,theta_hat(2,:))
plot(timespan, theta_hat(3,:))
hold off

title('Time varying Parameter values (RLS no noise) lambda = 0.990;')
xlabel('Seconds')
ylabel('Parameter value')
legend('b_1', 'b_2', 'b_3')
ylim([0 1.01])

% RLS with lambda = 0.999;
init_params = [1; 0; 0];
P_init_scale = 100;
lambda = 0.995;

[output100, theta_hat] = RLS_function2(loudspeaker, mike2, init_params, P_init_scale, lambda);

figure(2)
subplot(3,1,3)
hold on
plot(timespan,theta_hat(1,:))
plot(timespan,theta_hat(2,:))
plot(timespan, theta_hat(3,:))
hold off

title('Time varying Parameter values (RLS no noise) lambda = 0.995')
xlabel('Seconds')
ylabel('Parameter value')
legend('b_1', 'b_2', 'b_3')
ylim([0 1.01])

saveas(gcf, 'figures/q1b_Pinit.png')

figure(6)
subplot(3,1,1)
plot(timespan, transpose(loudspeaker) - output1)
title('Amplitude Difference for Time Varying Echo Amplitude (RLS without noise) lambda = 0.999;')
xlabel('Seconds')
ylabel('Amplitude')

subplot(3,1,2)
plot(timespan, transpose(loudspeaker) - output001)
title('Amplitude Difference for Time Varying Echo Amplitudes(RLS without noise) lambda = 0.990;')
xlabel('Seconds')
ylabel('Amplitude')

subplot(3,1,3)
plot(timespan, transpose(loudspeaker) - output100)
title('Amplitude Difference for Time Varying Echo Amplitudes (RLS without noise) lambda = 0.995;')
xlabel('Seconds')
ylabel('Amplitude')

saveas(gcf, 'figures/q1b_Pinit_output_diff.png')

%% B.1
% ----------------------------------- %
%     RLS: Time Varying with noise
% ----------------------------------- %

clear all
close all
clc
load('data1.mat');
load('data2.mat')

Fs = 8192; %sampling freq
D1 = 1 * Fs; % delay 1
D2 = 2.5 * Fs; % delay 2
timespan = [0: 1/Fs: length(loudspeaker)/Fs - 1/Fs]; % Timespan for time-axis


init_params = [1; 0; 0];
P_init_scale = 1;
lambda = 0.995;

[output, theta_hat] = RLS_function2(loudspeaker, mike2, init_params, P_init_scale, lambda);
[noisy_output, noisy_theta_hat] = RLS_function2(loudspeaker, noisymike2, init_params, P_init_scale, lambda);

% sound(noisy_output)


figure(4)
subplot(2,1,1)
hold on
plot(timespan,theta_hat(1,:))
plot(timespan,theta_hat(2,:))
plot(timespan, theta_hat(3,:))
hold off

title('Time Varying Parameter values (RLS no noise)')
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

title('Time varying Parameter values (RLS with noise)')
xlabel('Seconds')
ylabel('Parameter value')
legend('b_1', 'b_2', 'b_3')
ylim([0 1])

figure(5)
subplot(2,1,1)
plot(timespan, transpose(loudspeaker) - output)
title('Amplitude Difference between Loudspeaker and output signal for Time Varying Echo Amplitudes(RLS without noise)')
xlabel('Seconds')
ylabel('Amplitude')
ylim([-0.1 0.15])
subplot(2,1,2)
plot(timespan, transpose(loudspeaker) - noisy_output)
title('Amplitude Difference between Loudspeaker and output signalfor Time Varying Echo Amplitudes(RLS with noise)')
xlabel('Seconds')
ylabel('Amplitude')
ylim([-0.1 0.15])


%%
% ----------------------------------- %
%     LMS: Time Varying
% ----------------------------------- %

% Changing mu

clear all
close all
clc
load('data1.mat');
load('data2.mat');

Fs = 8192; %sampling freq
D1 = 1 * Fs; % delay 1
D2 = 2.5 * Fs; % delay 2
timespan = [0: 1/Fs: length(loudspeaker)/Fs - 1/Fs]; % Timespan for time-axis

init_params = [1; 0; 0];

% LMS no noise with mu = 3 b2=b3 = 0
mu = 0.3;
[output, theta_hat] = LMS_function(loudspeaker, mike2, init_params, mu);

% LMS no noise with mu = 0.03 b2=b3 = 0
mu = 0.03;
[output2, theta_hat2] = LMS_function(loudspeaker, mike2, init_params, mu);

% LMS no noise with mu = 3 b2=b3 = 0
mu = 3;
[output3, theta_hat3] = LMS_function(loudspeaker, mike2, init_params, mu);

figure(2)
subplot(3,1,1)
hold on
plot(timespan,theta_hat(1,:))
plot(timespan,theta_hat(2,:))
plot(timespan, theta_hat(3,:))
hold off

title('Time Varying Parameter values (LMS no noise) \mu = 0.3')
xlabel('Seconds')
ylabel('Parameter value')
legend('b_1', 'b_2', 'b_3')
ylim([0 1.01])

subplot(3,1,2)
hold on
plot(timespan,theta_hat2(1,:))
plot(timespan,theta_hat2(2,:))
plot(timespan, theta_hat2(3,:))
hold off

title('Time Varying Parameter values (LMS no noise) \mu = 0.03')
xlabel('Seconds')
ylabel('Parameter value')
legend('b_1', 'b_2', 'b_3')
ylim([0 1.01])

subplot(3,1,3)
hold on
plot(timespan,theta_hat3(1,:))
plot(timespan,theta_hat3(2,:))
plot(timespan, theta_hat3(3,:))
hold off

title('Time Varying Parameter values (LMS no noise) \mu = 3')
xlabel('Seconds')
ylabel('Parameter value')
legend('b_1', 'b_2', 'b_3')
ylim([0 1.01])

saveas(gcf,'figures/q1b_lms_mu.png')

%%
% ----------------------------------- %
%     LMS: Time Varying and Noise
% ----------------------------------- %

clear all
close all
clc
load('data1.mat');
load('data2.mat');

Fs = 8192; %sampling freq
D1 = 1 * Fs; % delay 1
D2 = 2.5 * Fs; % delay 2
timespan = [0: 1/Fs: length(loudspeaker)/Fs - 1/Fs]; % Timespan for time-axis

init_params = [1; 0; 0];
mu = 0.3;

[output, theta_hat] = LMS_function(loudspeaker, mike2, init_params, mu);
[noisy_output, noisy_theta_hat] = LMS_function(loudspeaker, noisymike2, init_params, mu);

figure(4)
subplot(2,1,1)
hold on
plot(timespan,theta_hat(1,:))
plot(timespan,theta_hat(2,:))
plot(timespan, theta_hat(3,:))
hold off

title('Time Varying Parameter values (LMS no noise)')
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

title('Time Varying Parameter values (LMS with noise)')
xlabel('Seconds')
ylabel('Parameter value')
legend('b_1', 'b_2', 'b_3')
ylim([0 1])

saveas(gcf, 'figures/q1b_lms_noise_params.png')

figure(5)
subplot(2,1,1)
plot(timespan, transpose(loudspeaker) - output)
title('Time Varying Params: Amplitude Difference between Loudspeaker and output signal(LMS without noise)')
xlabel('Seconds')
ylabel('Amplitude')
ylim([-0.1 0.15])
subplot(2,1,2)
plot(timespan, transpose(loudspeaker) - noisy_output)
title('Time Varying Params: Amplitude Difference between Loudspeaker and output signal(LMS with noise)')
xlabel('Seconds')
ylabel('Amplitude')
ylim([-0.1 0.15])

saveas(gcf, 'figures/q1b_lms_noise_diff.png')