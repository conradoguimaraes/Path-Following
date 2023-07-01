function [state, Q, d] = initialState(Px,Py, Dx1, Dy1, Ex1, Ey1, Dx2, Dy2, Ex2, Ey2, Cx1, Cy1, Cx2 , Cy2, R1, R2, delta) % intersectY)
    %Estado 0: linha de cima
    %Estado 1: arco-2 (o da direita)
    %Estado 2: linha de baixo
    %Estado 3: arco-1 (o da esquerda)
    
%     [d_retaD1E2, lambdaD1E2, ~ , ~, Q01] = dist_reta(Dx1, Dy1, Ex2, Ey2, Px, Py);
%     [d_retaE1D2, lambdaE1D2, ~ , ~, Q34] = dist_reta(Ex1, Ey1, Dx2, Dy2, Px, Py)
    
    
    [d_retaD2E2, lambdaD2E2, ~ , ~, Q01] = dist_reta(Dx2, Dy2, Ex2, Ey2, Px, Py);
    [d_retaD1E1, lambdaD1E1, ~ , ~, Q12] = dist_reta(Dx1, Dy1, Ex1, Ey1, Px, Py);
    
    [d_arcoD2D1 , thetaD2D1 , Q3, ~] = dist_arco(Cx1,Cy1,R1,Px,Py);
    [d_arcoE1E2 , thetaE1E2 , Q1, ~] = dist_arco(Cx2,Cy2,R2,Px,Py);

%     D1E2 = sqrt((Dx1-Ex2)^2 + (Dy1-Ey2)^2);
%     E1D2 = sqrt((Ex1-Dx2)^2 + (Ey1-Dy2)^2);
%     fprintf("D2E2 %f\n", d_retaD2E2)
%     fprintf("D1E1 %f\n", d_retaD1E1)
%     fprintf("aD1D2 %f\n", d_arcoD2D1)
%     fprintf("aE1E2 %f\n", d_arcoE1E2)
    if(min([d_retaD2E2 d_retaD1E1 d_arcoD2D1 d_arcoE1E2]) == d_retaD2E2)
        state = 0;
        Q = Q01;
        d = d_retaD2E2;
    elseif (min([d_retaD2E2 d_retaD1E1 d_arcoD2D1 d_arcoE1E2]) == d_retaD1E1)
        state = 2;
        Q = Q12;
        d = d_retaD1E1;
    elseif (min([d_retaD2E2 d_retaD1E1 d_arcoD2D1 d_arcoE1E2]) == d_arcoD2D1)
        state = 3;
        Q = Q3;
        d = d_arcoD2D1;
        
    elseif (min([d_retaD2E2 d_retaD1E1 d_arcoD2D1 d_arcoE1E2]) == d_arcoE1E2)
        state = 1;
        Q = Q1;
        d = d_arcoE1E2;
    else
        state = 0;
        Q = Q01;
        d = d_retaD2E2;
    end

   
    

end