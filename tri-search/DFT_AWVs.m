function W = DFT_AWVs(N)
% used for generating a AWVs coresponding to DFT matrix
% this function is based on the DFT_Matrix.m copied from
% instructor Xiao
% N----- the number of annterna
W = zeros(N,N);
w = exp(-1j*pi);
for k=1:N
    W(:,k) = w.^((1-(2*k-2)/N)*(0:N-1)')/sqrt(N);
%     W(:,k) = w.^((1-(2*k-2)/N)*(0:N-1)')/sqrt(N);

% W(:,1) = w.^((0:N-1)')/sqrt(N);
% for k=2:N
%     W(:,k) = w.^((1-(2*3^(k-2))/N)*(0:N-1)')/sqrt(N);

end