load('r01_edfm.mat')

info = extract_values('r01_edfm.info')

gain = info.Signals(1).Gain;
base = info.Signals(1).Base;

direct_1 = info.Signals(1).Name
abdm_1 = info.Signals(2).Name
abdm_2 = info.Signals(3).Name
abdm_3 = info.Signals(4).Name
abdm_4 = info.Signals(5).Name
edf = info.Signals(6).Name

title_matriz = [direct_1,abdm_1,abdm_2,abdm_3,abdm_4,edf]

sample_interval = info.SamplingInterval; % ms
sample_rate = info.SamplingFrequency; % Hz

time_unit = "Time (s)"
unit_e = "Voltage (uV)"

figure(1)

titleText = ['ECG, Sampling Freq: ', num2str(sample_rate), ' Hz, Sampling Interval: ', num2str(sample_interval), ' sec'];
sgtitle(titleText);

for i=1:6
    if i ~= 6
        subplot(6, 1, i)
        plot(val(i,:)./gain - base) 
        xlabel(time_unit)
        ylabel(unit_e)
        title(title_matriz(i))
    else
        gain = info.Signals(i).Gain;
        base = info.Signals(i).Base;
        subplot(6, 1, i)
        plot(val(i,:)./gain - base)
        title(edf)
        xlabel(time_unit)
        ylabel("Annotation (nd)")
    end
end


%% Fourier
figure(2)
sgtitle("ECG-FFT")

n_amplitude = "Normalized Amplitude [a.u.]"
t_frecuency = "Frequency [Hz]"


for i=1:6
    if i ~= 6
        subplot(6, 1, i)
        [freq, one_s] = good_fft(val(i,:),sample_interval,sample_rate);
        plot(freq, one_s)
        ylabel(n_amplitude);
        xlabel(t_frecuency);
        xlim ([0, 200])
        title(title_matriz(i))
    else
        subplot(6, 1, i)
        [freq, one_s] = good_fft(val(i,:),sample_interval,sample_rate);
        plot(freq, one_s)
        title(edf)
        ylabel(n_amplitude);
        xlabel(t_frecuency);
        xlim ([0, 200])
    end
end
