%%
clc,clear,close all




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

%-------------------------------------------------

carX = x;
carY = y;


%-------------------------------------------------
fig = figure(); 
movegui(fig)
XYoffset = 5
ax = axes(fig,'XLim', [min(x)-XYoffset,max(x)+XYoffset], 'YLim', [min(y)-XYoffset,max(y)+XYoffset]); 
hold(ax,'on')
traj = plot(carX, carY, '-b', 'LineWidth', 1);
drawnow()
%-------------------------------------------------



carXi = 0
carYi = 0

pause(1)
thetad = 0;
vehicleImage = -1;
for i = 1:length(t)  
    thetad = thetad + 5;
    xc = 50;
    yc = 50;
    r = 50;
    
    x = xc + r*cosd(thetad);
    y = yc + r*sind(thetad);
    
    vehicleImage = plotVehicle(x,y,thetad, vehicleImage);
 
    pause(0.1);
end



function vehicleImage = plotVehicle(x,y,thetad, vehicleImage)
    
    setaFile = 'missil.png';   
    [arrowImg,~,~] = imread(setaFile);
    
    %Rodar
    adjustedArrow = imrotate_white(arrowImg, -thetad);

    imwrite(adjustedArrow,'invisible.png','Alpha',1-double(all(adjustedArrow == 255, 3)));
    
    setaFile = 'invisible.png';   
    [arrowImg,~,transparency] = imread(setaFile);
    try
        delete(vehicleImage)
    catch
    end

    vehicleImage = image(arrowImg, 'XData', [x-3 x+3], 'YData', [y-3 y+3], 'AlphaData', transparency);


    drawnow();

end

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
