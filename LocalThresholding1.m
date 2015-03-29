function [ out ] = LocalThresholding1( OrgImg , ThreshImg ,  segments )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

ratioX = size(OrgImg,1) / segments ; 
ratioY = size(OrgImg,2) / segments ; 
cond = zeros(size(OrgImg)) ;


handMean = double(sum(sum(double(double(OrgImg).*double(repmat(ThreshImg , 1 , 1 , 3)/255)))) ./  (double(sum(sum(repmat(ThreshImg , 1 , 1 , 3) ~= 0))) ) );
bkgroundMean =  double(sum(sum(double(double(OrgImg).*(double(repmat(ThreshImg , 1 , 1 , 3)/255) == 0) ))) ./  (double(sum(sum(repmat(ThreshImg , 1 , 1 , 3) == 0))) )) ;
img2F = double(abs(double(OrgImg) - repmat(handMean , size(OrgImg,1) , size(OrgImg,2))) < double(abs(double(OrgImg) -repmat(bkgroundMean , size(OrgImg,1) , size(OrgImg,2)))) )*255;
%classification according o the nearest frm hand mean and background

for i = 1 : segments
    for j = 1 : segments
        RangeX = floor((i-1)*ratioX+1 : i*ratioX) ;
        RangeY = floor((j-1)*ratioY+1 : j*ratioY) ;
        subOrgImg = OrgImg( RangeX , RangeY , :) ;
        subThreshImg = subOrgImg .* (repmat(ThreshImg( RangeX , RangeY ) , 1 , 1 , 3)/255);
        
        RsubThreshImg = reshape(subThreshImg , length(RangeX) * length(RangeY) , 1 , 3) ;
        NumOfNonzerosThresh = sum(RsubThreshImg ~= 0); %threshold
        MeanThresh = sum(RsubThreshImg) ./ NumOfNonzerosThresh ;
        
        subThreshImgAll = double(subOrgImg) .* double(~(repmat(ThreshImg( RangeX , RangeY ) , 1 , 1 , 3)/255));
        RsubOrgImg = reshape(subThreshImgAll , length(RangeX) * length(RangeY) , 1 , 3) ;
        NumOfNonzerosAll = sum(RsubThreshImg == 0); 
        MeanAll = sum(RsubOrgImg) ./ NumOfNonzerosAll ;
        
        m1 = repmat(MeanThresh , length(RangeX) , length(RangeY)) ;
        m2 = repmat(MeanAll , length(RangeX) , length(RangeY)) ;
        
        z = repmat(MeanThresh ,  length(RangeX) * length(RangeY) , 1 , 1) ;
        zz = ((double(RsubThreshImg) - z)) .* (double(RsubThreshImg)~=0);% new
        Variance = double(sum(zz.^2 ) ./ NumOfNonzerosThresh) ;
        sThresh = repmat(double(sqrt(Variance)) ,  length(RangeX) , length(RangeY)); 
        
        z = repmat(MeanAll ,  length(RangeX) * length(RangeY) , 1 , 1) ;
        zz = ((double(RsubOrgImg) - z)) .* (double(RsubOrgImg)==0);% new
        sAll = repmat(double(sqrt(Variance)) ,  length(RangeX) , length(RangeY)); 
        %if m == 0 find the nearest 1 
        % relation 3la variance l skin wl variance kolo 
        probS1 = sThresh ./ (sThresh + sAll) ; 
        probS2 = sAll ./ (sThresh + sAll) ; 
        %cond(RangeX , RangeY , :) = abs(m1-double(subOrgImg)) <  abs(m2-double(subOrgImg));%*0.8 + (1/NumOfNonzeros(1,1,1))*(ratioX*ratioY)*0.2  ; 
        %cond(RangeX , RangeY , :) = abs(m1-double(subOrgImg)).*probS1 <  abs(m2-double(subOrgImg)).*probS2;%*0.8 + (1/NumOfNonzeros(1,1,1))*(ratioX*ratioY)*0.2  ; 
        %cond(RangeX , RangeY , :) = abs(m1-double(subOrgImg)) < (sThresh+30);%*0.8 + (1/NumOfNonzeros(1,1,1))*(ratioX*ratioY)*0.2  ; 
        %cond(RangeX , RangeY , :) = abs(m1-double(subOrgImg)) < abs(double(repmat(bkgroundMean  ,  length(RangeX) , length(RangeY))-double(subOrgImg)));%*0.8 + (1/NumOfNonzeros(1,1,1))*(ratioX*ratioY)*0.2  ; 
        %cond(RangeX , RangeY , :) = abs(m1-double(subOrgImg)) < 40;%*0.8 + (1/NumOfNonzeros(1,1,1))*(ratioX*ratioY)*0.2  ; 
        
        %if(NumOfNonzerosThresh(1,1,1) ~= 0)
        %   mm1 =  int32(m1(1,1,:))
        %   ss1 = double(sThresh(1,1,:))
        %   mm2 =  int32(m2(1,1,:))
        %   ss2 =  double(sAll(1,1,:))
        %   handMean
        %   bkgroundMean
           % imshow(cond)
        %     end
        
         if(abs(repmat(bkgroundMean  ,  length(RangeX) , length(RangeY)) - m2) < abs(repmat(handMean  ,  length(RangeX) , length(RangeY)) - m2) )
            cond(RangeX , RangeY , :) = repmat(sum(abs(m1-double(subOrgImg)).*probS1,3) <  sum(abs(m2-double(subOrgImg)).*probS2,3) , 1 , 1 , 3);%*0.8 + (1/NumOfNonzeros(1,1,1))*(ratioX*ratioY)*0.2  ;    
         else
             %ashof l closest point
             cond(RangeX , RangeY , :) = repmat( sum(abs(m1-double(subOrgImg)),3) < sum(abs(double(repmat(bkgroundMean  ,  length(RangeX) , length(RangeY))-double(subOrgImg))),3) , 1, 1 , 3);%*0.8 + (1/NumOfNonzeros(1,1,1))*(ratioX*ratioY)*0.2  ; 
        end
        %ppp = 1000 
    end
end

%imshow(ThreshImg)
%pause ;
out = uint8(img2F(:,:,1)&img2F(:,:,2)&img2F(:,:,3))+ThreshImg ;

out = double(cond(:,:,1)*255)+double(ThreshImg);
sstrel = strel('disk' , 2) ; 
out = imerode(out , sstrel);
out = imdilate(out , sstrel);
%imshow(out)
%pause ; 
end

