function [ Xd ] = calc_Xd( u, v, Pd, Qd)
%   Calculation of X in the destination image.
    
    sizeu = size(u);
    
    Pdmatx = ones(sizeu(1:2))*Pd(1);
    Pdmatx(:,:,2) = ones(sizeu(1:2))*Pd(2);
    
    Qdmatx = ones(sizeu(1:2))*Qd(1);
    Qdmatx(:,:,2) = ones(sizeu(1:2))*Qd(2);
    
    res = u.*(Qdmatx-Pdmatx);
    
%     R = [0,-1;1,0];
%     res2 = R*(Qd-Pd);
    
    % Rotation
    res2 = Qdmatx-Pdmatx;
    res2(:,:,[1 2]) = res2(:,:,[2 1]);
    res2(:,:,1) = -res2(:,:,1);
    
    res2 = v.*res2;
    res2 = res2./vecnorm(Qdmatx - Pdmatx,2,3);
    Xd = Pdmatx + res + res2;

end