%% NN non linear

clear;clc;close all

x = -10:0.5:10;
y = x.^4+x.^3;

P = x;
T = y;

Hidden_Neurons = input('number of hidden neurons = ');

net = newff(P,T,Hidden_Neurons);

net.divideParam.trainRatio = 1;
net.divideParam.valRatio = 0;
net.divideParam.testRatio = 0;

net.trainParam.epochs = 1000;

net.trainParam.showWindow = 0;

net = train(net,P,T);

x_testing = -10:0.05:10;
y_testing = abs(sin(x_testing)./x_testing);

plot(x,y,'ro',x_testing,net(x_testing))