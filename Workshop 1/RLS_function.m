function [ output, theta_hat ] = RLS_function(loudspeaker, mike1, init_params, P_init_scale)

Fs = 8192; %sampling freq
D1 = 1 * Fs; % delay 1
D2 = 2.5 * Fs; % delay 2

P = P_init_scale * eye(3);

theta_hat = zeros(3,length(loudspeaker));
loudspeakerDelay1 = 0;
loudspeakerDelay2 = 0;

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
    
    if ( i > 1)
        theta_hat(:,i) = theta_hat(:,i-1) + G*(mike1(i) - transpose(phi)*theta_hat(:,i-1));
    else
        theta_hat(:,i) = init_params + G*(mike1(i) - transpose(phi)*init_params);
    end
    
    output(i) = mike1(i) - theta_hat(2,i)*loudspeakerDelay1 - theta_hat(3,i)*loudspeakerDelay2;
end


end

