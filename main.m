function [ outM , outU , mfigure] = main( path )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

img = imread(path);
imshow(img)
pause

%[koko , img] = CorrNonUniformIllu(img , 10) ; 
%imshow(img) 
%pause ;

%inhancing
factor =floor( (size(img,1) + size(img,2)) / 100 )  ;
gauss = fspecial ('gaussian' , factor  , factor/5) ;
img = imfilter(img,gauss);
imshow(img) 
pause 

[hand , minX , minY , maxX , maxY]  = skinDet( img ) ;

hand = LocalThresholding(img , hand , 10 , 2) ; 
imshow(hand)
pause ; 
%inhancing
ball = strel ('rectangle' , [ floor((maxY - minY) / 15)  , floor((maxX - minX) / 50)] );
hand = imdilate(hand , ball);
hand = imerode(hand , ball) ;
imshow(hand) ;
pause ; 

boundary = DetBoundary(hand) ; 

[normgraph normfactor] = NormGraph(boundary) ; 

plot(normgraph) ; 
pause
    normgraph = SmoothGraph(normgraph , 5 , 0.5);
[normgraph normfactor] = NormGraph(normgraph) ; 

plot(normgraph) ; 
pause 
[yM xM] = findpeaks(normgraph )
[yU xU] = findpeaks(100-normgraph ) %remove extra peaks that are below the centroid
%imshow(hand);


outM = [yM xM] ;
outU = [yU xU] ; 
mfigure = normgraph ; 
end