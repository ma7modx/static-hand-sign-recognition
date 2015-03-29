function [predictedClass] = classifier(testImage)
predictedClass = 0;
load('workspace.mat');
[k , kk , testImage.list , ret2] = main2(testImage);
%imshow(testImage.list);
testImage.num = 0;

r1.list = r1;
r1.num = 1;
r2.list = r2;
r2.num = 2;
r3.list = r3;
r3.num = 3;
r4.list = r4;
r4.num = 4;
r5.list = r5;
r5.num = 5;
r6.list = r6;
r6.num = 6;
r7.list = r7;
r7.num = 7;
r8.list = r8;
r8.num = 8;
r9.list = r9;
r9.num = 9;
r10.list = r10;
r10.num = 10;

r1f.list = r1f;
r1f.num = 11;
r2f.list = r2f;
r2f.num = 12;
r3f.list = r3f;
r3f.num = 13;
r4f.list = r4f;
r4f.num = 14;
r5f.list = r5f;
r5f.num = 15;
r6f.list = r6f;
r6f.num = 16;
r7f.list = r7f;
r7f.num = 17;
r8f.list = r8f;
r8f.num = 18;
r9f.list = r9f;
r9f.num = 19;
r10f.list = r10f;
r10f.num = 20;

trainingItems = [r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r1f, r2f, r3f, r4f, r5f, r6f, r7f, r8f, r9f, r10f];
distances(20).dis = -10000;
distances(20).index = -1;

for i = 1: 20
    
k1 = find(trainingItems(i).list >  30); 
k2 = find((testImage.list > 30 ));
t1 = trainingItems(i).list(k1) ;
t2 = testImage.list(k2) ;
[fy1 fx1] = findpeaks(t1);
[fy2 fx2] = findpeaks(t2);
[zy1 zx1] = findpeaks(t1*-1);
[zy2 zx2] = findpeaks(t2*-1);

diffx1 = fx1(2:size(fx1,2)) - fx1(1:size(fx1,2)-1);
diffx2 = fx2(2:size(fx2,2)) - fx2(1:size(fx2,2)-1);
diffy1 = fy1(2:size(fy1,2)) - fy1(1:size(fy1,2)-1);
diffy2 = fy2(2:size(fy2,2)) - fy2(1:size(fy2,2)-1);


difzx1 = abs(zx1(2:size(zx1,2))) - abs(zx1(1:size(zx1,2)-1));
difzx2 = abs(zx2(2:size(zx2,2))) - abs(zx2(1:size(zx2,2)-1));
difzy1 = abs(zy1(2:size(zy1,2))) - abs(zy1(1:size(zy1,2)-1));
difzy2 = abs(zy2(2:size(zy2,2))) - abs(zy2(1:size(zy2,2)-1));

t1 = t1(1:min(length(t1),length(t2))) ;
t2 = t2(1:min(length(t1),length(t2))) ;

if(length(fx1) == length(fx2))
   temp = sum(abs(t1 -  t2)) + 20*sum(abs(diffx1 - diffx2)) + 60*sum(abs(diffy1-diffy2) ) + 20*sum(abs(difzx1 - difzx2)) + 60*sum(abs(difzy1-difzy2))  ;
else
   temp = sum(abs(t1 -  t2)) *10*(abs(length(fx1) - length(fx2))) ;    
end
distances(i).dis = temp;
    distances(i).index = trainingItems(i).num;
end

minimumIndex = -1;
minimumDistance = 0.0;

for i = 1: 20
    if i == 1
        minimumDistance = distances(i).dis;
        minimumIndex = i;
    else
        if distances(i).dis < minimumDistance
            minimumDistance = distances(i).dis;
            minimumIndex = i;
        end
    end
end

k2 = find(trainingItems(minimumIndex).list >  30);
k3 = find((testImage.list > 30 )) ; 
k1 = find(trainingItems(17).list >  30);
tt2 = trainingItems(minimumIndex).list(k2) ;
tt3 = testImage.list(k3) ;
tt1 = trainingItems(17).list(k1) ;

%int32(sum(abs(trainingItems(minimumIndex).list -  testImage.list)))

figure(43)
hold on
plot( tt2 , 'g')
plot(tt3 , 'b') 
%plot(tt1 , 'r')
hold off 

predictedClass = distances(minimumIndex).index;
%int32(distances(minimumIndex).dis)

end
