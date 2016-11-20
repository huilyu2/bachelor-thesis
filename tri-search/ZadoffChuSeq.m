%% Generate Zadoff-Chu Sequence
function [SeqZC]=ZadoffChuSeq(SeqLength)
% This function is aimed at generatiing ZC sequence
% Please refer to http://en.wikipedia.org/wiki/Zadoff%E2%80%93Chu_sequence
% for detailed information about this sequence
% The ZC sequence's character is constant amplitude wherever in time
% domain or in frequent domain
% This function is directly copied from instructor xiao
    Nzc = SeqLength;
    n = [0:1:Nzc-1];
%     k = 3;
    k = 3;
    if(mod(SeqLength,2)==1)
        SeqZC = exp(1j*2*pi*k.*(n+n.*(n+1)/2)/Nzc);
    else
        SeqZC = exp(1j*2*pi*k.*(n+n.*(n)/2)/Nzc);
    end
    SeqZC =SeqZC.'/sqrt(SeqLength);
end
