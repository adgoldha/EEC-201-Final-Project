function MFCC = mfcc(y_input, fs_input)
	[S,F,T] = stft(y_input,fs_input,Window=hamming(256,'periodic'),OverlapLength=156,FFTLength=256);
	% mel spectrogram of signal after above processing
	% [Ss,Ff,Tt] = melSpectrogram(obj.y,obj.Fs,Window=hamming(256,'periodic'),OverlapLength=156,FFTLength=256,NumBands=20);
	
	% melfb part
	p = 20;
	n = 256;
	fs = fs_input;
	f0 = 700 / fs;
	fn2 = floor(n/2);

	lr = log(1 + 0.5/f0) / (p+1);

	% convert to fft bin numbers with 0 for DC term
	bl = n * (f0 * (exp([0 1 p p+1] * lr) - 1));

	b1 = floor(bl(1)) + 1;
	b2 = ceil(bl(2));
	b3 = floor(bl(3));
	b4 = min(fn2, ceil(bl(4))) - 1;

	pf = log(1 + (b1:b4)/n/f0) / lr;
	fp = floor(pf);
	pm = pf - fp;

	r = [fp(b2:b4) 1+fp(1:b3)];
	c = [b2:b4 1:b3] + 1;
	v = 2 * [1-pm(b2:b4) pm(1:b3)];

	m = sparse(r, c, v, p, 1+fn2);
	
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