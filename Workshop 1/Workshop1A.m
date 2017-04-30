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


init_params = [1; 0; 0];
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

saveas(gcf, 'figures/q1a_noise_params.png')

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

saveas(gcf, 'figures/q1a_noise_diff.png')



%% A.2 
% LMS without noise

clear all
clc
close all
load('data1.mat');

Fs = 8192; %sampling freq
D1 = 1 * Fs; % delay 1
D2 = 2.5 * Fs; % delay 2
timespan = [0: 1/Fs: length(loudspeaker)/Fs - 1/Fs]; % Timespan for time-axis

% LMS no noise with mu = 3 b2=b3 = 0
init_params = [1; 0; 0];
mu = 0.3;
[output, theta_hat] = LMS_function(loudspeaker, mike1, init_params, mu);

% LMS no noise with mu = 3 b2=b3 = 1
init_params = [1; 1; 1];
[output2, theta_hat2] = LMS_function(loudspeaker, mike1, init_params, mu);


figure(2)
subplot(2,1,1)
hold on
plot(timespan,theta_hat(1,:))
plot(timespan,theta_hat(2,:))
plot(timespan, theta_hat(3,:))
hold off

title('Parameter values (LMS no noise) mu = 0.3; b_2 = b_3 = 1')
xlabel('Seconds')
ylabel('Parameter value')
legend('b_1', 'b_2', 'b_3')
ylim([0 1.01])

subplot(2,1,2)
hold on
plot(timespan,theta_hat2(1,:))
plot(timespan,theta_hat2(2,:))
plot(timespan, theta_hat2(3,:))
hold off

title('Parameter values (LMS no noise) mu = 0.3; b_2 = b_3 = 1')
xlabel('Seconds')
ylabel('Parameter value')
legend('b_1', 'b_2', 'b_3')
ylim([0 1.01])

saveas(gcf,'figures/q1a_lms_params.png')


%%
% LMS mu graphs


clear all
clc
close all
load('data1.mat');

Fs = 8192; %sampling freq
D1 = 1 * Fs; % delay 1
D2 = 2.5 * Fs; % delay 2
timespan = [0: 1/Fs: length(loudspeaker)/Fs - 1/Fs]; % Timespan for time-axis

% LMS no noise with mu = 3 b2=b3 = 0
init_params = [1; 0; 0];
mu = 0.3;
[output, theta_hat] = LMS_function(loudspeaker, mike1, init_params, mu);

% LMS no noise with mu = 0.03 b2=b3 = 0
mu = 0.03;
[output2, theta_hat2] = LMS_function(loudspeaker, mike1, init_params, mu);

% LMS no noise with mu = 3 b2=b3 = 0
mu = 3;
[output3, theta_hat3] = LMS_function(loudspeaker, mike1, init_params, mu);


figure(2)
subplot(3,1,1)
hold on
plot(timespan,theta_hat(1,:))
plot(timespan,theta_hat(2,:))
plot(timespan, theta_hat(3,:))
hold off

title('Parameter values (LMS no noise) mu = 0.3')
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

title('Parameter values (LMS no noise) mu = 0.03')
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

title('Parameter values (LMS no noise) mu = 3')
xlabel('Seconds')
ylabel('Parameter value')
legend('b_1', 'b_2', 'b_3')
ylim([0 1.01])

saveas(gcf,'figures/q1a_lms_mu.png')


%% A.2 
% LMS with noise

clear all
close all
clc
load('data1.mat');

Fs = 8192; %sampling freq
D1 = 1 * Fs; % delay 1
D2 = 2.5 * Fs; % delay 2
timespan = [0: 1/Fs: length(loudspeaker)/Fs - 1/Fs]; % Timespan for time-axis

init_params = [1; 0; 0];
mu = 0.3;

[output, theta_hat] = LMS_function(loudspeaker, mike1, init_params, mu);
[noisy_output, noisy_theta_hat] = LMS_function(loudspeaker, noisymike1, init_params, mu);

figure(4)
subplot(2,1,1)
hold on
plot(timespan,theta_hat(1,:))
plot(timespan,theta_hat(2,:))
plot(timespan, theta_hat(3,:))
hold off

title('Parameter values (LMS no noise)')
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

title('Parameter values (LMS with noise)')
xlabel('Seconds')
ylabel('Parameter value')
legend('b_1', 'b_2', 'b_3')
ylim([0 1])

saveas(gcf, 'figures/q1a_lms_noise_params.png')

figure(5)
subplot(2,1,1)
plot(timespan, transpose(loudspeaker) - output)
title('Amplitude Difference between Loudspeaker and output signal(LMS without noise)')
xlabel('Seconds')
ylabel('Amplitude')
ylim([-0.1 0.15])
subplot(2,1,2)
plot(timespan, transpose(loudspeaker) - noisy_output)
title('Amplitude Difference between Loudspeaker and output signal(LMS with noise)')
xlabel('Seconds')
ylabel('Amplitude')
ylim([-0.1 0.15])

saveas(gcf, 'figures/q1a_lms_noise_diff.png')
