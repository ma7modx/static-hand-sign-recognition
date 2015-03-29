function [euclideanDistance] = eculideanXY(firstArray, secondArray)
size(firstArray)
size(secondArray)
distance = 0.0;
%[count class] = max(size(firstArray,1),size(secondArray,1));
S = max(size(firstArray , 1) , size(secondArray , 1)) ; 
ret1 = zeros(S , 1) ;
ret2 = zeros(S , 1) ;
%min ( sqrt((firstArray(2,1) - secondArray(:,1)).^2 + (firstArray(2,2) - secondArray(:,2)).^2) )
for i = 1: size(firstArray,1)
  ret1(i) = min ( sqrt((firstArray(i,1) - secondArray(:,1)).^2 + (firstArray(i,2) - secondArray(:,2)).^2) ) ; 
    
    % if(class == 1)
   % valX = firstArray(i,2) ;
   % else
   % valX = secondArray(i,2) ;    
   % end
   % k1 = find(firstArray(i,2) == valX) ; 
   % k2 = find(secondArray(i,2) == valX) ; 
   % vals1 = firstArray(k1,1);
   % vals2 = secondArray(k2,1);
   % vals1 = sort(vals1 , 'descend') ;
   % vals2 = sort(vals2 , 'descend') ; 
   % SS = min(length(vals1) , length(vals2)) ; 
   % diff = abs(vals1(1:SS) - vals2(1:SS)) + abs(length(vals1) - length(vals2));
   %distance = distance + diff;
end
for i = 1: size(secondArray,1)
  ret2(i) = min ( sqrt((secondArray(i,1) - firstArray(:,1)).^2 + (secondArray(i,2) - firstArray(:,2)).^2) ) ; 
end
size(ret1) 
size(ret2)
distance = sum(ret1 + ret2) ; 
euclideanDistance = distance;


%euclideanDistance = sqrt(sum(abs(firstArray - secondArray))) ;

end