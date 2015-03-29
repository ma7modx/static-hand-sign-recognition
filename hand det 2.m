a = imread('open-hand.png');
imshow(a)
pause
i = rgb2gray(a);
e = edge(i , 'canny');
ec = imcomplement(e);
ball = strel ('square' , 5);
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
imshow(background);
pause

size(ece)
size(background)
hand = zeros(size(ece)); 
for i = 1 : size(ece,1)
    for j = 1 : size(ece,2)
        hand(i,j) = ~background(i,j) | ~ece(i,j);
    end
end
imshow(hand);