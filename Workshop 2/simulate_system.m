function [ ] = simulate_system( F, U, H, W, initial, input, T_FINAL )
%SIMULATE_SYSTEM Summary of this function goes here
%   Detailed explanation goes here

    sys = ss(F,U,H,W,[]);

    T = [1:T_FINAL];

    figure()
    lsim(sys,input,T,initial);

end
