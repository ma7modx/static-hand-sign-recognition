function [ out ] = Retnix( in , sigma )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n = floor(3.7 * sigma - 0.5) ; 
size = 2*n + 1 ; 
gaussMask = fspecial('gaussian', size , sigma) ; 
gaussImage = imfilter(in , gaussMask) ; 
out = log(double(in./gaussImage)) ; 
minv = min(min(out))  
maxv = max(max(out)) 
end

