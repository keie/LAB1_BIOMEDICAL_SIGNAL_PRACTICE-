load('r01_edfm.mat')

info = extract_values('r01_edfm.info')

sample_interval = info.SamplingInterval; % ms
sample_rate = info.SamplingFrequency; % Hz

time_unit = "Time (s)"
unit_e = "Voltage (uV)"

figure(1)

titleText = ['ECG, Sampling Freq: ', num2str(sample_rate), ' Hz, Sampling Interval: ', num2str(sample_interval), ' sec'];
sgtitle(titleText);

for i=1:6
    subplot(6, 1, i)
    plot(val(i,:)./info.Signals(i).Gain - info.Signals(i).Base) 
    xlabel(time_unit)
    ylabel(unit_e)
    title(info.Signals(i).Name)
 end


%% Fourier
figure(2)
sgtitle("ECG-FFT")

n_amplitude = "Norm Amp [a.u.]"
t_frecuency = "Freq [Hz]"


for i=1:6
    subplot(6, 1, i)
    [freq, one_s] = good_fft(val(i,:),sample_interval,sample_rate);
    plot(freq, one_s)
    ylabel(n_amplitude);
    xlabel(t_frecuency);
    xlim ([0, 200])
    title(info.Signals(i).Name)
 end
