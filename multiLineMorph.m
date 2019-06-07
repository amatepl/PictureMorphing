function [ destIm ] = multiLineMorph( image ,srcLines , destLines , nLines  , newSize)

        % image     - the image to be deformed
        % srcLines  - lines from the initial image space
        % destLines - guidelines for the transformation
        % nLines    - number of lines used for the transformation
        % newSize   - size of the transformed image

    srcIm = imread(image);
    
    rows = newSize(1);
    cols = newSize(2);

    srcIm = imresize(srcIm,[rows cols]);

    destIm = zeros(rows,cols,3,'uint8');

    X  = repelem([0:rows-1].',1,cols);
    X(:,:,2) = repelem(0:cols-1,rows,1); 
    
    sizeX = size(X);

    DSUM = zeros(sizeX);
    weightsum = 0;

    p = 0;
    a = 1;
    b = 2;

    for i = 1:nLines
        Pi = [destLines(i,1); destLines(i,2)];
        Qi = [destLines(i,3); destLines(i,4)];

        Pdi = [srcLines(i,1); srcLines(i,2)];
        Qdi = [srcLines(i,3); srcLines(i,4)];

        u = calc_U(X, Pi, Qi);

        v = calc_V(X, Pi, Qi);

        Xdi = round(calc_Xd(u, v, Pdi, Qdi));

        Di = Xdi - X;

        dist = findDist(X, u, v, Pi, Qi);

        length = norm(Pi-Qi);

        weight = ((length^p)./(a + dist)).^b;

        DSUM = DSUM + (Di.*weight);

        weightsum = weightsum + weight;
    end % for i = 1:nLines

    Xd = round(X + (DSUM./weightsum));
%             X1 = repelem(Xd(:,:,1),1,1,3);
%             X2 = repelem(Xd(:,:,2),1,1,3);

    %destIm(X1+1 <= 0 | X1+1 > rows | X2+1 <= 0 | X2+1 > cols) = 255;

    %% if ( 0 < Xd1+1 <= rows & 0 < Xd2+1 <= cols )
    Xd1 = Xd(:,:,1);
    Xd2 = Xd(:,:,2);

    Xd1cond = Xd1(Xd1+1 > 0 & Xd1+1 <= rows & Xd2+1 > 0 & Xd2+1 <= cols);
    Xd2cond = Xd2(Xd1+1 > 0 & Xd1+1 <= rows & Xd2+1 > 0 & Xd2+1 <= cols);

    sizeXd1cond = size(Xd1cond);

    idx1 = sub2ind(size(srcIm),Xd1cond+1,Xd2cond+1,ones(sizeXd1cond));
    idx2 = sub2ind(size(srcIm),Xd1cond+1,Xd2cond+1,2*ones(sizeXd1cond));
    idx3 = sub2ind(size(srcIm),Xd1cond+1,Xd2cond+1,3*ones(sizeXd1cond));

    X1 = X(:,:,1);
    X2 = X(:,:,2);
    X1cond = X1(Xd1+1 > 0 & Xd1+1 <= rows & Xd2+1 > 0 & Xd2+1 <= cols);
    X2cond = X2(Xd1+1 > 0 & Xd1+1 <= rows & Xd2+1 > 0 & Xd2+1 <= cols);

    sizeX1cond = size(X1cond);

    idx1d = sub2ind(size(destIm),X1cond+1,X2cond+1,ones(sizeX1cond));
    idx2d = sub2ind(size(destIm),X1cond+1,X2cond+1,2*ones(sizeX1cond));
    idx3d = sub2ind(size(destIm),X1cond+1,X2cond+1,3*ones(sizeX1cond));

    destIm(idx1d) = srcIm(idx1);
    destIm(idx2d) = srcIm(idx2);
    destIm(idx3d) = srcIm(idx3);

    %% if ( Xd1+1 <= 0 | Xd1+1 > rows | Xd2+1 <= 0 | Xd2+1 > cols )
    X1cond = X1(Xd1+1 <= 0 | Xd1+1 > rows | Xd2+1 <= 0 | Xd2+1 > cols);
    X2cond = X2(Xd1+1 <= 0 | Xd1+1 > rows | Xd2+1 <= 0 | Xd2+1 > cols);

    sizeX1cond = size(X1cond);

    idx1 = sub2ind(size(destIm),X1cond+1,X2cond+1,ones(sizeX1cond));
    idx2 = sub2ind(size(destIm),X1cond+1,X2cond+1,2*ones(sizeX1cond));
    idx3 = sub2ind(size(destIm),X1cond+1,X2cond+1,3*ones(sizeX1cond));

    destIm(idx1) = 255;
    destIm(idx2) = 255;
    destIm(idx3) = 255;
    %%
%             if (Xd(1)+1 <= 0 || Xd(1)+1 > rows || Xd(2)+1 <= 0 || Xd(2)+1 > cols)
%                 destIm(X(1)+1,X(2)+1,:) = 255;
%             else
%                 destIm(X(1)+1,X(2)+1,:) = srcIm(Xd(1)+1,Xd(2)+1,:);
%             end % if


end