function [euclideanDistance] = eculidean(firstArray, secondArray)

distance = 0.0;

for i = 1: size(firstArray)
    diff = abs(firstArray(i) - secondArray(i));
    distance = distance + diff;
end
euclideanDistance = sqrt(distance);


%euclideanDistance = sqrt(sum(abs(firstArray - secondArray))) ;

end