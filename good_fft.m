function [frequencies, one_sided] = good_fft(signal,sample_interval,sample_rate)
    signal = signal - mean(signal);
    Y = fft(signal);
    two_sided = abs(Y/sample_interval);
    one_sided = two_sided(1:end/2);
    one_sided = one_sided./max(one_sided);
    frequencies = linspace(0,sample_rate/2,length(one_sided));
end