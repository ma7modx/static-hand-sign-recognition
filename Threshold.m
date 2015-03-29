function [ output ] = Threshold( input , t )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
output = zeros(size(input)) ;
for i= 1 : size(input , 1)
    for j = 1 : size(input,2)
        if(input(i ,j) > t)
            output(i,j) = 1 ;
        end
    end
end

end

