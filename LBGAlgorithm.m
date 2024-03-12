% LBGAlgorithm
function clusters = LBGAlgorithm(numCentroids, dimensions, frames, MFCC, eplison)
    randomPoints = MFCC';
    randomXY = MFCC; % putting random points in [X Y] format
    lengthsplitup = ceil(10/numCentroids); % how to evenly split input data;frames/numC
    startCentroids = zeros(numCentroids,dimensions); % zeros(numCentroids,dimensions)
    j = 0;
    % for loop to give us all the initial centroids we need
    % for i = 1:numCentroids
    %     if i == 1
    %         startCentroids(i,:) = mean(randomXY(i:lengthsplitup,:));
    %     elseif i ~= numCentroids
    %         startCentroids(i,:) = mean(randomXY(j:j+lengthsplitup-1,:));
    %     else
    %         startCentroids(i,:) = mean(randomXY(j:end,:));
    %     end
    %     j = i + lengthsplitup; % iterating j to make sure we mean all data with no repeats
    % end
    killme = (max(randomXY)-min(randomXY))/numCentroids;
    iter = min(randomXY);
    for i = 1:numCentroids
        startCentroids(i,:) = iter;
        iter = iter + killme;
    end
    % end of getting all the centroids we need to start
    Dp = 100000000; % initializing previous distortion as a large number
    %scatter(randomPoints(1,:),randomPoints(2,:),'green','o') % plotting random points
    %hold on
    %scatter(startCentroids(:,1),startCentroids(:,2),'black','x') % plotting initial centroid
    %hold off
    while (1)
        values = disteu((MFCC)',(startCentroids)'); % getting distances
        [rows,cols] = size(values); % used to determine size for groups matrix
        groups = zeros(rows,cols); % defining groups matrix (frames,numC)
        % for loop for grouping
        for i = 1:rows
            holder = min(values(i,:));
            for j = 1:cols
                if values(i,j) == holder
                    groups(i,j) = holder;
                end
            end
        end
        % end of for loop for grouping
        Do = zeros(1,cols); % making distortion matrix (1,numCentroids)
        % for loop for summing minimum distances
        for i = 1:cols
            Do(1,i) = sum(groups(:,i)); % summing each column at a time; 1/(frames)
        end
        % end of for loop for summing minimum distances
        Do = (1/frames)*sum(Do); % summing final rows of each group; this makes Do one value
        stuff = (Dp - Do)/(Do); % distortion comparison equation
        % if else to decide if another loop needs to be done
        if stuff < eplison
            break;
        else
            Dp = Do;
        end
        % end of if else to decide if another loop needs to be done
        % if another loop needs to be done recalculate centroids
        [r,c] = size(groups); % used for loops below
        holderC = zeros(1,dimensions); % (1,dimensions)
        for i = 1:c
            for j = 1:r
                if groups(j,i) == 0 % in case the centroid is on a point
                    % checking to see if centroid is on a point
                    hatethis = randomXY(j,:);
                    if startCentroids(i,:) == hatethis % only entered if centroid is on data point
                        holderC = [holderC; hatethis];
                    end
                else % this if statement gets the original data values
                    hatethis = randomXY(j,:);
                    holderC = [holderC; hatethis];
                end
            end
            holderC = holderC(2:end,:); % getting rid of the initial 0 0 when holderC was defined
            if isempty(holderC) % just in case a centroid has no data points then do not update the centroid
                startCentroids(i,:) = mean(randomXY)*rand(1, 1); % keeps previous centroid the same
            else
                [lastr,lastc] = size(holderC);
                newC = zeros(1,lastc); % (1,dimensions)
                for k = 1:lastc % calculates new centroids; works by doing each column so X then Y then etc
                    newC(1,k) = mean(holderC(:,k)); % sum / number of points in that group
                end
                startCentroids(i,:) = newC; % storing new centroid in place of old one
                holderC = zeros(1,dimensions); % resetting
            end
        end
        % end of recalculating centroids for next loop
    end
    % scatter(randomPoints(1,:),randomPoints(2,:),'b','o')
    % hold on
    % scatter(startCentroids(:,1),startCentroids(:,2),'r','x')
    % hold off

    clusters = startCentroids;
end