function tf = transformada_fourier(signal)
    Y = fft(signal);
    P2 = abs(Y/length(signal));
    tf = P2(1:length(signal)/2+1); % Single-sided spectrum
    tf(2:end-1) = 2*tf(2:end-1);
     