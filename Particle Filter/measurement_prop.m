function prop = measurement_prop(robot,landmarks,measurement)
% this function calculates the likelyhood of a measurement ot be right

    prop = 1;
    for i = 1:length(landmarks)
        distance = sqrt((robot.x-landmarks(i,1))^2+(robot.y-landmarks(i,2))^2);
        prop = gaussian(distance,robot.sense_noise,measurement(i));
    end

end

function value = gaussian(mu,sigma,x)
% function to calculate the gaussian distance between two points
    value = (1/(sqrt(2*pi*sigma^2)))*exp(-0.5*((x-mu)/sigma)^2);
end