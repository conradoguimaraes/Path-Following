function ID = findID(Qx, Qy, PontosX, PontosY, state, Cy1, Cy2)
    
    
    if (state == 0 || state == 1)
        i = [1:1:(length(PontosX)/4)];
        
        i0 = find(abs(PontosX(i)-Qx)<0.0001);
        i1 = find(abs(PontosX(i)-Qx)<0.0007);
        i2 = find(abs(PontosX(i)-Qx)<0.001);

        if (~isempty(i0))
                diff = abs(Qy-PontosY(i0));
                id = find(min(diff)==diff);
                ID = i0(id);

        elseif (~isempty(i1))
                diff = abs(Qy-PontosY(i1));
                id = find(min(diff)==diff);
                ID = i1(id);
        
        elseif (~isempty(i2))
                diff = abs(Qy-PontosY(i2));
                id = find(min(diff)==diff);
                ID = i2(id);
        end







    elseif(state == 2 && Qy > Cy2)
        i = [(length(PontosX)/4):1:(1/4*length(PontosX) + 1/8*length(PontosX))];
        
        
        i0 = find(abs(PontosX(i)-Qx)<0.0001);
        i1 = find(abs(PontosX(i)-Qx)<0.0007);
        i2 = find(abs(PontosX(i)-Qx)<0.001);

        if (~isempty(i0))
                diff = abs(Qy-PontosY(i0));
                id = find(min(diff)==diff);
                ID = i0(id) + (length(PontosX)/4);

        elseif (~isempty(i1))
                diff = abs(Qy-PontosY(i1));
                id = find(min(diff)==diff);
                ID = i1(id) + (length(PontosX)/4);
        
        elseif (~isempty(i2))
                diff = abs(Qy-PontosY(i2));
                id = find(min(diff)==diff);
                ID = i2(id) + (length(PontosX)/4);
        end
    

    elseif(state == 2 && Qy < Cy2)
        i = [(length(PontosX)*1/4 + 1/8*length(PontosX)) : 1 : (2/4*length(PontosX)) ];
        
        i0 = find(abs(PontosX(i)-Qx)<0.0001);
        i1 = find(abs(PontosX(i)-Qx)<0.0007);
        i2 = find(abs(PontosX(i)-Qx)<0.001);

        if (~isempty(i0))
                diff = abs(Qy-PontosY(i0));
                id = find(min(diff)==diff);
                ID = i0(id) + (length(PontosX)/4 + 1/8*length(PontosX));

        elseif (~isempty(i1))
                diff = abs(Qy-PontosY(i1));
                id = find(min(diff)==diff);
                ID = i1(id) + (length(PontosX)/4 + 1/8*length(PontosX));
        
        elseif (~isempty(i2))
                diff = abs(Qy-PontosY(i2));
                id = find(min(diff)==diff);
                ID = i2(id) + (length(PontosX)/4 + 1/8*length(PontosX));
        end


    
    
    

    
    
    elseif(state == 3 || state == 4)
        i = [(2*length(PontosX)/4):1:(3*length(PontosX)/4)];
        
        i0 = find(abs(PontosX(i)-Qx)<0.0001);
        i1 = find(abs(PontosX(i)-Qx)<0.0007);
        i2 = find(abs(PontosX(i)-Qx)<0.001);

        if (~isempty(i0))
                diff = abs(Qy-PontosY(i0));
                id = find(min(diff)==diff);
                ID = i0(id) + (2*length(PontosX)/4);

        elseif (~isempty(i1))
                diff = abs(Qy-PontosY(i1));
                id = find(min(diff)==diff);
                ID = i1(id) + (2*length(PontosX)/4);
        
        elseif (~isempty(i2))
                diff = abs(Qy-PontosY(i2));
                id = find(min(diff)==diff);
                ID = i2(id) + (2*length(PontosX)/4);
        end









    elseif(state == 5 && Qy > Cy1)
        i = [(3/4*length(PontosX)) : 1 : (3/4*length(PontosX) + 1/8*length(PontosX))];
        
        i0 = find(abs(PontosX(i)-Qx)<0.0001);
        i1 = find(abs(PontosX(i)-Qx)<0.0007);
        i2 = find(abs(PontosX(i)-Qx)<0.001);

        if (~isempty(i0))
                diff = abs(Qy-PontosY(i0));
                id = find(min(diff)==diff);
                ID = i0(id) + (3*length(PontosX)/4);

        elseif (~isempty(i1))
                diff = abs(Qy-PontosY(i1));
                id = find(min(diff)==diff);
                ID = i1(id) + (3*length(PontosX)/4);
        
        elseif (~isempty(i2))
                diff = abs(Qy-PontosY(i2));
                id = find(min(diff)==diff);
                ID = i2(id) + (3*length(PontosX)/4);
        end
    
    
    elseif(state == 5 && Qy < Cy1)

        i = [(3/4*length(PontosX) + 1/8*length(PontosX)) : 1 : length(PontosX)];
        
        i0 = find(abs(PontosX(i)-Qx) < 0.0001);
        i1 = find(abs(PontosX(i)-Qx) < 0.0007);
        i2 = find(abs(PontosX(i)-Qx) < 0.001);

        if (~isempty(i0))
                diff = abs(Qy-PontosY(i0));
                id = find(min(diff)==diff);
                ID = i0(id) + (3*length(PontosX)/4 + 1/8*length(PontosX));

        elseif (~isempty(i1))
                diff = abs(Qy-PontosY(i1))
                id = find(min(diff)==diff);
                ID = i1(id) + (3*length(PontosX)/4 + 1/8*length(PontosX));
        
        elseif (~isempty(i2))
                diff = abs(Qy-PontosY(i2));
                id = find(min(diff)==diff);
                ID = i2(id) + (3*length(PontosX)/4 + 1/8*length(PontosX));
        end



    end


end