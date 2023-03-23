function cost = CostControl_PD_KpKdKi_SemPlots( Px, Py, Dx1, Dy1, Ex2, Ey2, Ex1, Ey1, Dx2, Dy2, R1, R2, Cx1, Cy1, Cx2, Cy2, state, Kp, Kd, Ki, threshold, Q)

T = 150;
h = 0.1;
%t = [0:h:T];

x0 = Px;
y0 = Py;
if (state == 3 || state == 4 || state == 2)
    th0 = -pi;
else
    th0 = 0;
end

R_carro = max(R1,R2)/2;
c_max = 1/R_carro;
c = c_max;
c_min = -c_max;
v = 1.0;

x=x0;
y=y0;
th=th0;
d_ant = 0;


%[intersectX, intersectY] = intersections(Dx1, Dy1, Dx2, Dy2, Ex1, Ey1, Ex2, Ey2);
[intersectX, intersectY] = intersectionsV2(Dx1, Dy1, Dx2, Dy2, Ex1, Ey1, Ex2, Ey2);

Kpo = Kp;
Kdo = Kd;
Kio = Ki;
vdo = v;
sumd = 0;
hold on

cost = 0;

costArray = (0:h:T)*0;
costIndex = 1;
for t = 0:h:T
    

    state = localizar(x,y, state,...
                            Dx1, Dy1, ...
                            Ex1, Ey1, ...
                            Dx2, Dy2, ...
                            Ex2, Ey2, ...
                            intersectX, intersectY);
   
    if (state == 0 || state == 1)               
    %[d, ~, ~ , ~, ~] = dist_reta(Ex1, Ey1, Dx2, Dy2, x, y);    % Parte de cima/baixo da reta E1D2
        [d, ~, lambda2, ~, Q] = dist_reta(Dx1, Dy1, Ex2, Ey2, x, y);      % Parte de cima/baixo da reta D1E2
        
        if(lambda2 <= 0)
            d = d*(-1);
        end
        curvatura = 0;
        v = vdo;
        Kd = Kdo;
        Kp = Kpo;

    elseif (state == 3 || state == 4)
        [d, ~, lambda2, ~, Q] = dist_reta(Ex1, Ey1, Dx2, Dy2, x, y);     % Parte de cima/baixo da reta D1E2
        
        if(lambda2 <= 0)
            d = d*(-1);
        end

        %d = d*(-1);
        curvatura = 0;
        Kd = Kdo;
        Kp = Kpo;
        v = vdo;
        

    elseif (state == 2)
        [d, ~, Q, eq] = dist_arco(Cx2,Cy2,R2,x,y);
        
        if(eq < R2^2)
            curvatura = 1/R2;
        else
            d = d*(-1);
            curvatura = -1/R2;
        end
        
        %d = d*(-1);
        Kd = Kdo;
        Kp = Kpo;
        v = vdo;
        
    elseif (state == 5)
        [d, ~, Q, eq] = dist_arco(Cx1,Cy1,R1,x,y);
        
        if(eq < R1^2)
            d = d*(-1);
            curvatura = -1/R1;
            
        else
            curvatura = 1/R1;
        end
        %curvatura = 1/R1;
        Kd = Kdo;
        Kp = Kpo;
        v = vdo;

    end
    
%     if (d>threshold+0.5)
%         return
%     end
    
    dd = (d-d_ant)/h; 
    
    
    
    if (state == 0 || state == 1 || state == 5)
        c = Kp*d + Kd*dd + Ki*sumd + curvatura;
    elseif (state == 3 || state == 4 || state == 2)
        c = Kp*d + Kd*dd - Ki*sumd + curvatura;
    end
    
      
    
     if c>c_max
         c=c_max;
     end
     if c<c_min
         c=c_min;
     end


    dx = v * cos(th);
    dy = v * sin(th);
    dth = v*c;
    x = x + dx*h;
    y = y + dy*h;
    th = th + dth*h;
    
    sumd = sumd + d;
    d_ant = d;
    d;
    

       
    
    
       
    cost = cost + abs(d);
    
    costArray(costIndex) = d;
    costIndex = costIndex + 1;
    
    if (cost > 78.075)
        return
    end
end

figure(5)
plot(t,costArray,'-m')
xlabel('time')
ylabel('cross track error')
end