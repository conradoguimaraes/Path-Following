function [intersectX, intersectY] = intersections(Dx1, Dy1, Dx2, Dy2, Ex1, Ey1, Ex2, Ey2)
    %fprintf("\n intersectionsV1\n");
    %---------------------------------------------
    %Declives das duas retas:
    m1 = (Ey2-Dy1) / (Ex2-Dx1);
    m2 = (Ey1-Dy2) / (Ex1-Dx2);
    
    %Ordenadas na origem das duas retas:
    b1 = Dy1 - m1*Dx1;
    b2 = Dy2 - m2*Dx2;
    
    %Equações das duas retas:
    syms x y
    eqn1 = (y == m1*x + b1);
    eqn2 = (y == m2*x + b2);
    
    %Calcular a interseção das duas retas:
    [intersectX, intersectY] = solve(eqn1, eqn2, x,y);
    intersectX = vpa(intersectX, 5)
    intersectY = vpa(intersectY, 5)
    
    %---------------------------------------------
end
