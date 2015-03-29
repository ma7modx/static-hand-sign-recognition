function [ boundaryOut , output_args ] = DetBoundary( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[B L] = bwboundaries(input_args);

%figure(5) ;
%imshow(label2rgb(L, @jet, [.5 .5 .5]));

%pause 

 % s  = regionprops(input_args, 'centroid');
 %       centroids = cat(1, s.Centroid);
 %       hold on
 %       plot(centroids(:,1), centroids(:,2), 'b*')
 %       hold off
 

val = 0 ;
for i = 1 : size(B) 
    save = B{i} ; 
    if(size(save,1) > val) 
        val = size(save , 1) ;
        indx = i ; 
    end
end

boundary = B{indx} ;

minX = min(boundary(:,2));
minY = min(boundary(:,1));
maxX = max(boundary(:,2));
maxY = max(boundary(:,1));


normX = (maxX - minX) / maxX;
normY = (maxY - minY) / maxY;
orgX = minX + ((maxX - minX) / 2); %min+X
%orgY = minY + (maxY - minY) / 2; 
orgY = maxY ; 

%orgX = centroids(size(centroids,1) , 1) ; 
%orgY = centroids(size(centroids,1) , 2) ; 


[ tmp start ] = min(sqrt((boundary(:,2) - orgX).^2 + (boundary(:,1) - orgY).^2)); %get maxY and minX point


boundarySize = size(boundary , 1) ; 
boundaryTmp = [boundary ; boundary] ; 
boundaryFinal = boundaryTmp(start : start+ boundarySize , :) ; 


ss = int32(floor(size(boundaryFinal , 1)/5)) ;

%hold on
%plot(orgX , orgY , '*r');
%for i = 1 : ss : size(boundaryFinal , 1) -ss
%    for k = 1 : ss
%plot(boundaryFinal(i+k,2), boundaryFinal(i+k,1), 'r', 'LineWidth', 2);
%
%    end
%end
%hold off



boundaryFinal(: , 2) = (boundaryFinal(: , 2) ) ;%-min* normX ; 
boundaryFinal(: , 1) = (boundaryFinal(: , 1) ) ;%-min* normY ; 

dist = sqrt((boundaryFinal(:,2) - orgX).^2 + (boundaryFinal(:,1) - orgY).^2);

%plot(dist);
%pause 

boundaryOut = boundaryFinal ; 
output_args = dist ;
end

