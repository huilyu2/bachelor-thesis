clc
clear all
close all
theta = -pi : .001 * pi : pi - .001*pi;
antenna_N1 = 3;

pattern_N1 = antenna_N1 * 1;
m1 = [0 : antenna_N1-1]';
codebook = DFT_AWVs(antenna_N1);
% codebook = DFT_AWV(antenna_N1);
% codebook = DFT_AWVs_En(antenna_N1);
for x = 1 : pattern_N1
    for i = 1: length(theta)
        tmp1(:,i)= codebook(:,x) .* exp(j * pi .* m1 * cos(theta(i)));
        
    end
    pointer1(x,:) = sum(tmp1);
    [num1,index1] = max(abs(pointer1(x,:)));
%     for i = 1: length(theta)
%         if abs(abs(pointer1(x,i)) - sqrt(2)/2 * num) < 1e-2
%             yyy(x) = i;
%             break
%         end
%     end
    
    yy1(x) = theta(index1)./pi*180;
end

COLOR = {'r', 'b','g', 'c', 'm', 'y', 'k', 'w'};
%     prompt = [color(i),'--'];
% polar(theta, abs(pointer1(1,:)),'r')
% hold on
    
    
% polar(theta, abs(pointer1(3,:)),'g')
% hold on

antenna_N2 = 9;
pattern_N2 = antenna_N2 * 1;
m2 = [0 : antenna_N2-1]';
codebook = DFT_AWVs(antenna_N2);
%codebook = DFT_AWV(antenna_N2);
% codebook = DFT_AWVs_En(antenna_N2);

for x = 1 : pattern_N2
    for i = 1: length(theta)
        tmp2(:,i)= codebook(:,x) .* exp(j * pi .* m2 * cos(theta(i))); 
        
    end
    pointer2(x,:) = sum(tmp2);
    [num2,index2] = max(abs(pointer2(x,:)));
    yy2(x) = theta(index2)./pi*180;
end

% polar(theta, abs(pointer2(5,:)),'r')
% hold on
% polar(theta, abs(pointer2(6,:)),'g')
% hold on
% % polar(theta, abs(pointer2(3,:)),'k')
% % hold on
% 
% polar(theta, abs(pointer1(3,:)),'b')
% hold on

polar(theta, abs(pointer2(4,:)),'r')
hold on
polar(theta, abs(pointer2(5,:)),'g')
hold on
polar(theta, abs(pointer2(6,:)),'k')
hold on
polar(theta, abs(pointer1(2,:)),'b')
hold on


