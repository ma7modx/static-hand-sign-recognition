function [ output_args ] = Gaussian( size , mu , sigma  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
size = size -1 ; 
ret = zeros(1,size);
i = 1 ; 
for  x = -size/2 : size/2
    ret(i) = 1/(sigma*sqrt(2*pi)) * exp(-(x-mu).^2/(2*sigma)^2) ;
    i = i + 1 ;
end
output_args = ret ; 
end

