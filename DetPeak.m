function [ output_argsMax , output_argsMin ] = DetPeak( dist , PeakPow )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

saveMax = [-10000000 , 1] ; %value and index
saveMin = [1000000 , 1] ;

prvMax = -10000000 ;
prvMin = 10000000 ; 

retMax = [] ;
retMin = [] ; 
pow = 0 ; 
booltale3 = 0 ; 
for i = 1 : size(dist)-1
    pow = dist(i) ; 
  
    if(dist(i) - dist(i+1) <= 0 )
    saveMax = getmax(saveMax , pow , i) ; 
    prvMin = retMin(length(retMin)) ;
    end
   if(saveMax(1) - pow > PeakPow && abs(saveMax(1) - prvMin) > PeakPow)  
       retMax = [retMax , saveMax(2)] ;
       pow = dist(i) ; 
      
       saveMax = [0 , 1] ;
   end
   
   if(dist(i) - dist(i+1) >= 0) 
      saveMin = getmin(saveMin , pow , i) ;  
      prvMax = saveMax(1) ;
   end
    if(saveMin(1) - pow < -PeakPow && abs(prvMax - saveMin(1)) > PeakPow)
        prvMax
        retMin = [ retMin , saveMin(2) ] ;
        pow = dist(i) ; 
        prvMin = saveMin(1) ; 
        saveMin = [1000000 , 1] ;
   end 
 
end
output_argsMax = retMax ; output_argsMin = retMin ;  
end


function [ r ] = getmax( max , pow , i )
r = [ -1 1 ]; 
if(max(1) < pow)
    r(1) = pow ;
    r(2) = i ; 
else
    r(1) = max(1) ;
    r(2) = max(2) ;
end
end


function [ r ] = getmin( min , pow , i )
r = [ -1 1 ]; 
if(min(1) > pow)
    r(1) = pow ;
    r(2) = i ; 
else
    r(1) = min(1) ;
    r(2) = min(2) ;
end
end