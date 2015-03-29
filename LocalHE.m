function New = LocalHE(Old, WinSize)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
New = zeros(size(Old)) ;
size(Old)
for i = 1 : floor(size(Old , 1)) 
    for j = 1 : floor(size(Old, 2)) 
        New(i, j, :) = localEq(Old, i, j, WinSize, 255) ;
    end
end


New = uint8(New);
 

end

function Res = localEq(img, x, y, WinSize, k)
Res = zeros(1,size(img,3)) ;
freq = zeros(255+1,3);
for i = 1 : WinSize
    for j = 1 : WinSize
        indexi = x - floor(WinSize/2 +1) + i ;
        indexj = y - floor(WinSize/2 +1) + j ;
        if(indexi <= size(img,1) && indexj <= size(img,2) && indexi > 0 && indexj > 0)
            for c = 1 : size(img,3)
                color = img(indexi , indexj , c) ;
                freq(color+1 , c) =  freq(color+1 , c) + 1 ;
            end
        end
    end
end

sum = zeros(1,size(img,3)) ; 
Round = zeros(255+1,3);
RTotalSum = (WinSize*WinSize);
for i = 1 : 255+1 
     sum = sum + freq(i,:);
     Round(i,:) = round(sum / RTotalSum*k);
end 

for c = 1 : size(img,3)
color = img(x , y , c);
Res(c) = Round(color+1 , c);
end

end

