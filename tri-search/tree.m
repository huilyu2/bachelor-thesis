x=linspace(2,6,500);
y=x*log(27)./log(x);
plot(x,y)
hold on
plot(2,2*log(27)./log(2),'r*')
plot(3,3*log(27)./log(3),'r*')
plot(4,4*log(27)./log(4),'r*')
plot(5,5*log(27)./log(5),'r*')
plot(6,6*log(27)./log(6),'r*')
