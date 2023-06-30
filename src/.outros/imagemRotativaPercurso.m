%%
clc,clear,close all

% Read in car image
setaFile = 'seta3.png';   
[arrowImg,map,transparency] = imread(setaFile);

imageSize = size(arrowImg);
linhas0 = imageSize(1)
colunas0 = imageSize(2)

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
% fig.Resize = 'off';  % disable fig resize since car size depends on plot aspect ratio. 
movegui(fig)
XYoffset = 5
ax = axes(fig,'XLim', [min(x)-XYoffset,max(x)+XYoffset], 'YLim', [min(y)-XYoffset,max(y)+XYoffset]); 
hold(ax,'on')
traj = plot(carX, carY, '-b', 'LineWidth', 1);

drawnow()


carLength = 5;
carWidth = 5;

carXi = carX(:) + carLength./[-2,2];  %[left, right]
carYi = carY(:) + carWidth./[-2,2];   %[lower, upper]

carX = flip(carX);
carY = flip(carY);

% Draw car at starting point & animate trajectory
% carImg = imagesc(carXi(1,:), carYi(1,:), arrowImg, 'AlphaData', transparency);
pause(1)
thetad = 0;
counter = 0
for i = 1:size(carXi,1)    
    thetad = thetad + 1;
    xc = 50;
    yc = 50;
    r = 50;
    
    x = xc + r*cosd(thetad);
    y = yc + r*sind(thetad);
    
    
    adjustedArrow = imrotate_white(arrowImg, -thetad);

    imwrite(adjustedArrow,'invisible.png','Alpha',1-double(all(adjustedArrow == 255, 3)));
    
    setaFile = 'invisible.png';   
    [arrowImg,~,transparency] = imread(setaFile);
    try
        delete(plotImage)
    catch
    end
%     arrowImg = arrowImg(1:linhas0, 1:colunas0,:);
    plotImage = image(arrowImg, 'XData', [x-3 x+3], 'YData', [y-3 y+3], 'AlphaData', transparency);

%     size(arrowImg)
    
    
    drawnow();
    counter = counter + 1;
    pause(0.1);
end
% 
function rotated_image = imrotate_white(image, rot_angle_degree)
    RA = imref2d(size(image));    
    tform = affine2d([cosd(rot_angle_degree)    -sind(rot_angle_degree)     0; ...
                      sind(rot_angle_degree)     cosd(rot_angle_degree)     0; ...
                      0                          0                          1]);
      Rout = images.spatialref.internal.applyGeometricTransformToSpatialRef(RA,tform);
      Rout.ImageSize = RA.ImageSize;
      xTrans = mean(Rout.XWorldLimits) - mean(RA.XWorldLimits);
      yTrans = mean(Rout.YWorldLimits) - mean(RA.YWorldLimits);
      Rout.XWorldLimits = RA.XWorldLimits+xTrans+3;
      Rout.YWorldLimits = RA.YWorldLimits+yTrans+3;
      rotated_image = imwarp(image, tform, 'OutputView', Rout, 'interp', 'cubic', 'fillvalues', 255);
  end
% function rotated_image = imrotate_white(image, rot_angle_degree)
%     tform = affine2d([cosd(rot_angle_degree)    -sind(rot_angle_degree)     0; ...
%                       sind(rot_angle_degree)     cosd(rot_angle_degree)     0; ...
%                       0                          0                          1]);
%     rotated_image = imwarp(image, tform, 'interp', 'cubic', 'fillvalues', 255);
% end