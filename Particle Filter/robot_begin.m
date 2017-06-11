function robot = robot_begin

f1 = 'x';
f2 = 'y';
f3 = 'heading';
f4 = 'forward_noise';
f5 = 'turn_noise';
f6 = 'sense_noise';

v1 = rand * 100;
v2 = rand * 100;
v3 = rand * 2 * pi;

robot = struct(f1,v1,f2,v2,f3,v3,f4,5,f5,0.1,f6,5);

end