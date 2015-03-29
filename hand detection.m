a = imread('open-hand.png');
i = rgb2gray(a);
mask = fspecial('average',15);
c = corner(i);
i = imfilter(i , mask);
e = edge(i , 'canny');
imshow(e);
hold on
plot(c(:,1), c(:,2), 'r*');
%ball = strel ('square' , 20);
%Hand2 = imdilate(double(e) , ball);