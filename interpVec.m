function vectorSet = interpVec(image1Vec,image2Vec,nbVec)
% Function which interpolate a vector to another with a number of
% intermediate vector :
% INPUTS :
% - image1Vec : feature vectors of the image 1
% - image2Vec : feature vectors of the image 2
% - nbVec : number of intermediate vector that the user want
% OUTPUT :
% - vectorSec : Set of vectors to pass from feature vector 1 to feature
%               vector 2
    vectorSet = zeros(nbVec,4,size(image1Vec,1));
    %% Coordonates of feature vectors (comes to an imline [x1 x2 y1 y2])
    for i = 1:size(image1Vec,1)
        x1Image1 = image1Vec(i,1);
        x2Image1 = image1Vec(i,2);
        y1Image1 = image1Vec(i,3);
        y2Image1 = image1Vec(i,4);
    
        x1Image2 = image2Vec(i,1);
        x2Image2 = image2Vec(i,2);
        y1Image2 = image2Vec(i,3);
        y2Image2 = image2Vec(i,4);
    
        %% linspace transform coodonate to another with equidistance
        transX1 = linspace(x1Image1,x1Image2,nbVec);
        transX2 = linspace(x2Image1,x2Image2,nbVec);
        transY1 = linspace(y1Image1,y1Image2,nbVec);
        transY2 = linspace(y2Image1,y2Image2,nbVec);
    
        %% The set of vectors is each transformation (use convention of imline)
        vectorSet(:,:,i) = [transX1.' transX2.' transY1.' transY2.'];
    end