function [ u ] = calc_U ( X, P, Q )
%   Computation of the coordinate mapping u. 
%   The value u is the position along the oriented line PQ.
%   X  - position of the pixel the is worked on.

    sizeX = size(X);
    
    Pmatx = ones(sizeX(1:2))*P(1);
    Pmatx(:,:,2) = ones(sizeX(1:2))*P(2);
    
    Qmatx = ones(sizeX(1:2))*Q(1);
    Qmatx(:,:,2) = ones(sizeX(1:2))*Q(2);
    
    res = dot((X-Pmatx),(Qmatx-Pmatx),3);     % Dot product
    u = res./vecnorm(Qmatx-Pmatx,2,3).^2;
    %u = res./vecnorm(Qmatx-Pmatx,2,3);

end
