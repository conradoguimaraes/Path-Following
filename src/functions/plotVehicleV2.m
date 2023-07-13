%{
The function vehicleImage = plotVehicleV2(x,y,thetad, vehicleImage)
allows to plot the vehicle image/drawing on the plot as it
maneuvres itself along the path.
%}
function vehicleImage = plotVehicleV2(x,y,thetad, vehicleImage)

    thetad = round(thetad);
    if (thetad > 360)
        thetad = 1;
    end
    if (thetad < 0)
        thetad = thetad + 359 - 45; 
    else
        thetad = thetad + 45;
        if (thetad+45>360)
            thetad = (thetad+45)-360;
        end
    end

    filePath = pwd + "\missilePictures\" + string(thetad) + ".png";
    filePath = char(filePath);
    [imagem,~,transparency] = imread(filePath);

    try
        delete(vehicleImage)
    catch
    end
    x = x-0.5;
    y = y-0.5;
    vehicleImage = image(imagem, 'XData', [x-3 x+3], 'YData', [y y+1], 'AlphaData', transparency);
end