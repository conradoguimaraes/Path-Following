%%
clc,clear,close all

% Read in car image
setaFile = 'seta2.png';   
[arrowImg,~, transparency] = imread(setaFile);

% carImg = imagesc([10], [10], arrowImg, 'AlphaData', transparency);


% x = linspace(-7,7,50);
t = 0:0.01:10;

delta = pi/2;
a = 1
A = 50;
C = 50;
x = A*sin(a*t + delta) + C;

b = 1
B = 50;
D = 50;
y = B*sin(b*t) + D;

carX = x;
carY = y;

fig = figure(); hold on;
fig.Resize = 'off';
movegui(fig)
XYoffset = 5
ax = axes(fig,'XLim', [min(x)-XYoffset,max(x)+XYoffset], 'YLim', [min(y)-XYoffset,max(y)+XYoffset]); 
hold(ax,'on')
traj = plot(carX, carY, '-b', 'LineWidth', 1);
drawnow()




r = 50;
xc = 50;
yc = 50;

% Step 4: Set up a time vector
t = linspace(0, 1, 100);
% Step 5: Calculate the arrow's position and heading angle
for i = 1:length(t)
    theta = 2*pi*t(i);  % Adjust this line for desired rotation speed
    
    % Calculate the arrow's position
    x = xc + r*cos(theta);
    y = yc + r*sin(theta);
    
    % Calculate the adjusted heading angle
%     adjustedArrow = imrotate(arrowImg, rad2deg(theta),'bilinear','loose');
    adjustedArrow = imrotate_white(arrowImg, rad2deg(theta));
    imwrite(adjustedArrow,'invisible.png','Alpha',1-double(all(adjustedArrow == 255, 3)))

%     carImg = imagesc(adjustedArrow,'AlphaData', transparency);
%     carImg = imagesc([x-1 x+1], [y-1 y+1], adjustedArrow, 'AlphaData', transparency);
    % Step 6: Update the plot
    imshow(imread('invisible.png'), 'XData', [x-1 x+1], 'YData', [y-1 y+1]);
%     carImg.XData = [x-1 x+1];
%     carImg.YData = [y-1 y+1];
%     plot(x, y, 'ro');  % Plot the circle's center
%     hold off;
    drawnow()
%     pause(0.1);
end



function rotated_image = imrotate_white(image, rot_angle_degree)
    tform = affine2d([cosd(rot_angle_degree)    -sind(rot_angle_degree)     0; ...
                      sind(rot_angle_degree)     cosd(rot_angle_degree)     0; ...
                      0                          0                          1]);
      rotated_image = imwarp(image, tform, 'interp', 'cubic', 'fillvalues', 255);
end