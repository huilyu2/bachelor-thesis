function [H,recU,transV, coeff] = mimo_ch(coeff_arr, Nt, Nr, random)
% This function will generate a MIMO channel module whose pointer vector is 
% randomly distrubuted ( in most cases, not in the DFT_AWVs).Each element 
% in the coeff_arr represent a sight(NLOS or LOS)

% coeff_arr---- represent the amplitude of a sight(NLOS or LOS). It MUST be
%               a row vector.
% L----represent the number of sight
% Nr---represent the number of receive antenna element
% Nt---represent the number of transmit antenna element
% random ----- whether the lamda is randomly generated or fixed to 1
% H---- represent the generated channel vector
% pointerU----represent the receive pointer vector in H. Each row represent
%              a pointer vector.
% pointerV----represent the transmit pointer vector in H. Each row
%               represent a pointer vector 
% coeff ----- coeffience generated in the function
% This function is directly copied from instructor xiao
L = length(coeff_arr);
if random
    coeff_arr = (randn(L,1)+1j*randn(L,1)) .* coeff_arr/sqrt(2);
% else
%     coeff_arr = 1;
end
coeff = coeff_arr;
omigatx = cos((rand+(0:L-1)/L)*2*pi);
omigarx = cos((rand+(0:L-1)/L)*2*pi);
% % given the cos angle for verification
% omigatx = -1 + 2*3 /Nt + 0.8/(1*Nt);
% omigarx = -1 + 10*2/Nr + 1/(1*Nr);

H = zeros(Nr,Nt);
recU = zeros(Nr,L);
transV = zeros(Nt,L);
for k=1:L
    u = exp(1j*pi*(0:(Nr-1))'*omigarx(k));
    u = u /sqrt(Nr);
%     u = u /sqrt(u' * u);
    v = exp(1j*pi*(0:(Nt-1))'*omigatx(k));
    v = v /sqrt(Nt);
%     v = v /sqrt(v' * v);
    recU(:,k) =u;
    transV(:,k) =v;
    H = H+coeff_arr(k)*u*v';
end
