function [policy1D,expand,path] = Astar (Start,Goal,Grid)


    delta = [0,-1;1,0;0,1;-1,0];            % available 4 motions
    delta_actions = ['<','v','>','^'];      % symbols of the 4 motions
    
    closed = zeros(size(Grid));
    actions = zeros(size(Grid));
    expand = -1*ones(size(Grid));
    closed(Start(1),Start(2)) = 1;
    count = 0;
    
    x = Start(1);
    y = Start(2);
    g = 0;
    h = (abs(x-Goal(1)) + abs(y-Goal(1)));
    f = g+h;
    
    open = [x;y;g;h;f];
    
    found = false;
    resign = false;
    
    while (found == 0) && (resign == 0)
        
        if isempty(open)
            resign = true;
            disp('fail')
            
        else
            
            [~,minF] = min(open(5,:));  % find minimum f
            next = open(:,minF);
            open(:,minF) = [];          % remove node from list 
            
            x = next(1);
            y = next(2);
            g = next(3);

            expand(x,y) = count;
            count = count + 1;

            if (x == Goal(1) && y == Goal(2))
                found = true;
                disp(next)
                disp('success')
                
            else                        % main A* code
                % expand the element
                for i = 1:4
                   x2 = x + delta(i,1);
                   y2 = y + delta(i,2);
                   
                   if (x2 >= 1  && x2 <= length(Grid) && y2 >=1 && y2 <=length(Grid))
                       if (closed(x2,y2) == 0 && Grid(x2,y2) ~= 1)
                           g2 = g + 1;
                           h2 = (abs(x2-Goal(1)) + abs(y2-Goal(1)));
                           f2 = g2 + h2; 
                           new = [x2;y2;g2;h2;f2];
                           open = [open, new];
                           %disp(open)
                           closed (x2,y2) = 1;
                           actions(x2,y2) = i;
                       end
                   end
                    
                end
                
            end
            
            
        end
        
        
    end
    policy = cell(size(Grid));
    path = zeros(size(Grid));
    
    x = Goal(1);
    y = Goal(2);
    policy(x,y) = {'*'};
    path(x,y) = 1;
    motion = 0;
    while x ~= Start(1) || y ~= Start(2)
        
        x2 = x - delta(actions(x,y),1);
        y2 = y - delta(actions(x,y),2);

        policy(x2,y2) = {delta_actions(actions(x,y))};
        path(x2,y2) = 1;
        motion = [actions(x,y),motion];
        x = x2;
        y = y2;
        
    end
    %disp(expand)
    disp(policy)
    %disp(motion)
    policy1D = cell(1,length(motion)-1);
    
    for i = 1:length(motion)-1
        if motion(i+1) ~=0
            if motion(i) == motion(i+1)
                policy1D(i) = {'F'};
            elseif motion(i) < motion(i+1)
                policy1D(i) = {'L'};
            elseif motion(i) > motion(i+1)
                policy1D(i) = {'R'};
            end
        else
            policy1D(i) = {'F'};
        end
    end
    disp(policy1D)
    expand = expand > -1;
end