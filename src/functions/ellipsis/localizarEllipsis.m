function state = localizarEllipsis(Px,Py, state,...
                            Dx1, Dy1, ...
                            Ex1, Ey1, ...
                            Dx2, Dy2, ...
                            Ex2, Ey2)
    
    
                       
    if (state == 0 && (Px > Dx2 && Px < Ex2))
        state = 0;
    elseif (state == 0 && (Px >= Ex2 || Px >= Ex1))
        state = 1;
        
    elseif (state == 1 && (Px >= Ex2 || Px >= Ex1) && Py > Ey1)
        state = 1;
    elseif (state == 1 && (Px < Ex1 && Px > Dx1))
        state = 2;
        
    elseif (state == 2 && (Px < Ex1 && Px > Dx1))
        state = 2;
    elseif (state == 2 && (Px <= Dx1 || Px <= Dx2))
        state = 3;
        
    elseif (state == 3 && (Px <= Dx1 || Px <= Dx2) && Py < Dx2)
        state = 3;
    elseif (state == 3 && (Px > Dx2 && Px < Ex2))
        state = 0;
        
        fprintf("here-1")
        
    else
        state = state;
    end 
 
   
    state;
    
end