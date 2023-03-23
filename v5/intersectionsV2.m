function [intersectX, intersectY] = intersectionsV2(Dx1, Dy1, Dx2, Dy2, Ex1, Ey1, Ex2, Ey2)
    %fprintf("\n intersectionsV2\n");
    %---------------------------------------------
    %Declives das duas retas:
    m1 = (Ey2-Dy1) / (Ex2-Dx1);
    m2 = (Ey1-Dy2) / (Ex1-Dx2);
    
    %Ordenadas na origem das duas retas:
    b1 = Dy1 - m1*Dx1;
    b2 = Dy2 - m2*Dx2;
    
    %Calcular a interseção das duas retas:    
    intersectX = (b2-b1)/(m1-m2);
    intersectY = m2*intersectX + b2;
    %---------------------------------------------
end
