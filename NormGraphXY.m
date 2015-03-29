function [ outFinal , normFactor ] = NormGraphXY( dist )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
out = zeros(size(dist)) ; 

MINX = min(dist(:,1))
MAXX = max(dist(:,1))
normX = (1 / (MAXX - MINX));

normFactorX = normX * 100;%-min* normX ; 
out(:,1) = (dist(:,1) - MINX ) *normFactorX;

MINY = min(dist(:,2));
MAXY = max(dist(:,2));
normY = 1 / (MAXY-MINY);

normFactorY = normY * 100;%-min* normX ; 
out(:,2) = (dist(:,2) - MINY ) *normFactorY;

outFinal = out ; 
normFactor = [ normFactorX normFactorY ] ; 

end

