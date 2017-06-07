%% New Competitive Network

clear; clc; close all;
P = [];
s = 1;


nodes = input('number of classes = ');

figure
hold on

while s
    

    
    axis([0 10 0 10])
    [x,y] = ginput(1);
    if isempty(x)
        break
    end
    
    plot(x,y,'x','markersize',10);
    P_new = [x;y];
    P = [P P_new];
end

pause(2)
%%
T = ind2vec([1 1 1 1 1 1 2 2 2]);

net = newlvq(P,3,[0.333 1-0.333]);  

net.trainParam.epochs = 1000;
net.trainParam.showWindow = 0;
net = train(net,P,T);
initial_points = net.IW{1};
%plot_handler = plot(initial_points(:,1),initial_points(:,2),'ro');

pause(0.1)
% 
% for i = 1:100
%     
%     net = train(net,P);
%     new_points = net.IW{1};
%     
%     set(plot_handler,'xdata',new_points(:,1),'ydata',new_points(:,2))
%     
%     drawnow
%     pause(0.1)
% end