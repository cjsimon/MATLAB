function midterm1b()
    fprintf('Voice Recognition Program\n\n');
    while true 
        fileName = input('Input a voice file name (or press q to quit): ', 's');
        if fileName == 'q'
            fprintf('Goodbye!\n\n')
            break;
        else
            if exist(fileName, 'file') > 0
                copyfile(fileName, 'receiveVoice.wav')
                [audioData, ~] = audioread('receiveVoice.wav');
                sound(audioData);

                audioVars = calculate(audioData);

                for i = 1:3
                    switch i
                        case 1
                            matFile = '3.mat';
                            nbLabel = 'THREE';
                            bounds = [0.001, 0.008, 0.0015, 0.006, 35];
                            boolean = compare(audioVars, matFile, bounds);
                        case 2
                            matFile = '4.mat';
                            nbLabel = 'FOUR';
                            bounds = [0.001, 0.004, 0.001, 0.003, 80];
                            boolean = compare(audioVars, matFile, bounds);
                        case 3
                            matFile = '5.mat';
                            nbLabel = 'FIVE';
                            bounds = [0.001, 0.015, 0.0015, 0.015, 35];
                            boolean = compare(audioVars, matFile, bounds);
                    end

                    if(boolean == true)
                        fprintf(sprintf('The voice says %s!\n\n', nbLabel));
                        save('voiceCommand.dat', 'nbLabel', '-ascii', '-append');
                        break;
                    else
                        if i == 3
                            fprintf('The voice is not 3, 4, nor 5\n\n');
                        end
                    end
                end
            else
                % The file doesn't exits
                errorMessage = 'The file ''%s'' does not exist!\n\n';
                fprintf(errorMessage, fileName);
                continue;
            end
        end
    end
    
function audioVars = calculate(audioData)
    me = mean(audioData);
    de = std(audioData);
    va = std(audioData) .^ 2;
    am = mean(abs(audioData));
    zc = zeroCrossings(audioData);
    audioVars = [me, de, va, am, zc];
    
function range = percent(x, offset)
    range = [x, (x - offset), (x + offset)];
    
function boolean = compare(audioVars, matFile, bounds)
    for i = 1:length(audioVars)
        switch i
            case 1
                load(matFile, 'me');
                var = percent(me, bounds(i));
            case 2
                load(matFile, 'de');
                var = percent(de, bounds(i));
            case 3 
                load(matFile, 'va');
                var = percent(va, bounds(i));
            case 4
                load(matFile, 'am');
                var = percent(am, bounds(i));
            case 5
                load(matFile, 'zc');
                var = percent(zc, bounds(i));
        end
        
        offsetLow = var(2);
        offsetHigh = var(3);
        
        currentVar = audioVars(i);
        boolean = isBetween(currentVar, offsetLow, offsetHigh);
    end

function boolean = isBetween(n, x, y)
    if(x < y)
        if(n >= x && n <= y)
            boolean = true;
        else
            boolean = false;
        end
    else
        if(n >= y && n <= x)
            boolean = true;
        else
            boolean = false;
        end
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