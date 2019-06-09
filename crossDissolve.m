function [ destImage ] = crossDissolve( image1 , image2 ,frameNumber,totalFrames) 

% Resizing the images if necessary (Both the images should be equal in size) 
image2=imresize(image2,[size(image1,1) size(image2,2)]);

p = double(image2);
q = double(image1);
destImage = p + (1-frameNumber/totalFrames).*(q-p);
            
destImage=uint8(destImage)  ;