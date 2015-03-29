function [ ] = Train( )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[s , ss , r1 , t1] = main2('RH1_1.jpg');
[s , ss , r2 , t2] = main2('RH1_2.jpg');
[s , ss , r3 , t3] = main2('RH1_3.jpg');
[s , ss , r4 , t4] = main2('RH1_4.jpg');
[s , ss , r5 , t5] = main2('RH1_5.jpg');
[s , ss , r6 , t6] = main2('RH1_6.jpg');
[s , ss , r7 , t7] = main2('hand_3Fingers.jpg');
[s , ss , r8 , t8] = main2('RH1_8.jpg');
[s , ss , r9 , t9] = main2('RH1_9.jpg');
[s , ss , r10 , t10] = main2('RH1_10.jpg');

[s , ss , r1f , t1f] = main2('RH1_1f.jpg');
[s , ss , r2f , t2f] = main2('RH1_2f.jpg');
[s , ss , r3f , t3f] = main2('RH1_3f.jpg');
[s , ss , r4f , t4f] = main2('RH1_4f.jpg');
[s , ss , r5f , t5f] = main2('RH1_5f.jpg');
[s , ss , r6f , t6f] = main2('RH1_6f.jpg');
[s , ss , r7f , t7f] = main2('hand_3Fingersf.jpg');
[s , ss , r8f , t8f] = main2('RH1_8f.jpg');
[s , ss , r9f , t9f] = main2('RH1_9f.jpg');
[s , ss , r10f , t10f] = main2('RH1_10f.jpg');

save('workspace.mat');
end

