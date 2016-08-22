function midterm1a()
    for i = 1:3
        switch i
            case 1
                fileName = 'sounds/3.wav';
                nbLabel = '3';
            case 2
                fileName = 'sounds/4.wav';
                nbLabel = '4';
            case 3
                fileName = 'sounds/5.wav';
                nbLabel = '5';
        end
        [audioData, ~] = audioread(fileName);
        
        calculate(nbLabel, audioData);
        fprintf('\n');
        
        [receiveVoiceData, ~] = audioread('receiveVoice.wav');
        

        figure(i)
        x = 1:length(audioData);
        y = audioData;
        subplot(2, 1, 1);
        plot(x, y);
        title(sprintf('Utterance of %s', nbLabel));
        xlabel('Index');
        ylabel('Frequency');
       

        x = 1:length(receiveVoiceData);
        y = receiveVoiceData;
        subplot(2, 1, 2);
        plot(x, y);
        title('Utterance of the Receive Voice');
        xlabel('Index');
        ylabel('Frequency');
    end
    
function calculate(nb, audioData)
    me = mean(audioData);
    de = std(audioData);
    va = std(audioData) .^ 2;
    am = mean(abs(audioData));
    zc = zeroCrossings(audioData);
    
    matFile = sprintf('%s.mat', nb);
    save(matFile);

    print(nb, me, de, va, am, zc);
        
function print(nb, me, de, va, am, zc)
    uText = 'Acceptance criteria for the word %s\n';
    mText = 'Mean:        %+02.5f\n';
    dText = 'Deviation:   %+02.5f\n';
    vText = 'Variance:    %+02.5f\n';
    zText = 'Zero:        %+02.5f\n';
    gText = 'Magnitude:   %+02.5f\n';
    
    fh = fopen('voiceSignature.txt', 'a+');
    for i = [fh, 1]
        fprintf(i, uText, nb);
        fprintf(i, mText, me);
        fprintf(i, dText, de);
        fprintf(i, vText, va);
        fprintf(i, gText, am);
        fprintf(i, zText, zc);
    end
    
function count = zeroCrossings(x)
    % From: http://www.dsprelated.com/showcode/179.php
    % initial value
    count = 0;

    % error checks
    if(length(x) == 1)
        error('ERROR: input signal must have more than one element');
    end

    if((size(x, 2) ~= 1) && (size(x, 1) ~= 1))
        error('ERROR: Input must be one-dimensional');
    end

    % force signal to be a vector oriented in the same direction
    x = x(:);

    num_samples = length(x);
    for i=2:num_samples
        % Any time you multiply to adjacent values that have a sign difference
        % the result will always be negative.  When the signs are identical,
        % the product will always be positive.
        if((x(i) * x(i-1)) < 0)
            count = count + 1;
        end 
    end