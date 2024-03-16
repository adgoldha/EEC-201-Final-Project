clear all;
n = 47; % Number of training data - naming must match s#.wav
num_centroids = 40; % Parameter to establish the number of centroids 

signals = training(n, num_centroids);

% 2D Visualizaiton of the testing signals
% Plots two sets of MFCC coefficients and centroids of a signal
% for i = 1 : n
%     signals(i).plot_centroids(i)
% end

m = 44; % Number of testing files - naming must match s#.wav
correct = 0;
for i = 1:m
    % fprintf("Signal %d", i);
    file = sprintf("s%d.wav",i);
    current(i) = signal(file);
    current(i) = current(i).getMFCC();

	min_dist = 100000;
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
    if i == match
        correct = correct + 1;
    end
end
accuracy = (correct/m)*100;
fprintf("Accuracy of everything is %.3f%%\n", accuracy);
