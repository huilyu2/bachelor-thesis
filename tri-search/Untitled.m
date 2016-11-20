% this is a script for new method of binary search, which the sector level
% AWVs of search step k can cover the sector level AWVs of next step k+1
% First, We search the sector level codebook whose size is N * N
% Second, beam refining to find the best pair
% RELATED FILES ARE¡¡LISTED BELOW:
% mimo_ch.m
% codebook.m
% simplesearch_v3.m
% DFT_AWV_En.m
% DFT_AWV.m
% beamrefine.m
% Exsearch.m

close all
clear all
clc
% N1 = 64;
% N2 = 64;
N1 = 81;
N2 = 81;
coeff_arr = 1;
% coeff_arr = [1, 0.03]'; % amplitude of LOS and NLOS
coeff_arr = coeff_arr/sqrt(coeff_arr'*coeff_arr); % normalization
IterTimes = 200;
basis_wr = DFT_AWVs(N2);
basis_wt = DFT_AWVs(N1);
gap = 4;
ex_wr = DFT_AWV_En(N2,gap);
ex_wt = DFT_AWV_En(N1,gap);
initial_wt = codebook(N1, 0);
% initial_wt = zeros(N1 ,1);
% initial_wt(1) = 1;
for i = 1: IterTimes
    [H1, g1, h1, coeff1] = mimo_ch(coeff_arr, N1, N2, 0); % establizing the channel

    [SparseIndex1,SparseEnergy1] = simplesearch_v3(N2, H1,initial_wt);
    
    [SparseIndex2,SparseEnergy2] = simplesearch_v3(N1, H1',basis_wr(:,SparseIndex1));

    [BRFIndex1,BRFEnergy1] = beamrefine(N2,H1,basis_wt(:,SparseIndex2),SparseIndex1,gap);
    
    [BRFIndex2,BRFEnergy2] = beamrefine(N1,H1',ex_wr(:,BRFIndex1),SparseIndex2,gap);
    
    SparseEnergyAll(i,:) = [SparseEnergy1, SparseEnergy2];

%     BRFEnergyAll(i,:) = [BRFEnergy1,BRFEnergy2];

    
    SparseConverE(i) = SparseEnergyAll(end);
    
    BRFConverE(i) = BRFEnergy2(end);

    TotalEnergy(i,:) = [SparseEnergy1,SparseEnergy2,BRFEnergy1,BRFEnergy2];
    
    [FinalE1(i),EXIndex1] = Exsearch(basis_wt,basis_wr,initial_wt,H1);
    
    [FinalE2(i),EXIndex2] = Exsearch(ex_wt,ex_wr,initial_wt,H1);
    
%     if SparseConverE(i) ~= BRFConverE(i)
%         disp('wrong')
%         break
%     end
%     
%     if BRFIndex1 ~= EXIndex2(1) || BRFIndex2 ~= EXIndex2(2)
%         disp('!!bad!!')
%         [SparseIndex1,SparseIndex2]
%         EXIndex1
%         [BRFIndex1,BRFIndex2]
%         EXIndex2
%         if EXIndex2(1) ~= 1 && EXIndex2(2) ~= 1
%             break
%         end
% 
%     end
    
%     if SparseIndex1 ~= EXIndex1(1) || SparseIndex2 ~=EXIndex1(2)
%         disp('bad!!')
%         break
%     end
%     if BRFConverE(i) < 0.3
%         disp('!!bad!!')
%         
%         break
%     end
    
end
% [SparseIndex1,SparseEnergy1] = simplesearch_v3(N2, H1,initial_wt);
% [BRFIndex1,BRFEnergy1] = beamrefine(N2,H1,initial_wt,SparseIndex1,gap);
% [SparseIndex2,SparseEnergy2] = simplesearch_v3(N1, H1',ex_wr(:,BRFIndex1));
% [BRFIndex2,BRFEnergy2] = beamrefine(N1,H1',ex_wr(:,BRFIndex1),SparseIndex2,gap);

figure
plot(10*log10(N1*N2*TotalEnergy(1,:)), 'r-x','linewidth',2);
hold on
plot([0:1:20],10*log10(N1*N2*ones(1,21)), 'b-o','linewidth',2);
ylabel('Energy in receiving end / dB')
xlabel('Search steps')
legend('Ternary Fine search', 'Upper bound','Location','SouthEast')
title('Ternary Fine Search Total Received Energy')
grid on

figure
plot(10*log10(N1*N2*SparseEnergyAll(1,:)), 'r-x', 'linewidth',2)
hold on
plot([0:1:12],10*log10(N1*N2*ones(1,13)), 'b-o','linewidth',2);
ylabel('Energy in receiving end / dB')
xlabel('Search steps')
legend('Ternary Coarse search', 'Upper bound','Location','SouthEast')
title('Ternary Coarse Search Total Received Energy')
grid on

figure
plot(10*log10(N1*N2*FinalE1), 'r-x')
hold on 
plot(10*log10(N1*N2*SparseConverE),'b-o')
grid on
ylabel('Convergency Energy in receving end / dB')
xlabel('Simulation times')
legend('Exhaustive search', 'Ternary Coarse search','Location','SouthEast')
title('Search comparison of Ternary Coarse search and Exhaustive search')

figure
plot(10*log10(N1*N2*FinalE2), 'r-x')
hold on 
plot(10*log10(N1*N2*BRFConverE),'b-o')
grid on
ylabel('Convergency Energy in receving end / dB')
xlabel('Simulation times')
legend('Exhaustive search', 'Ternary Fine search','Location','SouthEast')
title('Search comparison of Ternary Fine search and Exhaustive search')