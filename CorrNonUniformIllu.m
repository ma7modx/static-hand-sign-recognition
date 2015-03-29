function [ thresholdImg , Img ] = CorrNonUniformIllu( I , Disksize )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

background = imopen(I,strel('disk',Disksize));
 
I2 = I - background;
imshow(I2)
pause

I3 = (I2)+50;

%I3 = imclose(I3 , strel('disk',60)) ; 
%imshow(I3);
%pause 
Ii = I3 ; 

factor =floor( (size(I3,1) + size(I3,2)) / 30 )  ;
gauss = fspecial ('gaussian' , factor  , factor/5) ;
img = imfilter(I3,gauss);
I3= img ; 
imshow(img)
pause


level = graythresh(I3);
bw = im2bw(I3,level);
bw = bwareaopen(bw, 20);
imshow(bw)
pause 

thresholdImg= bw ;
Img = Ii ; 
end

