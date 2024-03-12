n = 11;
num_centroids = 8;

signals = training(n, 8);

% visualizaiton
% for i = 1 : n
%     signals(i).plot_centroids(i)
% end

m = 8;
for i = 1 : m
    % fprintf("Signal %d", i);
    file = sprintf("s%d.wav",i);
    current = signal(file);
    current = current.getMFCC();

	min_dist = 10000;
	match = 0;
	for j = 1:n
		dist = disteu(current.MFCC, (signals(j).clusters)');
        [rd1,cd1] = size(dist); % used to determine size for groups matrix
        group = zeros(rd1,cd1); % defining groups matrix (frames,numC)
        % for loop for grouping
        for k = 1:rd1
            holder = min(dist(k,:));
            for l = 1:cd1
                if dist(k,l) == holder
                    group(k,l) = holder;
                end
            end
        end
        % end of for loop for grouping
        avg = zeros(1,cd1); % making distortion matrix (1,numCentroids)
        % for loop for summing minimum distances
        for k = 1:cd1
            avg(1,k) = sum(group(:,k)); % summing each column at a time; 1/(frames)
        end
        % end of for loop for summing minimum distances
        est = (1/129)*sum(avg); % summing final rows of each group; this makes Do one value
        if est < min_dist
            match = j;
            min_dist = est;
        end
		% [rd1,cd1] = size(dist);
    end
    fprintf("Test Signal %d matches with Train Signal %d\n", i, match);
end