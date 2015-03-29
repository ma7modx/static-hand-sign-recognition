function [ outM , outU , mfigure , bfigure ] = main2( path )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

img = imread(path);

%color normalization .. dont have that great effect
%r = double(img(:,:,1)) ./ (sum(img,3))
%g = double(img(:,:,2)) ./ (sum(img,3))
%b = double(img(:,:,3)) ./ (sum(img,3));
%img = reshape( [ r g b ], size(r,1) , size(r,2) , 3)
imshow(img)
pause

%Enhancing Smoothing
factor =floor( (size(img,1) + size(img,2)) / 100 )  ;
gauss = fspecial ('gaussian' , factor  , factor/5) ;
img = imfilter(img,gauss);
%imshow(img) 
%pause
%END

%Skin Detection
[hand , minX , minY , maxX , maxY]  = skinDet( img ) ;
imshow(hand)
pause
%imshow(hand)
%pause
%END

%Local Thresholding
hand = LocalThresholding1(img , hand , 10) ; 



%imshow(hand)
%pause
%END
%imshow(hand);
%pause ;
%Enhancing Closing
opY =  floor((maxY - minY) / 10) ;
opX = floor((maxX - minX) / 300) ;
if maxX-minX >( 0.3* size(img,2) ) 
opX = floor(size(img,2)/(maxX-minX))+1 ;
end
ball = strel ('rectangle' , [ opY , opX ] );
hand = imdilate(hand , ball);
hand = imerode(hand , ball) ;
%imshow(hand) ;
%pause
%END 

%Arm Removing
hand = RemoveArm(hand) ; 
%imshow(hand);
%pause;
%END
%imshow(hand)
%pause
%Boundary 
[BoundaryOrg , boundary] = DetBoundary(hand) ; 
BoundaryOrg(:,1)= maxY-BoundaryOrg(:,1);

%Normalizing original Boundary
[BoundaryOrg Factor] = NormGraphXY( BoundaryOrg) ; 
%plot(BoundaryOrg(:,2) ,BoundaryOrg(:,1)  , 'y') ; 
%pause

%Normalizing Distance Graph
[normgraph normfactor] = NormGraph(boundary) ; 
%plot(normgraph , 'black') ; 
%pause

%Enhancing Graph Smoothing
normgraph = SmoothGraph(normgraph , 6 , 1);
[normgraph normfactor] = NormGraph(normgraph) ; 
%plot(normgraph) ; 
%pause 

%Get top and bot Peaks
[yM xM] = findpeaks(normgraph )
[yU xU] = findpeaks(100-normgraph ) %remove extra peaks that are below the centroid

outM = [yM xM] ;
outU = [yU xU] ; 
mfigure = normgraph ;
bfigure = BoundaryOrg ;
end