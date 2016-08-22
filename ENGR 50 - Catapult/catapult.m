%{
    Christopher Simon
    HW 7: Human Catapult and Trampoline
%}

fprintf('Human Catapult and Trampoline:\n\n');

%% User Input
% The input messages to display when prompting for values from the user
angleMessage      = 'Input the launch angle in degrees: ';
velMessage        = 'Input the initial velocity in meters per second (m/s): ';
wallPosMessage    = 'Input the horizontal distance between the catapult and the wall in meters: ';
wallHeightMessage = 'Input the the height of the wall in meters: ';
trampPosMessage   = 'Input the horizontal distance between the catapult and the trampoline in meters: ';

% Angle of catapult
theta = input(angleMessage);

% Initial Velocity Components
Vi  = input(velMessage);
Vix = Vi*cosd(theta);
Vfx = Vix;
Viy = Vi*sind(theta);

% Acceleration Components
Ax =  0.0;
Ay = -9.8;

% The x position and height of the wall
Xwall = input(wallPosMessage);
Hwall = input(wallHeightMessage);

% The x position of the trampoline
Xtramp = input(trampPosMessage);

% Calculate the min and max x values of the trampoline
trampWidth = 3.0;
xTrampMin  = Xtramp - (trampWidth/2.0);
xTrampMax  = Xtramp + (trampWidth/2.0);

% Calculate the final time
A = -4.9;
B = Viy;
C = 0;
Tfpos = (-B + sqrt((B^2) - 4*A*C)) / (2*A);
Tfneg = (-B - sqrt((B^2) - 4*A*C)) / (2*A);

% Pick the positive root for use as the time,
% as we can only have a positive time value
Tf = posroot(Tfpos, Tfneg);

% Calculate the final x position of the person
Xf = Vfx * Tf;

%% Plot
% Setup the figure for the plot
figure('name', 'Figure 1', 'numbertitle', 'off');

% The interval of time to plot for the functions
t = 0:0.01:Tf;

% The position and time functions according to time
xFunc = Vfx * t;
yFunc = -4.9*t .^ 2 + Viy .* t;

% Plot both the position and the time functions with respect to time
x1 = xFunc;
y1 = yFunc;
x2 = Xwall;
y2 = linspace(0, Hwall, 1000); % Hwall:0.01:1000
x3 = linspace(xTrampMin, xTrampMax);
y3 = 0;
plot(x1,y1,'b',x2,y2,'gs',x3,y3,'go');

title('Human Catapult and Trampoline Simulation');
xlabel('Horizontal Distance in Meters');
ylabel('Vertical Distance in Meters');
legend('Projectile Motion', 'Wall (Rectangle)', 'Trampoline (Ellipse)', 'Location', 'northeast');
grid on;

%% Simulation Results
% Info
fprintf('\n');
fprintf('The wall is %.2f meters away from the catapult.\n', Xwall);
fprintf('The trampoline is %.2f to %.2f meters away from the catapult.\n', xTrampMin, xTrampMax);
fprintf('The person will land %.2f meters away from the catapult.\n', Xf);
fprintf('\n');

%% Conditional Problems
% Hits wall
Thit = Xwall/Vix;
yF = @(t) -4.9*t .^ 2 + Viy .* t;
yAtWall = yF(Thit);
hitsWall = yAtWall <= Hwall;
% Infront or behind wall
wallFront = Xwall < xTrampMin;
wallBack = Xwall > xTrampMax;
% Overshot or undershot the trampoline
overTramp = Xf > xTrampMax;
underTramp = Xf < xTrampMin;

if(wallFront)
    fprintf('The wall is in front of the trampoline!\n');
elseif(wallBack)
    fprintf('The wall is behind the trampoline!\n');
else
    fprintf('The trampoline cannot be placed inside the wall!\n');
end

if(hitsWall)
    fprintf('The person will crash into the wall at %.2f meters high, because the wall is at %.2f meters high!\n', yAtWall, Hwall);
    return;
end

if(underTramp)
    fprintf('The person will fall on the ground before the trampoline!\n');
elseif(overTramp)
    fprintf('The person will fall on the ground after the trampoline!\n');
else
    if(wallFront)
        fprintf('The person will fly over the wall and land on the trampoline!!!\n');
    end
    
    if(wallBack)
        fprintf('The person WILL NOT fly over the wall, but they will still land on the trampoline!!!\n');
    end
end