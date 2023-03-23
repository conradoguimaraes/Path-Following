function state = localizar(Px,Py, state,...
                            Dx1, Dy1, ...
                            Ex1, Ey1, ...
                            Dx2, Dy2, ...
                            Ex2, Ey2, ...
                            intersectX, intersectY)
    
                    
   
                       
    if (state == 0 && Px >= Dx1 && Py < intersectY)
        state = 0;
    
    elseif (state == 0 && Px >= intersectX && Px < Ex2 && Py >= intersectY)
        state = 1;
        
    elseif (state == 1 && Px >= intersectX && Px < Ex2 && Py >= intersectY)
        state = 1;
    
    elseif (state == 1 && (Px >= Ex2 || Px >= Ex1))
        state = 2;
    
    elseif (state == 2 && (Px >= Ex2 || Px >= Ex1))
        state = 2;
        
    elseif (state == 2 && Px < Ex1 && Px >= intersectX && Py <= intersectY)
        state = 3;
        
    elseif (state == 3 && Px < Ex1 && Px >= intersectX && Py <= intersectY)
        state = 3;
        
    elseif (state == 3 && Px <= intersectX && Px > Dx2 && Py > intersectY)
        state = 4;
        
    elseif (state == 4 && Px <= intersectX && Px > Dx2 && Py > intersectY)
        state = 4;
        
    elseif (state == 4 && (Px < Dx2 || Px < Dx1))
        state = 5;
        
    elseif (state == 5 && (Px < Dx2 || Px < Dx1))
        state = 5;
        
    elseif (state == 5 && Px >= Dx1 && Py < intersectY)
        state = 0;
    end
        
    state;
    
end