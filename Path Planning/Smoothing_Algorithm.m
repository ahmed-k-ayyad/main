%% path smoothing algorithm

original_path = [0,0;0,1;0,2;0,3;0,4;1,4;2,4;3,4;4,4;4,5;4,6];

smooth_path = original_path;
%% gradient descend

alpha = 0.1;    % alpha represents how close the path to the original
beta = 0.1;     % beta represents how close the points to each other (smoother)

tolerance = 0.001; % a breaking condition from gradient descend
change = 1;


while change > tolerance
    
    change = 0;
    
    for i = 2:length(original_path)-1
           
        temp = smooth_path(i,:);
        
        smooth_path(i,:) = smooth_path(i,:) + alpha*(original_path(i,:) - smooth_path(i,:));
        
        smooth_path(i,:) = smooth_path(i,:) + beta*(smooth_path(i+1,:) + smooth_path(i-1,:) - 2 * smooth_path(i,:));
        
        change = change + abs(temp - smooth_path(i,:));
        
    end
end


%% plotting the results

for i = 1:length(original_path)
    plot(original_path(i,2),original_path(i,1),'.r','Markersize',20);
    hold on
end

for i = 1:length(smooth_path)
    plot(smooth_path(i,2),smooth_path(i,1),'.b','Markersize',20);
    hold on
end