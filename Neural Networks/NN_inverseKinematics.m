%% NN inverse kinematics

clear;clc;close all

l1 = 5;
l2 = 5;

Hidden_Neurons = input('number of hidden neurons (Two layers with equal number of nodes)= ');

pos_x = [];
pos_y = [];
theta1 = [];
theta2 = [];

for i = 0:pi/36:pi/2
    for j = 0:pi/36:pi/2
        
        theta1 = [theta1 i];
        theta2 = [theta2 j];
        
        pos_x = [pos_x,l1*cos(i)+l2*cos(i+j)];
        pos_y = [pos_y,l1*sin(i)+l2*sin(i+j)];
    end
end

plot(pos_x,pos_y,'ro')
hold on

P = [pos_x;pos_y];
T = [theta1;theta2];
net = newff(P,T,[Hidden_Neurons Hidden_Neurons]);

net.divideParam.trainRatio = 1;
net.divideParam.valRatio = 0;
net.divideParam.testRatio = 0;

net.trainParam.epochs = 1000;

net.trainParam.showWindow = 1;

net = train(net,P,T);

%% testing phase

    plot_handler = plot(0,0,'-bo',...
    'LineWidth',2,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor',[1,0,0]);

% while(1)
%     
%     [testing_x,testing_y]=ginput(1);
%         
%     if isempty(testing_x)
%         break;
%     end
%     
%     path_x = [path_x, testing_x];
%     path_y = [path_y, testing_y];
% 
% end

[path_x,path_y] = ginput(2);

plotsX = [path_x(1),path_x(1),path_x(2),path_x(2),path_x(1)];
plotsY = [path_y(1),path_y(2),path_y(2),path_y(1),path_y(1)];

plot(plotsX,plotsY,'--g','linewidth',3)

X = [linspace(path_x(1),path_x(1),100) ...
     linspace(path_x(1),path_x(2),100) ...
     linspace(path_x(2),path_x(2),100) ...
     linspace(path_x(2),path_x(1),100)];

Y = [linspace(path_y(1),path_y(2),100) ...
     linspace(path_y(2),path_y(2),100) ...
     linspace(path_y(2),path_y(1),100) ...
     linspace(path_y(1),path_y(1),100)];
 
while(1) 
for i = 1:length(X)
        
        thetas = net([X(i); Y(i)]);

        x_robot = [0 l1*cos(thetas(1)) l1*cos(thetas(1))+l2*cos(thetas(1)+thetas(2))];
        y_robot = [0 l1*sin(thetas(1)) l1*sin(thetas(1))+l2*sin(thetas(1)+thetas(2))];
    
        set(plot_handler,'xdata',x_robot,'ydata',y_robot)
        drawnow
        pause(0.01)
end
end