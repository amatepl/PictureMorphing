clc; close all ;clear;
%image_processing_gui
img1Name = 'test1.jpg';  % source image
img2Name = 'test2.jpg';  % destination image 
img1=imread(img1Name);
img2=imread(img2Name); 

[newRowSize, newColSize]=size(img1);
newColSize = newColSize/3;
newSize=[ newRowSize ; newColSize ];
               
l2=[160 170 160 640; 160 170 720 170];
l1=[160 170 160 640; 160 170 720 100];
                
P1 = [l2(1,1); l2(1,2)];
Q1 = [l2(1,3); l2(1,4)];

P2 = [l2(2,1); l2(2,2)];
Q2 = [l2(2,3); l2(2,4)];

Pd1 = [l1(1,1); l1(1,2)];
Qd1 = [l1(1,3); l1(1,4)];

Pd2 = [l1(2,1); l1(2,2)];
Qd2 = [l1(2,3); l1(2,4)];

x1 = [P1(2);Q1(2)];
y1 = [P1(1);Q1(1)];

x2 = [P2(2);Q2(2)];
y2 = [P2(1);Q2(1)];

xd1 = [Pd1(2);Qd1(2)];
yd1 = [Pd1(1);Qd1(1)];

xd2 = [Pd2(2);Qd2(2)];
yd2 = [Pd2(1);Qd2(1)];

destIm = multiLineMorph( img1Name ,l2 , l1 , 2  , newSize);

figure;
imshow(img1);
hold on;
line(x1, y1,'Color','red');
hold on;
line(x2,y2,'Color','green');
hold on;

figure;
imshow(destIm);
hold on;
line(xd1, yd1,'Color','red');
hold on;
line(xd2,yd2,'Color','green');
hold on;
