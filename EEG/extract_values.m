function info = extract_values(infoFileName)
    fid = fopen(infoFileName, 'rt');
    % initalize the structure
    info = struct();
    % read important lines of .info
    for i = 1:4
        line = fgetl(fid);
        C = textscan(line, 'Sampling frequency: %f Hz  Sampling interval: %f sec', 'Delimiter', ':');
    end
    % read the lines which contain Sampling frequency y Sampling interval
    line = fgetl(fid);
    info.SamplingFrequency = C{1};
    info.SamplingInterval = C{2};
    % read the lines which contain Gain y Base para cada señal
    info.Signals = struct();
    for i = 1:22
        line = fgetl(fid);
        C = textscan(line, '%d %s %f %f %s', 'Delimiter', '\t');
        signalName = C{2}{1};
        info.Signals(i).Name = signalName;
        info.Signals(i).Gain = C{3};
        info.Signals(i).Base = C{4};
    end
    
    fclose(fid);
end
