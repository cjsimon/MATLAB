%Calculations
function midterm1a()
	%print each file's calculations and plot
    %eight
    fileName = 'eight.wav';
    [data, fs] = audioread(fileName); 
    %calculations
    meanValue = mean(data); %mean
    deviation = std(data); %std
    variance = std(data) .^ 2; %variance
    power = mean(data .^ 2); %avgpower
    magnitude = mean(abs(data)); %magnitude
    %plot
    size = length(data);
    x = 1:size;
    y = data;
    subplot(2, 2, 1);
    plot(x, y);
    title('Eight');
    xlabel('index');
    ylabel('frequency');
    %print the data
    fprintf('Eight\n');
    fprintf('%.5f\n', meanValue);
    fprintf('%.5f\n', deviation);
    fprintf('%.5f\n', variance);
    fprintf('%.5f\n', power);
    fprintf('%.5f\n', magnitude);
    fprintf('\n');

	%print each file's calculations and plot
    %nine
    fileName = 'nine.wav';
    [data, fs] = audioread(fileName); 
    %calculations
    meanValue = mean(data); %mean
    deviation = std(data); %std
    variance = std(data) .^ 2; %variance
    power = mean(data .^ 2); %avgpower
    magnitude = mean(abs(data)); %magnitude
    %plot
    size = length(data);
    x = 1:size;
    y = data;
    subplot(2, 2, 2);
    plot(x, y);
    title('Nine');
    xlabel('index');
    ylabel('frequency');
    %print the data
    fprintf('Nine\n');
    fprintf('%.5f\n', meanValue);
    fprintf('%.5f\n', deviation);
    fprintf('%.5f\n', variance);
    fprintf('%.5f\n', power);
    fprintf('%.5f\n', magnitude);
    fprintf('\n');
	
	%print each file's calculations and plot
    %nine
    fileName = 'zero.wav';
    [data, fs] = audioread(fileName); 
    %calculations
    meanValue = mean(data); %mean
    deviation = std(data); %std
    variance = std(data) .^ 2; %variance
    power = mean(data .^ 2); %avgpower
    magnitude = mean(abs(data)); %magnitude
    %plot
    size = length(data);
    x = 1:size;
    y = data;
    subplot(2, 2, 3);
    plot(x, y);
    title('Zero');
    xlabel('index');
    ylabel('frequency');
    %print the data
    fprintf('Zero\n');
    fprintf('%.5f\n', meanValue);
    fprintf('%.5f\n', deviation);
    fprintf('%.5f\n', variance);
    fprintf('%.5f\n', power);
    fprintf('%.5f\n', magnitude);
    
    
    
    