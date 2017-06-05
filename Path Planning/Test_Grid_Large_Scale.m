%% Initialize the grid
clc;clear;close all;
load image.mat

imshow(image);

start=ginput(1);
start=fliplr(floor(start));
destination=ginput(1);
destination=fliplr(floor(destination));

grid = double(not(image));

[policy,expand,path] = Astar(start,destination,grid);

newgrid = grid + 0.2*path+0.1*expand;
imshow(newgrid)