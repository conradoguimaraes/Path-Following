%Angle should be be in degrees
function VPlotHandler = drawVector(figHandler, x0,y0,phi,R)
    if ~exist('x0','var')
      error("Missing argument: X0 coordinate.")
    end
    if ~exist('y0','var')
      error("Missing argument: Y0 coordinate.")
    end
    if ~exist('R','var')
      error("Missing argument: vector length R.")
    end
    if ~exist('phi','var')
      error("Missing argument: vector angle phi.")
    end
    
    x1 = R*sind(phi);
    y1 = R*sind(phi);
    
    %Vector Origin:
    %x0 = 5;
    %y0 = 5;

    coordinates = [x0, y0, x1, y1];
    if ~exist('figHandler','var')
        VPlotHandler = quiver(figHandler, coordinates(:,1), ...
                                          coordinates(:,2), ...
                                          coordinates(:,3), ...
                                          coordinates(:,4));
    else
        VPlotHandler = quiver(coordinates(:,1), ...
                              coordinates(:,2), ...
                              coordinates(:,3), ...
                              coordinates(:,4));
    end
end

