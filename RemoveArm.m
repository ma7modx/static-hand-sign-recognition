function [ img ] = RemoveArm( hand )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[B L] = bwboundaries(hand);
imshow(label2rgb(L, @jet, [.5 .5 .5]));

val = 0 ;
for i = 1 : size(B) 
    save = B{i} ; 
    if(size(save,1) > val) 
        val = size(save , 1) ;
        indx = i ; 
    end
end

boundary = B{indx} ;
maxY = max(boundary(:,1)) ;
%maxY
indices = find(boundary(:,1) == maxY) ;  
%boundary(indices , :) 
[ tmpmin ind1 ] = min(boundary(indices,2)) ; 
[ tmpmax ind2 ] = max(boundary(indices,2)) ; 
ind1 = find(boundary(:,1) == maxY & boundary(:,2) == tmpmin);
ind2 = find(boundary(:,1) == maxY & boundary(:,2) == tmpmax);

initdiff = sqrt((boundary(ind1,1)-boundary(ind2,1))^2 +  (boundary(ind1,2)-boundary(ind2,2))^2 );
imshow(hand);
%hold on ; 
for i = 1 : size(boundary,1)
 i1 = mod(ind1+i-1,size(boundary,1))+1 ; 
 i2 = mod(ind2-i-1 + size(boundary,1) , size(boundary,1))+1 ; 
   diff = sqrt((boundary(i1,1)-boundary(i2,1))^2 +  (boundary(i1,2)-boundary(i2,2))^2 );
 % plot(boundary(i1,2) , boundary(i1,1) , '*r');
 % plot(boundary(i2,2) , boundary(i2,1) , '*b');
 % pause
   if(diff > initdiff+10)
       break;
   end
   initdiff = min(initdiff , diff) ; 
end
%hold off ; 

img = zeros(size(hand));
img(1:boundary(i1,1) , : ) = hand(1:boundary(i1,1) , :);
%imshow(img)
%pause
end

