function [ res ] = SmoothGraph( dist , size , sigma )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

s = Gaussian(floor(size) , 0 , sigma) ; 

%plot(s)
res = conv(dist , s);
%pause
%plot(res);
%pause

end

