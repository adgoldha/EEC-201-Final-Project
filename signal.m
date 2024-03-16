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
		% end not needed
        
        % Get clusters of the signal
        function obj = processSignal(obj, num_centroids)
			% reading audio and doing framing, overlap, windowing, and fft
			% reading in audio
			try
				[obj.y_in,obj.Fs_in] = audioread(sprintf('%s',obj.file_name));
			catch ME
				sprintf("File %s does not exist, skipping", obj.file_name);
				return;
			end
			% framing/overlap/windowing/fft

			[check,dim] = size(obj.y_in);
			y1 = zeros(check,1);
			if dim > 1
				for i = 1:check
					y1(i,1) = mean(obj.y_in(i,:));
				end
			else
				y1 = obj.y_in;
			end
			obj.y_in = y1;
			
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
			% reading in audio with try exepct in case there are missing files
			[obj.y_in,obj.Fs_in] = audioread(sprintf('%s',obj.file_name));
			ind = find(obj.y_in ~= 0, 1, 'first');
			obj.y_in = obj.y_in(ind:end);
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