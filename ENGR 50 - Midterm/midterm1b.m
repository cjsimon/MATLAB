%Tester
function midterm1b()
    fileName = input('Type in your file>> ', 's') ;
    %user file
    [data, fs] = audioread('test1.wav');
    
    %calculations for the user file
    userMean = mean(data); %mean
    userDeviation = std(data); %std
    userVariance = std(data) .^ 2; %variance
    userPower = mean(data .^ 2); %avgpower
    userMagnitude = mean(abs(data)); %magnitude
    
    for i = 1:3
        %change the file
        if(i == 1)
            file = 'nine.wav';
        end
        if(i == 2)
            file = 'eight.wav';
        end
        if i == 3
            file = 'zero.wav';
        end
		
        %file to compare
        [compareData, Fs] = audioread(file);
		
		%calculations for the file to compare
		meanValue = mean(compareData); %mean
        fprintf('MEAN %f\n', meanValue);
		deviation = std(compareData); %std
		variance = std(compareData) .^ 2; %variance
		power = mean(compareData .^ 2); %avgpower
		magnitude = mean(abs(compareData)); %magnitude
		%mean percents
        meanPercent = meanValue * 0.05;
        meanHigh = meanValue + meanPercent;
        meanLow = meanValue - meanPercent;
        %deviation percents
        deviationPercent = deviation * 0.10;
        deviationHigh = deviation + deviationPercent;
        deviationLow = deviation - deviationPercent;
		%var percents
        varPercent = variance * 0.08;
        varHigh = variance + varPercent;
        varLow = variance - varPercent;
		%power percents
        pPercent = power * 0.08;
        pHigh = power + pPercent;
        pLow = power - pPercent;
		%magnitude percents
        magPercent = magnitude * 0.10;
        magHigh = magnitude + magPercent;
        magLow = magnitude - magPercent;
		
		%are the user file values is within the range of the other file?
		if(userMean < meanHigh && userMean > meanLow && userDeviation < deviationHigh && userDeviation > deviationLow && userVariance < varHigh && userVariance > varLow && userPower < pHigh && userPower > pLow && userMagnitude < magHigh && userMagnitude > magLow)
			
        else
            fprintf('%f\n%f\n%f', userMean, meanLow, meanHigh);
			fprintf('The input file does NOT match %s\n', file);
		end
    end