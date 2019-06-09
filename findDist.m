function [ dist ] = findDist( X, u, v, P, Q )
    
    sizeX = size(X);
    
    Pmatx = ones(sizeX(1:2))*P(1);
    Pmatx(:,:,2) = ones(sizeX(1:2))*P(2);
    
    Qmatx = ones(sizeX(1:2))*Q(1);
    Qmatx(:,:,2) = ones(sizeX(1:2))*Q(2);
    
    % 0<u<1
    v = abs(v);
    v(u<=0 | u>=1) = 0;
    
    % u<=0
    dist1 = vecnorm(X-Pmatx,2,3);
    dist1(u>0) = 0;
    
    % u>=1
    dist2 = vecnorm(X-Qmatx,2,3);
    dist2(u<1) = 0;
    
    dist = v + dist1 + dist2;
    
% 
%     if (u>0 && u<1)
%         dist = norm(v);
%     elseif (u<=0)
%         dist = norm(X-P);
%     elseif (u>=1)
%         dist = norm(X-Q);
%     end
    
end
