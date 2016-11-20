% This is the script of fig6
clc 
close all
clear all
COLOR = {'r', 'b','g', 'c', 'm', 'y', 'k', 'w'};
LINE = {'-', ':', '-.', '--'};
PATTERN = {'.', 'o', 'x', '+', '*', 's', 'd', 'v', '^', '<', '>', 'p', 'h'};

N = [10:9:75]; % anntena numbers
TSector = 4;
RSector = 4;

% for exhaustive
% searchTime_ex = 4 * N.^2 ;
% semilogy(N,searchTime_ex, 'k-^','linewidth',2.0);
% hold on

% for 3c
Sector = 2;
Nt_sector = TSector;
Nr_sector = RSector;
Nt_beam =  4 * N / Nt_sector;
Nr_beam =  4 * N / Nr_sector;
searchTime_3c = Nt_sector .* Nr_sector + Nt_beam .* Nr_beam;
semilogy(N,searchTime_3c, 'g-o','linewidth',2.0);
hold on

% for ad
% Nr_sector = 1;
% searchTime_ad = Nt_sector .* N + Nr_sector .* N + 2^2;
% semilogy(N,searchTime_ad, 'b-s','linewidth',2.0);
% for li bin
% searchTime_Li = 9 * [log2(N) - 2] + 15;
% semilogy(N,searchTime_Li, 'y-x','linewidth',2.0);
% hold on

%for proposed 
%searchTime_BSL = 4*log2(N);
% searchTime_BSL = 4*log2(N) + 4;
% BSL without threshold
semilogy(N,(4*log2(N)), 'b-s','linewidth',2.0);
% BSL with threshold and BR
%semilogy(N,(2*log2(N)+4), 'm-x','linewidth',2.0);

%Ternary search
semilogy(N,(6*log(N)./log(3)), 'y-d','linewidth',2.0);
hold on

%BSL with threshold and BR
semilogy(N,(2*log2(N)), 'm-x','linewidth',2.0);
hold on


% grid on
xlabel('Number of antenna elements')
ylabel('Searching complexity')
% legend('method of 3c', 'method of ad', 'method of li bin', 'method of proposed','Location','NorthWest');
legend('IEEE 802.15.3c', 'Binary Search','Ternary Search','Binary Search with Threshold setting', 'Location','NorthWest');
title('Comparison of searching complexity')
% %% plot the comparison between 15.3c with proposed algorithom
% figure
% 
% promptCount = 1;
% for Sector = 2:2:8
%     promptCount = promptCount + 1;
%     prompt = [char(COLOR(promptCount)),char(LINE(4)),char(PATTERN(promptCount))];
%     Nt_sector = Sector;
%     Nr_sector = Sector;
%     Nt_beam =  2 * N / Nt_sector;
%     Nr_beam =  2 * N / Nr_sector;
%     searchTime_3c = Nt_sector .* Nr_sector + Nt_beam .* Nr_beam;
%     semilogy(N,searchTime_3c, prompt,'linewidth',2.0);
%     hold on
% end
% semilogy(N,2*(log2(N) + 4), 'r-d','linewidth',2.0);
% 
% xlabel('Number of antenna elements')
% ylabel('Searching complexity')
% legend('Sector number:2', 'Sector number:4',  'Sector number:6', 'Sector number:8', 'Proposed method', 'Location', 'NorthWest');
% 
% %% plot the comparison between 11ad with proposed algorithom
% figure
% Nr_sector = 1;
% promptCount = 1;
% for Sector = 2:2:4
%     promptCount = promptCount + 1;
%     prompt = [char(COLOR(promptCount)),char(LINE(4)),char(PATTERN(promptCount))];
%     Nt_sector = Sector;
% %     Nr_sector = Sector;
%     Nt_beam =  2 * N / Nt_sector;
%     Nr_beam =  2 * N / Nr_sector;
%     searchTime_ad = Nt_sector .* N + Nr_sector .* N + 2^2;
%     semilogy(N,searchTime_ad, prompt,'linewidth',2.0);
%     hold on
% end
% semilogy(N,2*(log2(N) + 4), 'r-d','linewidth',2.0);
% 
% xlabel('Number of antenna elements')
% ylabel('Searching complexity')
% legend('Scheme of 11ad: N^{(1)}=2', 'Scheme of 11ad: N^{(1)}=4', 'Proposed method', 'Location', 'NorthWest');