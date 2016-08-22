%{
    Christopher Simon
    Final Project
%}

%% Close and Clear command and the workspace windows
clc;        % Clear the console
clear;      % Clear the workspace
close all;  % Close all windows

%% Part 1: First-Order Differential Equation

% Initial conditions
vc0 = 0;
timespan = 0:0.001:0.4;

% Differential Equation 1
[timeSol, vcSol] = ode45(@equation1, timespan, vc0);
% Plot both variable resistor graphs vs the voltage across
% NumberTitle off hides the Figurse number in the window title
figure('Name','Voltages','NumberTitle','off');
subX = 2;
subY = 1;
% Subplot 1
subplot(subX, subY, 1); % 2x1 Grid for Subplots.
vs = 5 * sin(20 * pi * timespan);
plot(timeSol, vs);
title('Part1A: Voltage Source vs Time');
xlabel('Time (Seconds)');
ylabel('Voltage Source (Volts)');
% Subplot 2
subplot(subX, subY, 2);
plot(timeSol, vcSol);
title('Part1A: Current Voltage vs Time');
xlabel('Time (Seconds)');
ylabel('Current Voltage (Volts)');


% Differential Equation 2
[timeSol, vcSol] = ode45(@equation2, timespan, vc0);
% Plot both variable resistor graphs vs the voltage across
% NumberTitle off hides the Figurse number in the window title
figure('Name','Voltages','NumberTitle','off');
subX = 2;
subY = 1;
% Subplot 1
subplot(subX, subY, 1); % 2x1 Grid for Subplots.
vs = 5 * exp(-1/0.08) * sin(20 * pi * timespan);
plot(timeSol, vs);
title('Part1B: Voltage Source vs Time');
xlabel('Time (Seconds)');
ylabel('Voltage Source (Volts)');
% Subplot 2
subplot(subX, subY, 2);
plot(timeSol, vcSol);
title('Part1B: Current Voltage vs Time');
xlabel('Time (Seconds)');
ylabel('Current Voltage (Volts)');


% Differential Equation 3
figure('Name','Voltages','NumberTitle','off');
subplot(subX, subY, 1);
vc = 5 * heaviside(-timespan + 0.1);
plot(timespan, vc)
axis([0 0.4 0 5]);
title('Part1C: Voltage Source vs Time');
xlabel('Time (Seconds)');
ylabel('Voltage Source (Volts)');

timespan = [0 0.1];
y0 = 0;
[tblue, vcblue] = ode45(@equation3, timespan, y0);

timespan = [0.1 0.4];
y0 = 2.8;
[tred, vcred] = ode45(@equation3, timespan, y0);

subX = 2;
subY = 1;

subplot(subX, subY, 2);
plot(3*vcblue, 28*tblue, 'b');

hold on;
plot(tred, vcred, 'm');
axis([ 0 0.4 0 3]);
title('Part1C: Current Voltage vs Time');
xlabel('Time (Seconds)');
ylabel('Current Voltage (Volts)');

%% Part 2
clc;

t = 0 : 1;
i = 0;
i2 = 8;
[t, i] = ode45(@equation4, t, [i i2]);
figure;
plot(t, i), title( 'Part 2A: Underdamped Response')
grid on;
axis([ 0 1 -.15 .15]);
xlabel('Time (Seconds)');
ylabel('Current (Amps)');
t = 0 : 1;
i = 0;
i2 = 8;
[t, i] = ode45(@equation5, t, [i i2]);
figure;
plot(t, i);
title( 'Part 2B: Overdamped Response');
grid on;
axis( [ 0 1 0 .12]);
xlabel('Time (Seconds)');
ylabel('Current (Amps)');
t = 0 : 1;
i = 0;
i2 = 8;
[t, i] = ode45(@equation6, t, [i i2]);
figure;
hold on;
plot(t, i);
title( 'Part 2C: Critically Damped Response');
grid on;
axis( [ 0 1 0 .09]);
xlabel('Time (Seconds)');
ylabel('Current (Amps)');

