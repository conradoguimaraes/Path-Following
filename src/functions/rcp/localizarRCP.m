function state = localizarRCP(Px,Py, state)
    run('rcp_GlobalVars.m')
    
    if (state == 0 && (Px > PA1x && Px < PB1x))
        state = 0;
    elseif (state == 0 && Px >= PB1x)
        state = 1;
    
    elseif (state == 1 && (Px >= PB1x) && (Py <= PB2y))
        state = 1;
    elseif (state == 1 && Py > PB2y)
        state = 2;
        
    elseif (state == 2 && (Py > PB2y && Py < PC1y))
        state = 2;
    elseif (state == 2 && Py >= PC1y)
        state = 3;
    
    elseif (state == 3 && (Py > PC2y && Px >= PC2x))
        state = 3;
    elseif (state == 3 && Px < PC2x)
        state = 4;
    
    elseif (state == 4 && (Px < PC2x && Px > PD1x))
        state = 4;
    elseif (state == 4 && Px <= PD1x)
        state = 5;
    
    elseif (state == 5 && (Py <= PD2y && Px <= PD1x))
        state = 5;
    elseif (state == 5 && Py >= (PD2y))
        state = 6;
        
    elseif (state == 6 && Py >= PD2y && Py < PE1y)
        state = 6;
    elseif (state == 6 && Py >= PE1y)
        state = 7;
        
    elseif (state == 7 && Py >= PE1y && Px < PE2x)
        state = 7;
    elseif (state == 7 && Px >= PE2x)
        state = 8;
        
    elseif (state == 8 && Px >= PE2x && Px < PF1x)
        state = 8;
    elseif (state == 8 && Px >= PF1x)
        state = 9;

    elseif (state == 9 && (Px >= PF1x) && (Py <= PF2y))
        state = 9;
    elseif (state == 9 && Py > PF2y)
        state = 10;
    
    elseif (state == 10 && (Py > PF2y && Py < PG1y))
        state = 10;
    elseif (state == 10 && Py >= PG1y)
        state = 11;
    
    elseif (state == 11 && (Py > PG2y && Px >= PG2x))
        state = 11;
    elseif (state == 11 && Px < PG2x)
        state = 12;
    
    elseif (state == 12 && (Px < PG2x && Px > PH1x))
        state = 12;
    elseif (state == 12 && Px <= PH1x)
        state = 13;
    
    elseif (state == 13 && Px <= PH1x && Py >= PH2y)
        state = 13;
    elseif (state == 13 && Py < PH2y && Px > PJ1x)
        state = 14;
        
    elseif (state == 14 && Py < PH2y && Py > PI1y)
        state = 14;
    elseif (state == 14 && Py <= PI1y)
        state = 15;
    
    elseif (state == 15 && Py <= PI1y)
        state = 15;
    elseif (state == 15 && Px < Cx9 && Py > PI2y)
        state = 16;
        
    elseif (state == 16 && Py > PI2y && Py < PJ1y)
        state = 16;
    elseif (state == 16 && Py >= PJ1y)
        state = 17;
        
    elseif (state == 17 && Py >= PJ1y)
        state = 17;
    elseif (state == 17 && Py < PJ2y && Px < Cx10)
        state = 18;
        
    elseif (state == 18 && Py < PJ2y && Py > PA2y)
        state = 18;
    elseif (state == 18 && Py <= PA2y)
        state = 19;
    
    elseif (state == 19 && Py <= PA2y && Px <= PA1x)
        state = 19;
    elseif (state == 19 && Px > PA1x)
        state = 0;

    else
        state = state;
    end
    

    state;
    
end