function [ out ] = LocalThresholding( OrgImg , ThreshImg ,  segments , error )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
size(ThreshImg)
ratioX = size(OrgImg,1) / segments ; 
ratioY = size(OrgImg,2) / segments ; 
cond = zeros(size(OrgImg)) ;
for i = 1 : segments
    for j = 1 : segments
        RangeX = floor((i-1)*ratioX+1 : i*ratioX) ;
        RangeY = floor((j-1)*ratioY+1 : j*ratioY) ;
        subOrgImg = OrgImg( RangeX , RangeY , :) ;
        subThreshImg = subOrgImg .* repmat(ThreshImg( RangeX , RangeY ) , 1 , 1 , 3)  ;
        RsubThreshImg = reshape(subThreshImg , length(RangeX) * length(RangeY) , 1 , 3) ;
        NumOfNonzeros = sum(RsubThreshImg ~= 0)  
        Mean = sum(RsubThreshImg) ./ NumOfNonzeros ;
        m = repmat(Mean , length(RangeX) , length(RangeY)) ;
        z = repmat(Mean ,  length(RangeX) * length(RangeY))
        pause
        zz = ((double(RsubThreshImg) - z) .* double(RsubThreshImg))
        Variance = sum(zz.^2 ) ./ NumOfNonzeros ;
        Variance
        %s = (sqrt(Variance)) 
        %if m == 0 find the nearest 1 
        cond(RangeX , RangeY , :) = abs(m-double(subOrgImg)) > (100) ;   
    end
end
imshow(ThreshImg)
pause ;
out = uint8(cond) .* uint8(OrgImg) ;
figure
imshow(out)
pause ; 
end

