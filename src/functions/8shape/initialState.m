function [state, Q, d] = initialState(Px,Py, Dx1, Dy1, Ex1, Ey1, Dx2, Dy2, Ex2, Ey2, Cx1, Cy1, Cx2 , Cy2, R1, R2, intersectX, delta) % intersectY)
    %Estado 0: triangulo inferior esquerdo
    %Estado 1: triangulo superior direito
    %Estado 2: arco-2 (o da direita)
    %Estado 3: triangulo inferior direito
    %Estado 4: triangulo superior esquerdo
    %Estado 5: arco-1 (o da esquerda)
    [d_retaD1E2, lambdaD1E2, ~ , ~, Q01] = dist_reta(Dx1, Dy1, Ex2, Ey2, Px, Py);
    [d_retaE1D2, lambdaE1D2, ~ , ~, Q34] = dist_reta(Ex1, Ey1, Dx2, Dy2, Px, Py)
    [d_arcoD2D1 , thetaD2D1 , Q5, ~] = dist_arco(Cx1,Cy1,R1,Px,Py);
    [d_arcoE1E2 , thetaE1E2 , Q2, ~] = dist_arco(Cx2,Cy2,R2,Px,Py);

    D1E2 = sqrt((Dx1-Ex2)^2 + (Dy1-Ey2)^2);
    E1D2 = sqrt((Ex1-Dx2)^2 + (Ey1-Dy2)^2);



    %ponto contido num dos arcos
    if(Px <= Dx2 || Px <= Dx1)

        if(thetaD2D1 > 0 && thetaD2D1 < (pi/2 - delta) && Px >= Cx1)
            state = 4;
            Q = Q34;
            d = d_retaE1D2;

        elseif(thetaD2D1 < 0 && thetaD2D1 > -(pi/2 - delta) && Px >= Cx1)
            state = 0;
            Q = Q01;
            d = d_retaD1E2;
        else
            state = 5;
            Q = Q5;
            d = d_arcoD2D1;
        end
    
    elseif(Px >= Ex2 || Px >= Ex1)
        
        if(thetaE1E2 < 0 && thetaE1E2 > -(pi/2 - delta) && Px <= Cx2)
            state = 1;
            Q = Q01;
            d = d_retaD1E2;

        elseif(thetaE1E2 > 0 && thetaE1E2 < (pi/2 - delta) && Px <= Cx2)
            state = 3;
            Q = Q34;
            d = d_retaE1D2;
        else
            state = 2;
            Q = Q2;
            d = d_arcoE1E2;
        end
        
  

    

    %ponto contido em ambos os segmentos de reta
    elseif( (lambdaD1E2 >= 0) && (lambdaD1E2 <= D1E2) && (lambdaE1D2 >= 0) && (lambdaE1D2 <= E1D2) )
        % entra no segmento de reta mais perto
        if((d_retaD1E2 < d_retaE1D2))
            if (Px >= Dx1 && Px < intersectX)
                state = 0;
                Q = Q01;
                d = d_retaD1E2;

            elseif (Px >= intersectX && Px < Ex2 )
                state = 1;
                Q = Q01;
                d = d_retaD1E2;

            end
        else
            if (Px < Ex1 && Px > intersectX)
                state = 3;
                Q = Q34;
                d = d_retaE1D2;

            elseif (Px <= intersectX && Px > Dx2)
                state = 4;
                Q = Q34;
                d = d_retaE1D2;
         
            end
        end



    
    %ponto contido apenas no segmento D1E2 
    elseif ( (lambdaD1E2 >= 0) && (lambdaD1E2 <= D1E2) )

        if(min([d_retaD1E2 d_arcoE1E2 d_arcoD2D1]) == d_retaD1E2)
            if (Px >= Dx1 && Px < intersectX)
                state = 0;
                Q = Q01;
                d = d_retaD1E2;

            elseif (Px >= intersectX && Px < Ex2 )
                state = 1;
                Q = Q01;
                d = d_retaD1E2;

            end

        elseif(min([d_retaD1E2 d_arcoE1E2 d_arcoD2D1]) == d_arcoE1E2)
            state = 2;
            Q = Q2;
            d = d_arcoE1E2;
        
        elseif(min([d_retaD1E2 d_arcoE1E2 d_arcoD2D1]) == d_arcoD2D1)
            state = 5;
            Q = Q5;
            d = d_arcoD2D1;

        end
    


    


    %ponto contido apenas no segmento E1D2
    elseif ((lambdaE1D2 >= 0) && (lambdaE1D2 <= E1D2)) %ponto contido apenas no segmento E1D2 
        
        if(min([d_retaE1D2 d_arcoE1E2 d_arcoD2D1]) == d_retaE1D2)
            if (Px < Ex1 && Px > intersectX)
                state = 3;
                Q = Q34;
                d = d_retaE1D2;
                
            elseif (Px <= intersectX && Px > Dx2)
                state = 4;
                Q = Q34;
                d = d_retaE1D2;
            end
        
        elseif(min([d_retaE1D2 d_arcoE1E2 d_arcoD2D1]) == d_arcoE1E2)
            state = 2;
            Q = Q2;
            d = d_arcoE1E2;
        
        elseif(min([d_retaE1D2 d_arcoE1E2 d_arcoD2D1]) == d_arcoD2D1)
            state = 5;
            Q = Q5;
            d = d_arcoD2D1;

        end
    end


end