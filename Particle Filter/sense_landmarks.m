function distances = sense_landmarks (robot,landmarks)

    distances = zeros(1,length(landmarks));
    for i = 1:length(landmarks)
        distances(i) = sqrt((robot.x-landmarks(i,1))^2+(robot.y-landmarks(i,2))^2);
    end
    
    distances = distances + robot.sense_noise * randn(1,length(landmarks))/6;
    
end