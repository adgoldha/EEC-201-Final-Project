clear all;
n = 47; % Number of training data - naming must match s#.wav
num_centroids = 40; % Parameter to establish the number of centroids 

% Change the dir depending on where the input files are for training
dir = ".\\GivenSpeech_Data\\Training_Data\\s";
signals = training(dir, n, num_centroids);

% 2D Visualizaiton of the testing signals
% Plots two sets of MFCC coefficients and centroids of a signal
% for i = 1 : n
%     signals(i).plot_centroids(i)
% end

m = 44; % Number of testing files - naming must match s#.wav
correct = 0;

% Change the dir depending on where the input files are for testing
dir = ".\\GivenSpeech_Data\\Test_Data\\s";
for i = 1:m
    file = sprintf("%s%d.wav",dir,i);
    current(i) = signal(file); % Initialize a new signal object with a new input file
    current(i) = current(i).getMFCC(); % Get the MFCC coefficients of the object

	min_dist = 100000;
	match = 0;
	for j = 1:n
        % Calculate the Euclidian distance between the test signal samples
        % and the training signal centroids
		dist = disteu(current(i).MFCC, (signals(j).clusters)');
        [rd1,cd1] = size(dist); % used to determine size for groups matrix
        
        % Get the average of the minimum values of all the rows
        % Minimum distances between a sample and a centroid
        est(i,j) = sum(min(dist,[],2))/rd1; 
        
        % Compare to see if a better estimate has been found
        if est(i,j) < min_dist
            match = j;
            min_dist = est(i,j);
        end
    end
    fprintf("Test Signal %d matches with Train Signal %d\n", i, match);
    if i == match
        correct = correct + 1;
    end
end
accuracy = (correct/m)*100;
fprintf("Accuracy of everything is %.3f%%\n", accuracy);
