function [NextID, RecEnergy] = simplesearch_v3(N,  H, wt)
% This is a file for binary search of new method, which a 2^k beam cover
% 2 of 2^(k+1) beams,k is the search step or times
% N------------antenna number of searching end
% H------------channel matrix
% wt ---------- transmit end AWVs, stable when the other end is searching
% NextID ------ the next step of search ID
% RecEnergy ------- the recieving energy of searching end in each step of
%                       search

%     NextID = 1;
%     basis = zeros(N,1);
%     for iter = 1: log2(N)
%         codebook = DFT_AWV(2^iter);
%         wr1 = [codebook(:,(2*NextID));zeros((N - 2^iter),1)];
%         wr2 = [codebook(:,(2*NextID-1));zeros((N - 2^iter) ,1)];
%         y1 = wr1' * H * wt;
%         y2 =  wr2' * H * wt;
%         energy1 = abs(y1)^2;
%         energy2 = abs(y2)^2;
%         RecordID(iter) = NextID;
%         if energy1 > energy2 
%             NextID = 2 * NextID;
%             RecEnergy(iter) = energy1;
%         else
%             NextID = 2 * NextID - 1;
%             RecEnergy(iter) = energy2;
%         end
%     end
% 
%     NextID = 1;
%     basis = zeros(N,1);
%     for iter = 1: (log(N)./log(3))
%         codebook = DFT_AWV(3^iter);
%         wr1 = [codebook(:,(3*NextID-2));zeros((N - 3^iter),1)];
%         wr2 = [codebook(:,(3*NextID-1));zeros((N - 3^iter) ,1)];
%         wr3 = [codebook(:,(3*NextID));zeros((N - 3^iter) ,1)];
%         y1 = wr1' * H * wt;
%         y2 = wr2' * H * wt;
%         y3 = wr3' * H * wt;
%         energy1 = abs(y1)^2;
%         energy2 = abs(y2)^2;
%         energy3 = abs(y3)^2;
%         RecordID(iter) = NextID;
%         if (energy1 == max(max(energy1,energy2),energy3))
%             NextID = 3 * NextID - 2;
%             RecEnergy(iter) = energy1;
%         elseif (energy2 == max(max(energy1,energy2),energy3))
%             NextID = 3 * NextID - 1;
%             RecEnergy(iter) = energy2;
%         else
%             NextID = 3 * NextID;
%             RecEnergy(iter) = energy3;
%         end
%     end

    NextID = 1;
    basis = zeros(N,1);
    iter = 1;
    codebook = DFT_AWV(2^iter);
    wr1 = [codebook(:,(2*NextID));zeros((N - 2^iter),1)];
    wr2 = [codebook(:,(2*NextID-1));zeros((N - 2^iter) ,1)];
    y1 = wr1' * H * wt;
    y2 = wr2' * H * wt;
    energy1 = abs(y1)^2;
    energy2 = abs(y2)^2;
    if energy1 >= energy2
         NextID = 2 * NextID;
         RecEnergy(iter) = energy1;
         threshold = energy1;
    else
         NextID = 2 * NextID - 1;
         RecEnergy(iter) = energy2;
         threshold = energy2;
    end
         
    for iter = 2: log2(N)
        codebook = DFT_AWV(2^iter);
        wr1 = [codebook(:,(2*NextID));zeros((N - 2^iter),1)];
        y1 = wr1' * H * wt;
        energy1 = abs(y1)^2;
        wr2 = [codebook(:,(2*NextID-1));zeros((N - 2^iter) ,1)];
        y2 =  wr2' * H * wt;
        energy2 = abs(y2)^2;
        if energy1 >= 1.8*threshold
             NextID = 2 * NextID;
             threshold = energy1;
             RecEnergy(iter) = energy1;
        elseif energy1 <= 0.7*threshold
                  NextID = 2 * NextID - 1;
                  threshold = 1.8*threshold;
                  RecEnergy(iter) = energy2;
        else
             if energy1 >= energy2 
                    NextID = 2 * NextID;
                    threshold = energy1;
                    RecEnergy(iter) = energy1;
             else
                    NextID = 2 * NextID - 1;
                    threshold = energy2;
                    RecEnergy(iter) = energy2;
             end
        end
            
    end
    
    
end