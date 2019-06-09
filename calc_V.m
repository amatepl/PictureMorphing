function [ v ] = calc_V( X, P, Q )

%   Computation of the coordinate mapping v. 
%   The value v is the distance from PQ line for each pixel X of the
%   intermediate image.
%   X      - position of the pixel the is worked on.
%   Perp   - vector perpendicular to the given vector

    sizeX = size(X);
    
    Pmatx = ones(sizeX(1:2))*P(1);
    Pmatx(:,:,2) = ones(sizeX(1:2))*P(2);
    
    Qmatx = ones(sizeX(1:2))*Q(1);
    Qmatx(:,:,2) = ones(sizeX(1:2))*Q(2);

%     R = [0,-1;1,0];
%     rotated_vecc = R*vecc;          % Perp
    
    vecc = Qmatx-Pmatx;
    vecc(:,:,[1 2]) = vecc(:,:,[2 1]);
    vecc(:,:,1) = -vecc(:,:,1);
    rotated_vecc = vecc;
    
    
    v = dot((X-Pmatx),rotated_vecc,3);
    v = v./vecnorm(Qmatx-Pmatx,2,3);

end