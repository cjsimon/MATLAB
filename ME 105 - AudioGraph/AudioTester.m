%{
    Name:       AudioTester
    Desc:       Compares the input file with the calculated wav files from
                AudioGraph and checks for a match using comparison
                techniques.

    Author:     Christopher Simon
    ID:         216711899
    Version:    1.0

    Created:    3/3/2015
    Modified:   3/3/2015
%}
function AudioTester(fileName)
    % Prompt for the input filename if one was not provided as a parameter
    if ~fileName
        fileName = input('Please input the name of the file to test: ', 's');
    end
    fprintf('\n');
    
    % If the file exists
    if exist(fileName, 'file') > 0
        % Read the wav file into a data array
        [audioData, ~] = audioread(fileName);
        % Get the values of the audioData as an array of vars
        audioVars = calculate(audioData);

        % For each calculated wav file (eight, nine, zero) as iteration i
        for i = 1:3
            % Set the current matFile and respective nbLabel
            % to the corresponding values in the case list
            switch i
                case 1
                    matFile = 'eight.mat';
                    nbLabel = 'EIGHT';
                case 2
                    matFile = 'nine.mat';
                    nbLabel = 'NINE';
                case 3
                    matFile = 'zero.mat';
                    nbLabel = 'ZERO';
            end

            % Print the current matFile name
            fprintf('%s\n', matFile);

            % Compare each var from the input audio file to each matFile
            boolean = compare(audioVars, matFile);

            % Print the final conclusion of the current comparision
            % If at least on of the test fails, then that file does NOT match
            if(boolean == true)
                notMessage = 'is';

                % A match was found! Indicate so in the .dat file
                save('voiceReceived.dat', 'nbLabel', '-ascii', '-append');
            else
                notMessage = 'is NOT';
            end

            % Format and print the final conclusion
            message = 'The voice in %s %s %s!\n\n';
            fprintf(message, fileName, notMessage, nbLabel);
        end
    else
        % The file doesn't exits
        errorMessage = 'The file ''%s'' does not exist!\n';
        fprintf(errorMessage, fileName);
    end
        
%{
    Calculate the data from a given array
%}
function audioVars = calculate(audioData)
    % Mean
    me = mean(audioData);
    % Standard Deviation
    de = std(audioData);
    % Variance
    va = std(audioData) .^ 2;
    % Average Power
    ap = mean(audioData .^ 2);
    % Average Magnitude
    am = mean(abs(audioData));
    % Return an array of calculation vars
    audioVars = [me, de, va, ap, am];
    
%{
    Given a value, x, and a percent variance, p,
    Return an array of variance values including
    the original, low and high percent ranges
%}
function range = percent(x, p)
	% Convert percent to decimal number
	p = p/100.0;
    % Get the percent variance or
    % offset of the original value, x
    offset = x*p;
    % Return the range including the
    % original, low, and high offset ranges
    range = [x, (x - offset), (x + offset)];
    
%{
    Compare the values the audio array to the designated matFile
%}
function boolean = compare(audioVars, matFile)
    % For each var in audioVars as iteration i
    for i = 1:length(audioVars)
        % Load the current var from the matFile based on the case list
        % Then calculate the percent offset for each of those vars
        switch i
            case 1
                load(matFile, 'me');
                var = percent(me, 5);
                varLabel = 'Mean';
            case 2
                load(matFile, 'de');
                var = percent(de, 10);
                varLabel = 'Deviation';
            case 3 
                load(matFile, 'va');
                var = percent(va, 8);
                varLabel = 'Variance';
            case 4
                load(matFile, 'ap');
                var = percent(ap, 8);
                varLabel = 'Power';
            case 5
                load(matFile, 'am');
                var = percent(am, 10);
                varLabel = 'Magnitude';
        end
        
        % Get the high and low offsets from the percentage calculation of
        % the current var
        offsetLow = var(2);
        offsetHigh = var(3);
        
        % Is the current audioVars(i) within the range of the two offset values?
        currentVar = audioVars(i);
        boolean = isBetween(currentVar, offsetLow, offsetHigh);
        
        % Modify the message content based on the validity of the statements
        if(boolean == true)
            notMessage = 'is';
        else
            notMessage = 'is NOT';
            boolean = false;
        end
        
        % Print the current var message
        message = '%s: %+2.5f %s within %+2.5f and %+2.5f\n';
        fprintf(message, varLabel, currentVar, notMessage, offsetLow, offsetHigh);
    end

%{
    Check if number, n, is in between two numbers, x and y
%}
function boolean = isBetween(n, x, y)
    % Start comparision based on the biger number
    if(x < y)
        if(n >= x && n <= y)
            boolean = true;
        else
            boolean = false;
        end
    else %(x > y)
        if(n >= y && n <= x)
            boolean = true;
        else
            boolean = false;
        end
    end