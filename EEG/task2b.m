load('Subject00_1_edfm.mat')

info = extract_values('Subject00_1_edfm.info');

sample_interval = info.SamplingInterval; % ms
sample_rate = info.SamplingFrequency; % Hz

time_unit = "T s";
unit_e = "volt uV";

unit_e2 = "Volt mV";

unit_e3 = "nd";

figure(1)
set(gcf, 'Position', [100, 100, 1000, 800])  % [left, bottom, width, height]

font_size = 8;  

titleText = ['EEG, Sampling Freq: ', num2str(sample_rate), ' Hz, Sampling Interval: ', num2str(sample_interval), ' sec'];
sgtitle(titleText);

for i = 1:22
    subplot(22, 1, i)
    plot(val(i, :) ./ info.Signals(i).Gain - info.Signals(i).Base)
    xlabel(time_unit, 'FontSize', font_size)  
    ylabel(unit_e, 'FontSize', font_size)  
    title(info.Signals(i).Name, 'FontSize', font_size) 
    
    if i == 21
        ylabel(unit_e2, 'FontSize', font_size)  
    end
    
    if i == 22
        ylabel(unit_e3, 'FontSize', font_size)  
    end
    
end


%% Fourier
figure(2)
sgtitle("ECG-FFT")

n_amplitude = "Norm Amp [a.u.]"
t_frecuency = "Freq [Hz]"


for i=1:22
    subplot(22, 1, i)
    [freq, one_s] = good_fft(val(i,:),sample_interval,sample_rate);
    plot(freq, one_s)
    title(info.Signals(i).Name)
    ylabel(n_amplitude);
    xlabel(t_frecuency);
    xlim ([0, 200])
end