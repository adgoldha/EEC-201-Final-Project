classdef signal
    properties
        file_name
        y_in
		Fs_in
		numCentroids
		clusters
		MFCC

    end
    
    methods
        % Constructor
        function obj = signal(file_input)
            if nargin > 0
                obj.file_name = file_input;
                % obj.property2 = value2;
			% else
			% 	obj.file_name = '';
			end
        end

		% function obj = fileIn(obj, name)
		% 	obj.file_name = name;
		% end
        
        % Get clusters of the signal
        function obj = processSignal(obj, num_centroids)
			% reading audio and doing framing, overlap, windowing, and fft
			% reading in audio
			[obj.y_in,obj.Fs_in] = audioread(sprintf('.\\GivenSpeech_Data\\Training_Data\\%s',obj.file_name));
			% framing/overlap/windowing/fft
			
			obj.MFCC = mfcc(obj.y_in, obj.Fs_in);

			obj.numCentroids = num_centroids;
			[dimensions,frames] = size(obj.MFCC);
			eplison = 0.001;
			% obj.MFCC = y;
			obj.clusters = LBGAlgorithm(obj.numCentroids,dimensions,frames,(obj.MFCC)',eplison);
		end

		% Get clusters of the signal
        function obj = getMFCC(obj)
			% reading audio and doing framing, overlap, windowing, and fft
			% reading in audio
			[obj.y_in,obj.Fs_in] = audioread(sprintf('.\\GivenSpeech_Data\\Test_Data\\%s',obj.file_name));
			% framing/overlap/windowing/fft
			
			obj.MFCC = mfcc(obj.y_in, obj.Fs_in);
		end
		
		% plotting some clusters for visualization
		function plot_centroids(obj, num)
			figure('Name', sprintf("Fig %d",num));
			temp = obj.MFCC;
			hold on 
			scatter(temp(1,:),temp(2,:),'b','o')
			scatter(obj.clusters(:,1),obj.clusters(:,2),'r','x')
			hold off
		end
    end
end