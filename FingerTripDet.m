function [ outputcorn outputimg ] = FingerTripDet( hand , thickness , GaussSize , GaussSigma)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
ee = edge(hand);
ball = strel ('square' , thickness);
eex = imdilate(ee , ball);
imshow(eex)
pause 
mask = fspecial('gaussian',GaussSize , GaussSigma);
me = imfilter(double(eex) , mask);
c = corner(me , 10);
imshow(me);
hold on
plot(c(:,1), c(:,2), 'r*');
outputcorn = c ;
outputimg = me ;
end

