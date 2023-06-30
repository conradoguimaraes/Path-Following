%%
clc,clear,close all

% Read in car image
setaFile = 'seta2.png';   
[I,map,transparency] = imread(setaFile);



roadWidth = 8;
carWidth = 3.5;  % same units as road-width


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

% carX = linspace(-150,1150,numel(x)); % car will start and end outside of the axes 
% carY = (1./(1+exp(-x))*roadWidth - roadWidth/2)*.5;  % assumes road is centered at y=0

carX = x;
carY = y;

fig = figure(); 
% fig.Position(3:4) = [1180,420];
fig.Resize = 'off';  % disable fig resize since car size depends on plot aspect ratio. 
movegui(fig)
% ax = axes(fig,'XLim',[-5, 1100], 'YLim', [-8 8], 'XTick', 0:200:1000, 'ytick', -8:8,'Units','pixels');
XYoffset = 5
ax = axes(fig,'XLim', [min(x)-XYoffset,max(x)+XYoffset], 'YLim', [min(y)-XYoffset,max(y)+XYoffset]); 
% box(ax,'on')
hold(ax,'on')

% Plot road edges and center line
% rightEdge = plot(xlim(ax), roadWidth./[-2,-2], 'k-', 'LineWidth', 5);
% leftEdge = plot(xlim(ax), roadWidth./[2,2], 'k-', 'LineWidth', 5);
% leftEdge = plot(xlim(ax), [0 0], 'k--', 'LineWidth', 3);

% Add trajectory path
% traj = plot(carX, carY, '--', 'LineWidth', 3,'Color',[0.9375 0.5 0.5]);  %lightcoral
traj = plot(carX, carY, '-b', 'LineWidth', 1);

% Compute car length based on specified width and aspect ratio
% xlim and ylim must be set prior to this.  Axes & data aspect ratios cannot change after this!  
drawnow()
% asScalingFactor = (ax.DataAspectRatio(1)/ax.DataAspectRatio(2)) / ...
%     (ax.PlotBoxAspectRatio(1)/ax.PlotBoxAspectRatio(2)); 
% carLength = carWidth * size(I,2)/size(I,1) * asScalingFactor;

carLength = 5;
carWidth = 5;

carXi = carX(:) + carLength./[-2,2];  %[left, right]
carYi = carY(:) + carWidth./[-2,2];   %[lower, upper]

% Draw car at starting point & animate trajectory
carImg = imagesc(carXi(1,:), carYi(1,:), I, 'AlphaData', transparency);
theta = 0;
R = carLength;
for i = 1:size(carXi,1)
    x0 = carXi(i,1);
    x1 = carXi(i,2);
    
    y0 = carYi(i,1);
    y1 = carYi(i,2);
    
    
    
%     center_x = (x0 + x1) / 2;
%     center_y = (y0 + y1) / 2;
%     
%     d = sqrt((x1 - x0)^2 + (y1 - y0)^2);
%     angle_rad = deg2rad(theta);
%     
%     x1_trans = center_x + d * cos(angle_rad);
%     y1_trans = center_y + d * sin(angle_rad);
%     
%     x1 = x1_trans;
%     y1 = y1_trans;
%     
    X = [x0,x1];
    Y = [y0,y1];
    % Rotation angle (30 degrees)
    theta_deg = theta;
    
    % Center of rotation
    xc = (x0 + x1) / 2;
    yc = (y0 + y1) / 2;

    % Convert angle to radians
    theta_rad = deg2rad(theta_deg);
    
    % Define the rotation matrix
    R = [cos(theta_rad) -sin(theta_rad);
         sin(theta_rad) cos(theta_rad)];
%     R = [1 0;
%      0 cos(theta_rad)];
%      R = [cos(theta_rad) 0;
%          0 1];
    % Perform the rotation
    rotated_coords = R * [X - xc; Y - yc] + [xc; yc];

    % Extract the rotated X and Y coordinates
    X_rotated = rotated_coords(1, :);
    Y_rotated = rotated_coords(2, :);


    theta = theta + 1;
    
%     carImg.XData = carXi(i,:);
%     carImg.YData = carYi(i,:);
    carImg.XData = [X_rotated(:,1), X_rotated(:,2)];
    carImg.YData = [Y_rotated(:,1), Y_rotated(:,2)];
%     carImg.XData = [x0,x1];
%     carImg.YData = [y0,y1];

    drawnow();
%     pause(1);  % <--- slow down animation by increasing this value 
end


