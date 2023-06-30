%%
clc,clear,close all

% Step 1: Load the arrow figure
arrowImg = imread('seta2.png');

% Step 2: Create a figure and axes
figure;
axes('XLim', [-10 10], 'YLim', [-10 10]);

% Step 3: Define the circle's center and radius
xc = 0;
yc = 0;
r = 5;

% Step 4: Set up a time vector
t = linspace(0, 10, 100);
dt = t(2) - t(1);

% Step 5: Calculate the arrow's position and heading angle
for i = 1:length(t)
    theta = 2*pi*t(i);  % Adjust this line for desired rotation speed
    
    % Calculate the arrow's position
    x = xc + r*cos(theta);
    y = yc + r*sin(theta);
    
    % Calculate the adjusted heading angle
    adjustedArrow = imrotate(arrowImg, rad2deg(theta));
    
    % Step 6: Update the plot
    imshow(adjustedArrow, 'XData', [x-1 x+1], 'YData', [y-1 y+1]);
    hold on;
    plot(x, y, 'ro');  % Plot the circle's center
    hold off;
    
    pause(dt);
end

