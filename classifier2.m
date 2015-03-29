function [predictedClass] = classifier2(testImage)
predictedClass = 0;
load('workspace.mat');

[k , kk , ret1 , testImage.list] = main2(testImage);
testImage.num = 0;
figure(4)
hold on;
plot(testImage.list(:,2) , testImage.list(:,1) , 'b')
plot(t2(:,2) , t2(:,1) , 'r')
plot(t5(:,2) , t5(:,1) , 'g')
hold off ; 
r1.list = t1;
r1.num = 1;
r2.list = t2;
r2.num = 2;
r3.list = t3;
r3.num = 3;
r4.list = t4;
r4.num = 4;
r5.list = t5;
r5.num = 5;
r6.list = t6;
r6.num = 6;
r7.list = t7;
r7.num = 7;
r8.list = t8;
r8.num = 8;
r9.list = t9;
r9.num = 9;
r10.list = t10;
r10.num = 10;

r1f.list = t1f;
r1f.num = 11;
r2f.list = t2f;
r2f.num = 12;
r3f.list = t3f;
r3f.num = 13;
r4f.list = t4f;
r4f.num = 14;
r5f.list = t5f;
r5f.num = 15;
r6f.list = t6f;
r6f.num = 16;
r7f.list = t7f;
r7f.num = 17;
r8f.list = t8f;
r8f.num = 18;
r9f.list = t9f;
r9f.num = 19;
r10f.list = t10f;
r10f.num = 20;

trainingItems = reshape([r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r1f, r2f, r3f, r4f, r5f, r6f, r7f, r8f, r9f, r10f] , 1 , 1 , 20)
distances(20).dis = -10000;
distances(20).index = -1;
size(trainingItems(1).list)
size(testImage.list)
for i = 1: 20
    temp = eculideanXY(testImage.list, trainingItems(:,:,i).list);
    distances(i).dis = temp ;
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

%distances(1)
%distances(2)
%distances(3)
%distances(4)
%distances(5)
%distances(6)
%distances(7)Q
%distances(8)
%distances(9)
%distances(10)
%distances(minimumIndex).dis

predictedClass = distances(minimumIndex).index;

end
