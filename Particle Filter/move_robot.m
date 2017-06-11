function robot = move_robot(robot,angle,distance)

    robot.heading = robot.heading + angle + robot.turn_noise * randn/6;
    robot.x = robot.x + distance*cos(robot.heading) + robot.forward_noise * randn/6;
    robot.y = robot.y + distance*sin(robot.heading) + robot.forward_noise * randn/6;
    
    % world is cyclic
    robot.x = mod(robot.x,100);
    robot.y = mod(robot.y,100);
    robot.heading = mod(robot.heading,2*pi);

end