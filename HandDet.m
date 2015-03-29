function [ output ] = HandDet( path , ErosionSize )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
a = imread(path);
imshow(a)
%pause
i = rgb2gray(a);
e = edge(i , 'canny');
ec = imcomplement(e);
ball = strel ('square' , ErosionSize);
%ece = ec ;
ece = imerode(ec , ball);
imshow(ece);
pause

cc = bwconncomp(ece);
compdata = regionprops(cc,'basic')
comp_areas = [compdata.Area];
[max_area, idx] = max(comp_areas);
background = false(size(ece));
background(cc.PixelIdxList{idx}) = true;
background = imdilate(background , ball);
imshow(background);
pause

hand = zeros(size(ece)); 
for i = 1 : size(ece,1)
    for j = 1 : size(ece,2)
        hand(i,j) = bitor(~background(i,j) ,~ece(i,j));
    end
end

handex = imerode(hand , ball);
handex = imdilate(handex , ball);
imshow(handex);
output = handex ;

end

