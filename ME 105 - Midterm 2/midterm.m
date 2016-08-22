%{
    Simulink Driver
%}
fprintf('Bungee Jump Simulation:\n\n');

%% Calculations
% Run the simulink program and load the data associated with it
sim('bungeeSimulink.slx');
load('simulinkFile.mat');

% Get the time, acceleration, velocity and distance 
t = simulinkCalculation(1, :);
a = simulinkCalculation(2, :);
v = simulinkCalculation(3, :);
x = simulinkCalculation(4, :);

% Get the peak values of acceleration, velocity and distance
peakA = max(abs(a));
peakV = max(abs(v));
peakD = max(abs(x));

% Print the peak values
fprintf('Q: What are the peak values of acceleration, velocity, and distance?\n');
fprintf('A: \n');
fprintf('Peak Acceleration: %0.2fm/s/s\n', peakA);
fprintf('Peak Velocity:     %0.2fm/s\n',   peakV);
fprintf('Peak Distance:     %0.2fm\n\n',   peakD);

% Check if the acceleration is higher than 2g's of force
if peakA <= 2 * 9.806
    % Acceleration is higher
    gStatus = 'higher';
else
    % Acceleration is lower
    gStatus = 'lower';
end
fprintf('Q: Is the estimate of the peak acceleration higher or lower than 2g''s of force?\n');
% Print the message with the according to the gStatus
fprintf('A: The peak acceleration is %s than 2g''s of force.\n\n', gStatus);

% Get the terminal velocity
terminalVelocity = (55 - peakV);
fprintf('Q: How close does the jumper come to reaching the estimated terminal velocity of 55m/sec?\n');
fprintf('A: %0.2f m/s\n\n', terminalVelocity);

% The peak distance is the furthest fall point
fprintf('Q: How far does the jumper initially fall before he starts back up?\n');
fprintf('A: The jumper falls %0.2fm before he starts up.\n\n', peakD);

% Get the time at the peak distance
fprintf('Q: How many seconds does he initially fall before he starts back up?\n');
k = find(x == peakD);
seconds = t(k);
fprintf('A: The jumper falls for %.02fs before he starts back up.\n\n', seconds);

% Get the minimum altitude
minAltitude = 4.* peakD;
fprintf('Q: How high should the company advertise to be the minimum altitude to jump with this new bungee core to ensure a safety factor of 2?\n');
fprintf('A: The minimum height the company should advertise to ensure a safety factor of 2 is %.2fm.\n\n', minAltitude);

% Get the final length of the bungee
% Break down the function into 0.01 intervals
timeStep = stepinfo(t, x, 'SettlingTimeThreshold', 0.01);
% Get the time value at 1
fprintf('Q: At the end of the 400 seconds simulation, what is the final length of the bungee core?\n');
finalTime = find(t <= (timeStep.SettlingTime .* 1.01) & t >= (timeStep.SettlingTime .* 0.99), 1);
finalLength = x(finalTime);
fprintf('A: The final length of the bungee core is %0.2fm.\n\n', finalLength);

%% Simulink Solution Plots
figure('name', 'Simulink vs ODE45', 'numbertitle', 'off')
subplot(3, 2, 1);
plot(t, x);
title('Distance of Simulink')
xlabel('Time');
ylabel('Distance');
grid;

% Velocity
subplot(3, 2, 3)
plot(t, v)
title('Velocity of Simulink')
xlabel('Time')
ylabel('Velocity')
grid

% Acceleration
subplot(3, 2, 5)
plot(t, a)
title('Acceleration of Simulink')
xlabel('Time')
ylabel('Acceleration')
grid

%% ODE45 Solution Plots
% Integrate for the interval beginning at 0 seconds to find the
% acceleration, velocity, and distance as a function of time
% from the beginning of the jump to the end (0:400 seconds)
% x(:, 1) is the first integral, which gives velocity, dx
% x(:, 2) is the second integral, which gives distance, x
% @integration calls the integration function from the integration.m file
[t, x] = ode45(@integration, 0:0.01:400, [0 0]);
vODE45 = x(:, 1);
dODE45 = x(:, 2);

% Velocity
subplot(3, 2, 4);
plot(t, vODE45);
title('Velocity of ODE45');
xlabel('Time');
ylabel('Velocity');
grid;

% Distance
subplot(3, 2, 2);
plot(t, dODE45);
title('Distance of ODE45');
xlabel('Time');
ylabel('Distance');
grid;

% Acceleration
% Calculate the corresponding acceleration function according to the distance
aODE45 = (1:length(x));
for interval = 1:length(x)
   if x(interval, 2) <= 100
       aODE45(interval) = (784.48 - 0.2502 .* (x(interval, 1) .^ 2)) ./ 80;
   else
       aODE45(interval) = (784.48 - 0.2502 .* (x(interval, 1) .^ 2) - 10 .* (x(interval, 2) - 100) - 1.5 .* x(interval, 1)) / 80;
   end
end
subplot(3, 2, 6);
plot(t, aODE45);
title('Acceleration of ODE45');
xlabel('Time');
ylabel('Acceleration');
grid;