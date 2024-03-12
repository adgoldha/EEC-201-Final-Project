clear all;
n = 11;
num_centroids = 8;

signals = training(n, num_centroids);

% visualizaiton
% for i = 1 : n
%     signals(i).plot_centroids(i)
% end

m = 8;
for i = 1:m
    % fprintf("Signal %d", i);
    file = sprintf("s%d.wav",i);
    current(i) = signal(file);
    current(i) = current(i).getMFCC();

	min_dist = 10000;
	match = 0;
	for j = 1:n
		dist = disteu(current(i).MFCC, (signals(j).clusters)');
        [rd1,cd1] = size(dist); % used to determine size for groups matrix
        
        % used to have an issue with some of the inputs becoming NAN for MFCC
        est = sum(min(dist,[],2))/rd1; 

        if est < min_dist
            match = j;
            min_dist = est;
        end
		% [rd1,cd1] = size(dist);
    end
    fprintf("Test Signal %d matches with Train Signal %d\n", i, match);
end
