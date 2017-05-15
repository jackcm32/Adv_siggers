function [ input ] = rand_input_gen( T_FINAL )
%RAND_INPUT_GEN Summary of this function goes here
%   Detailed explanation goes here
    input  = [0.5];
    input1 = 0.5 * ones(1,T_FINAL);
    input2 = 0.3 * ones(1,T_FINAL);

    cuts = sort(randi([1 T_FINAL],1, 60));

    i = 2;

    while (length(input)<T_FINAL)
    
        if (mod(i,2) == 0)
            input = horzcat(input, input1(cuts(i-1):cuts(i)) );
        else 
            input = horzcat(input, input2(cuts(i-1):cuts(i)) );
        end
        i = i+1;
    end

    input = input(1:T_FINAL);
end

