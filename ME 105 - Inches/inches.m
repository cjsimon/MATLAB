%% sum
E = sum(V);

%% calling the user defined motion function
clc % Clear Screen
clear % Clear Variables
start = 1; % start value
increment = 2; % increment
lines = 3; % number of lines
last = (increment .*lines)-(increment*1)+ start; % last value
in = start:increment:last;
x = in;
y = (2.54) .*x;
z = [x;y];
fprintf('%10.2f%10.2f\n', z)