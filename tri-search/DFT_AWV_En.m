function W = DFT_AWV_En(N,booksize)
% used for generating a shifted AWVs coresponding to DFT matrix
% the differnt between DFT_AWV and DFT_AWV_En is that the pattern number 
% in this codebook is bigger than in DFT_AWV.
% this function is based on the DFT_Matrix.m copied from
% instructor Xiao

% N----- the number of annterna
% booksize ------- the codebook size of N antenna

% pattern_N = 2/gap * N;
pattern_N = booksize * N;
gap = 2 /booksize; %the gap of each step
% gap = 1;
W = zeros(N,pattern_N);
w = exp(-1j*pi);
for k=1:pattern_N
    W(:,k) = w.^((1-(gap*k-1)/N)*(0:N-1)')/sqrt(N);
end