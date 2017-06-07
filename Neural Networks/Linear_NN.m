%% Simple Linear NN

clear; clc; close all

x = 1:100;
y = 5*x-2;
y = y+20*rand(1,100);
net = newlind(x,y);

a = net(x);

plot(x,y)
hold on
plot(x,a)

net.iw
net.b