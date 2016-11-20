function [result] = codebook(N, k)
% this function is to generate a sector level codebook
% N ------ the number of anneta number 
% m ------- the search step

    ZC = ZadoffChuSeq(N/2^k);
    interv = 2^k;
%     ZC = ZadoffChuSeq(N/3^k);
%     interv = 3^k;
    b = zeros(N, 1);
    c = [];
    j = 1;
    for i = 1: interv: N
        b(i) = ZC(j);
        j = j + 1;
    end
    
    for i = 1: interv
        c(:,i) = [b(end - i + 2: end); b(1:end - i + 1 )];
    end
    
    for i = 1: interv
        result(:,i) =  DFT_AWVs(N) * c(:,i);
%         result_shift(:,i) = DFT_AWV(N) * c(:,i);
    end

end