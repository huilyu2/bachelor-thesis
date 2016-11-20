function W = DFT_AWV(N)
% used for generating a shifted AWVs coresponding to DFT matrix
% this function is based on the DFT_Matrix.m copied from
% instructor Xiao
% N----- the number of annterna
W = zeros(N,N);
w = exp(-1j*pi);
for k=1:N
    W(:,k) = w.^((1-(2*k-1)/N)*(0:N-1)')/sqrt(N);
end