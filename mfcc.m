function MFCC = mfcc(y_input, fs_input)
	[S,F,T] = stft(y_input,fs_input,Window=hamming(256,'periodic'),OverlapLength=156,FFTLength=256);
	% mel spectrogram of signal after above processing
	% [Ss,Ff,Tt] = melSpectrogram(obj.y,obj.Fs,Window=hamming(256,'periodic'),OverlapLength=156,FFTLength=256,NumBands=20);
	
	% melfb part
	p = 20;
	n = 256;
	fs = fs_input;

	m = melfb(p,n,fs);
	
	% applying melfb m value
	[rows,cols] = size(S);
	for i = 1:cols
		f = S(:,i);
		n2 = 1 + floor(n/2);
		z = m * abs(f(n2-1:n)).^2;
		if i == 1
			some = [z];
		else
			some = [some z];
		end
	end
	% converting to dB
	some = mag2db(abs(some));

	% dct part
	for i = 1:cols
		f = dct(some(:,i));
		if i == 1
			y = [f(2:end)];
		else
			y = [y f(2:end)];
		end
	end

	MFCC = y;
end