%{
    Christopher Simon
    HW 8: Kirchhoff's Law
%}

%% Clear command and the workspace windows
clc;
clear;

%% Voltage and Resistor values
v = [30; 5; -25];
r = [
    11 -3  0;
    -3  6 -1;
     0 -1  3
    ];

%% Calculations
% Calculate the current using right division on the matrix
i = r \ v;

% Get each of the loop currents from the matrix
i1 = i(1);
i2 = i(2);
i3 = i(3);
fprintf('The current in loop 1 is %.2f amps\n', i1);
fprintf('The current in loop 2 is %.2f amps\n', i2);
fprintf('The current in loop 3 is %.2f amps\n\n', i3);

% Calculate the average current
iAvg = mean(i);
fprintf('The average current is %.2f amps\n\n', iAvg);

% Calculate the equivalent resistance using left division on the matrix
eqRes = v / iAvg;
fprintf('The equivalent resistance for loop 1 is %.2f ohms\n', eqRes(1));
fprintf('The equivalent resistance for loop 2 is %.2f ohms\n', eqRes(2));
fprintf('The equivalent resistance for loop 3 is %.2f ohms\n', eqRes(3));
