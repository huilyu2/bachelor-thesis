function [index,energy] = beamrefine(N,H,wt,centID,gap)
% beam refining function to get the AWV ID in expanded codebook
% gap ---------- the expanded number of pattern for N antenna; thus the
%                codebook size is gap*N when the antenna number is N
% N ----------- the number of antenna 
% H ------------ channel matrix
% centID -------- the AWV ID result of sparse search in codebook size of
%                   N*N
% index ------------- the beam refining ID for expanded codebook of gap*N
% energy ------------ the max energy of receiving end for every search

    codebook = DFT_AWV_En(N,gap);
    if centID ~= N
        ObjZone = codebook(:,[gap * centID - (gap - 1): gap * centID + (gap - 1)]);
    else
        ObjZone = [codebook(:,[gap * centID - (gap - 1): gap * centID]),codebook(:,[1: (gap - 1)])];
    end

    Dim = size(ObjZone);
    left =  1;
    j = 1;
    right  = Dim(2);
    middle = (left + right)/2;
    
    while(abs(left - right) > 1)
         y1 = ObjZone(:,left)' * H * wt;
         y3 = ObjZone(:,right)' * H * wt;
         energy1 = abs(y1)^2;
         energy3 = abs(y3)^2;

        [MaxE,index] = max([energy1,energy3]);
        energy(j) = MaxE;
        j = j + 1;
        
        if index == 2
            left = middle;
        else
            right = middle;
        end
        middle = floor((right + left)/2);  
    end
%     j = j + 1;
    y1 = ObjZone(:,left)' * H * wt;
    y3 = ObjZone(:,right)' * H * wt;
    energy1 = abs(y1)^2;
    energy3 = abs(y3)^2;
    [MaxE,index] = max([energy1,energy3]);
    energy(j) = MaxE;
    
    Dim = size(energy);% used for solving the dimension problem
    if Dim(2) < gap
        energy(j+1) = MaxE;
    end
    
    if index == 2
        maxID = right;
    else
        maxID = left;
    end

    index = gap * centID - gap + maxID;
    if index > gap * N
        index = mod(index, gap * N);
    end
         
end