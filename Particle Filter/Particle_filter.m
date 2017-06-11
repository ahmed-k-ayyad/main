%% initialize robot, world and landmakrs
clear;clc;

landmarks = [20,20;80,80;80,20;20,80];

world_size = 100;

a = robot_begin;
a = set_robot(a,50,50,0);
a = move_robot(a,0.1,5);
z = sense_landmarks(a,landmarks);
%% try different functions

% a = set_robot(a,50,50,0);
% a = move_robot(a,-pi/2,25);
% d1 = sense_landmarks(a,landmarks)
% a = move_robot(a,-pi/2,10);
% d2 = sense_landmarks(a,landmarks)

%% initialize 1000 particle

N = 1000;
p = [];

for i = 1:N
    x = robot_begin;
    p = [p, x];
end

p_first_run = p;

%% single motion

for i = 1:N
    p(i) = move_robot(p(i),0.1,5);
end

% weights of particles
w = zeros(1,N);
for i = 1:N
    w(i) = measurement_prop(p(i),landmarks,z);
end

% resampling phase
p_resampled = [];
index = round(rand*N);
beta = 0;

m = max(w);

for i = 1:N
    beta = beta + rand * 2 * m;
    while beta > w(index)
        beta = beta - w(index);
        index = index + 1;
        if index == 1001
            index = 1;
        end
    end
    p_resampled = [p_resampled p(index)];
end

% plotting

subplot(1,2,1)
for i = 1:N
    plot(p(i).x,p(i).y,'.r')
    hold on
end

subplot(1,2,2)
for i = 1:N
    plot(p_resampled(i).x,p_resampled(i).y,'.r')
    hold on
    axis([0,100,0,100])
end

%% series of motions

steps = 10;

for s = 1:steps

a = move_robot(a,0,5);
z = sense_landmarks(a,landmarks);
    
for i = 1:N
    p(i) = move_robot(p(i),0,5);
end

% weights of particles
w = zeros(1,N);
for i = 1:N
    w(i) = measurement_prop(p(i),landmarks,z);
end

% resampling phase
p_resampled = [];
index = round(rand*N);
beta = 0;

m = max(w);

for i = 1:N
    beta = beta + rand * 2 * m;
    while beta > w(index)
        beta = beta - w(index);
        index = index + 1;
        if index == 1001
            index = 1;
        end
    end
    p_resampled = [p_resampled p(index)];
end
   
p = p_resampled;
end

subplot(1,2,1)
for i = 1:N
    plot(p_first_run(i).x,p_first_run(i).y,'.r')
    hold on
end

subplot(1,2,2)
for i = 1:N
    plot(p_resampled(i).x,p_resampled(i).y,'.r')
    hold on
    axis([0,100,0,100])
end