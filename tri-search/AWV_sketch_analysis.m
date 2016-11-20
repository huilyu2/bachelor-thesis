%  used for generating the AWV sketch in polar pic
%  this script realizes the AWVs codebook in DFT codebook
clc
clear all
close all
theta = -pi : .001 * pi : pi - .001*pi;
antenna_N1 = 9;

pattern_N1 = antenna_N1 * 1;
m1 = [0 : antenna_N1-1]';
codebook = DFT_AWV(antenna_N1);
% codebook = DFT_AWV(antenna_N1);
% codebook = DFT_AWVs_En(antenna_N1);
for x = 1 : pattern_N1
    for i = 1: length(theta)
        tmp1(:,i)= codebook(:,x) .* exp(j * pi .* m1 * cos(theta(i))); 
        
    end
    pointer1(x,:) = sum(tmp1);
    [num,index] = max(abs(pointer1(x,:)));
%     for i = 1: length(theta)
%         if abs(abs(pointer1(x,i)) - sqrt(2)/2 * num) < 1e-2
%             yyy(x) = i;
%             break
%         end
%     end
    
    yy1(x) = theta(index)./pi*180;
end

antenna_N2 = 12;
pattern_N2 = antenna_N2 * 1;
m2 = [0 : antenna_N2-1]';
codebook = DFT_AWV_En(antenna_N2,1);
% codebook = DFT_AWV(antenna_N2);
% codebook = DFT_AWVs_En(antenna_N2);

for x = 1 : pattern_N2
    for i = 1: length(theta)
        tmp2(:,i)= codebook(:,x) .* exp(j * pi .* m2 * cos(theta(i))); 
        
    end
    pointer2(x,:) = sum(tmp2);
    [num,index] = max(abs(pointer2(x,:)));
    yy2(x) = theta(index)./pi*180;
end


antenna_N3 = 32;
pattern_N3 = antenna_N3 * 1;
m3 = [0 : antenna_N3-1]';
codebook = DFT_AWV_En(antenna_N3,2);
% codebook = DFT_AWV(antenna_N3);
for x = 1 : pattern_N3
    for i = 1: length(theta)
        tmp3(:,i)= codebook(:,x) .* exp(j * pi .* m3 * cos(theta(i))); 
        
    end
    pointer3(x,:) = sum(tmp3);
    [num,index] = max(abs(pointer3(x,:)));
    yy3(x) = theta(index)./pi*180;
end


antenna_N4 = 16;
pattern_N4 = antenna_N4 * 1;
m4 = [0 : antenna_N4-1]';
codebook = DFT_AWV_En(antenna_N4,2);
% codebook = DFT_AWV(antenna_N4);
for x = 1 : pattern_N4
    for i = 1: length(theta)
        tmp4(:,i)= codebook(:,x) .* exp(j * pi .* m4 * cos(theta(i))); 
        
    end
    pointer4(x,:) = sum(tmp4);
    [num,index] = max(abs(pointer4(x,:)));
    yy4(x) = theta(index)./pi*180;
end


% -------------------------- picture zone ---------------------------------
color = 'rbygrbygrbygrbygrbygrbygrbyg';
style = ['-','--','-x','-.'];
% prompt = [color(1),style(1)];
figure
% for i = 1: pattern_N4
% %     prompt = [color(i),'--'];
%     prompt = ['y','-'];
%     polar(theta, abs(pointer4(i,:)),prompt)
%     hold on
% end
% hold on
% for i = 1: pattern_N3
% %     prompt = [color(i),'--'];
%     prompt = ['g','-'];
%     polar(theta, abs(pointer3(i,:)),prompt)
%     hold on
% end
% hold on
for i = 1: pattern_N2
%     prompt = [color(i),'--'];
    prompt = ['b','-'];
    polar(theta, abs(pointer2(i,:)),prompt)
    hold on
end
for i = 1: pattern_N1
%     prompt = [color(i),'--'];
    prompt = ['r','--'];
    polar(theta, abs(pointer1(i,:)),prompt)
    hold on
end
% title(['AWV pointer picture of ',num2str(antenna_N1),' antennas by ',num2str(pattern_N1),' patterns'])






