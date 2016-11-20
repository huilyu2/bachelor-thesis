function [FinalE,index] = Exsearch(codebookWt,codebookWr,initial_wt,H)
% exhaustive search of given codebook Wt and Wr
% codebookWt ----- codebook in the transmit end
% codebookWr ----- codebook in the receive end
% initial_wt ----- all - cover AWVs in transmit end
% H -------- the channel matrix
% FinalE ------ final receive energy
% index ------ final index in both transmit end codebook and receive end
%               codebook
%     wr = DFT_AWVs(Nr);
    DimWr = size(codebookWr);
    DimWt = size(codebookWt);
    Mt = DimWt(2);
    Mr = DimWr(2);
    wr = codebookWr;
    wt = initial_wt;
%     wr = DFT_AWVs_En(Nr);
%     Mt = 2 * Nt;
%     Mr = 2 * Nr;
%     wt = codebook(Nt, 0);
    for i = 1: Mr
        y1(i) = wr(:,i)' * H * wt;
    end
    energy1 = abs(y1) .^2;
    [a1, b1] = max(energy1);
    
%     wt = DFT_AWVs(Nt);
    wt = codebookWt;
%     wt = DFT_AWVs_En(Nt);
    for i = 1: Mt
        y2(i) = wt(:,i)' * H' * wr(:,b1);
    end
    energy2 = abs(y2) .^2;
    [a2, b2] = max(energy2);
    FinalE = a2;
    index = [b1, b2];
end