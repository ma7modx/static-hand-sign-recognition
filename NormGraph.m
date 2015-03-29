function [ outFinal , normFactor ] = NormGraph( dist )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
out = zeros(size(dist)) ; 

MIN = min(dist);
MAX = max(dist);
norm = 1 / (MAX-MIN);

normFactor = norm * 100;%-min* normX ; 
out = (dist - MIN ) *normFactor;

outFinal = zeros(1 , 100) ; 
skiprate = length(out) / 100 ; 

for i = 1 : 100
    if(i*skiprate >=1)
    outFinal(i) = out(int32(floor(i*skiprate))) ; 
    else
        outFinal(i) = out(1) ; 
    end
    
end
end

