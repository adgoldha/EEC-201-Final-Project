function signals = training(dir, n, num_centroids)
	for i = 1 : n
		file = sprintf("%s%d.wav",dir,i)
		signals(i) = signal(file);
		signals(i) = signals(i).processSignal(num_centroids);
		% signals(i).plot_centroids(i);
    end
end