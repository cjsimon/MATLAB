function audio()
    % The filename of the audio file
    fileName = 'yourfile.mp3';
    % Get info about the audio file
    info = audioinfo(fileName);
    
    % Read the audio file
    hfr = dsp.AudioFileReader(fileName);
    % Play the audio file
    hplay = dsp.AudioPlayer('SampleRate', info.SampleRate);
    while ~isDone(hfr)
        audio = step(hfr);
        step(hplay, audio);
    end