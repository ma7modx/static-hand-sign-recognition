function [ output_args , ominX , ominY , omaxX , omaxY ] = skinDet( im )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

img = im ; 
in = zeros(size(im));
inthresh = zeros(size(im));
minX = 10000000 ; 
maxX = -10000000 ; 
minY = 10000000 ; 
maxY = -10000000 ; 

width = size(im , 1) ; % width = height and vice versa 
height = size(im , 2) ; 

im = reshape(permute(im, [3 2 1]) ,3 , width*height  , []);
imYUV = ([0.257 0.504 0.098 ; -0.148 -0.291 0.439 ; 0.439 -0.368 -0.071 ] * double(im)) + repmat([0 ; 128 ; 128] , 1 , width*height) ;

sss = uint8(permute(reshape(transpose(imYUV) ,height , width , 3) , [2 , 1 , 3] )); % Allah L mosta3an
%size(sss)
sss(:,:,1) = 0 ; 
%imshow( sss) ; 
%pause

%another colorspace
sss2 = rgb2hsv(img);
cond2 =  sss2(:,:,1) >= 0 & sss2(:,:,1) <= 50 &  sss2(:,:,2) >= 0.23 & sss2(:,:,1) <= 0.68 ;
inthresh2 = uint8(cond2*255) ; 

%another
YCBCR = rgb2ycbcr(img);
    Cb1=85;
    Cb2=135;
    Cr1=135;
    Cr2=180;
   
 range=(Cb1<YCBCR(:,:,2) & YCBCR(:,:,2)<Cb2);
 range2=(Cr1<YCBCR(:,:,3) & YCBCR(:,:,3)<Cr2);
 cond3 = range & range2;
inthresh3 = uint8(cond3 *255);


cond = imYUV(2 , :) > 80 & imYUV(2 , :) < 135 & imYUV(3 , :) > 135 & imYUV(3 , :) < 200 & imYUV(3 , :) > imYUV(2 , :) & im(1,:) > 80 & im(2,:) > 30 & im(3,:) > 15 & abs(im(1,:) - im(2,:)) > 15 ;
inthresh = uint8(cond*255) ; 

sss = permute(reshape(inthresh' ,height , width) , [2 , 1 , 3] );
%imshow(sss)
%pause

[tmp minX] = max(sss ,[], 2);
minX = min(minX) ;
[tmp maxX] = max(sss ,[], 2);
maxX = max(maxX); 

[tmp minY] = max(sss ,[], 2);
minY = min(minY) ;
[tmp maxY] = max(sss ,[], 2);
maxY = max(maxY) ;

im = uint8(permute(reshape(im' ,height , width , 3) , [2 , 1 , 3] ));
inthresh = permute(reshape(inthresh' ,height , width) , [2 , 1 , 3] );

%for i = 1 : size(in , 1)
%for j = 1 : size(in , 2)
%   k  = reshape(im(i,j,:),3,1) ;
%  r = k(1) ; g = k(2) ; b = k(3) ;
%  mat =  [0.257 0.504 0.098 ; -0.148 -0.291 0.439 ; 0.439 -0.368 -0.071 ] ;
%  mat = reshape (m 1 , 3 , 3)
%in(i,j,:) = [0.257 0.504 0.098 ; -0.148 -0.291 0.439 ; 0.439 -0.368 -0.071 ] * double(k) + [0 ; 128 ; 128] ;
%y = in(i,j,1) ; u = in(i,j,2) ; v = in(i,j,3) ;
%if(u > 80 && u < 130 && v > 136 && v < 200 && v > u && r > 80 && g > 30 && b > 15 && abs(r - g) > 15)
%    inthresh(i,j,1) = 255 ;  inthresh(i,j,2) = 255 ; inthresh(i,j,3) = 255 ;
%    minX = min(minX , j) ; 
%    minY = min(minY , i) ; 
%    maxX = max(maxX , j) ; 
%    maxY = max(maxY , i) ; 
%end
%end
%end

%imshow(inthresh)
%pause
%output_args = inthresh ;
output_args = uint8((inthresh3 & inthresh ) *255);
%output_args = inthresh2 ;
ominX = minX ; 
ominY = minY ; 
omaxX = maxX ; 
omaxY = maxY ; 


end


