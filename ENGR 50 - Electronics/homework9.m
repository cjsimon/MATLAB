%{
    Christopher Simon
    HW 9: Wheatstone Bridge and Semiconductor
%}

%% Close and Clear command and the workspace windows
clc;        % Clear the console
clear;      % Clear the workspace
close all;  % Close all windows

%% Part 1: Wheatstone Bridge

% Resistor Values
R1 = 120;     
R2 = 120;
R3 = 250;
R4 = 250;

% The variable resistance value
RV = linspace(0,500);

% Prompt for an input voltage
V = input('Enter a battery voltage from 5 to 20 volts: ');
if(V < 5 || V > 20)
    error('Please enter a value in between 5 and 20!');
end

% Calculate both voltages for the two different variables
Vab1 = V * ( (R2 ./ (RV + R2)) - (R4 ./ (R3 + R4)) ); % Variable Resistor, R1
Vab2 = V * ( (RV ./ (R1 + RV)) - (R4 ./ (R3 + R4)) ); % Variable Resistor, R2

% Plot both variable resistor graphs vs the voltage across
% NumberTitle off hides the Figure number in the window title
figure('Name','Variable Resistance','NumberTitle','off');
subX = 2;
subY = 1;
subplot(subX, subY, 1); % 2x1 Grid for Subplots. Subplot 1
plot(RV, Vab1);
title('Variable R1 vs Voltage across A and B');
xlabel('R1 (Ohms)');
ylabel('vAB (Volts)');

subplot(subX, subY, 2); % 2x1 Grid for Subplots. Subplot 2
plot(RV, Vab2);
title('Variable R2 vs Voltage across A and B');
xlabel('R2 (Ohms)');
ylabel('vAB (Volts)');

%% Part 2: Semiconductor
clc;                  % Clear the console from part 1
Is = 10.^(-12);       % Saturation Current
q = 1.6 .* 10.^(-19); % Elementary Charge Value
k = 1.38 .*10^(-23);  % Boltzmann’s Constant

% Prompt for a voltage drop from the user
Vd = input('Enter a voltage drop from 0.2 and 3.0 volts: ');
if(Vd < 0.2 || Vd > 3.0)
    error('Please enter a value in between 0.2 and 3.0!');
end

% Calculate the current
[Vd, Y] = meshgrid(0:.025:Vd, 290:2:320);
I = Is .* ((exp((q*Vd) ./ (k*Y)) - 1));

% Generate a 3D grid from the given values
figure('Name','Semiconductor','NumberTitle','off');
mesh(Vd, Y, I);
title('Voltage Drop vs Temperature vs Current');
xlabel('Voltage Drop (Volts)');
ylabel('Temperature (Kelvin)');
zlabel('Current (Amps)');
