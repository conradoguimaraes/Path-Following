function Control_PD( Px, Py, Dx1, Dy1, Ex2, Ey2, Ex1, Ey1, Dx2, Dy2, R1, R2, state)

T = 50;
h = 0.1;
t = [0:h:T];

x0 = Px;
y0 = Py;
%th0 = 0;          % Parte de cima da reta D1E2 / Parte de baixo da reta E1D2 
%th0 = -pi;       % Parte de cima da reta E1D2 / parte de baixo da reta D1E2
th0 = 0
R_carro = max(R1,R2);
c_max = 1/R_carro;
c = c_max;
c_min = -c_max;
v = 1;

x=x0;
y=y0;
th=th0;
d_ant = 0;
Kp = 0.05;
Kd = 0.5;


for t = 0:h:T
    %[d, ~, ~ , ~, ~] = dist_reta(Ex1, Ey1, Dx2, Dy2, x, y);    % Parte de cima/baixo da reta E1D2
    [d, ~, ~, ~, ~] = dist_reta(Dx1, Dy1, Ex2, Ey2, x, y);      % Parte de cima/baixo da reta D1E2
    dd = (d-d_ant)/h;   
    c = Kp*d + Kd*dd;  % Parte de cima/baixo da reta E1D2
    %c = -Kp*d - Kd*dd;  % Parte de cima/baixo da reta D1E2 
      
    
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
    d_ant = d;
    
    
    plot(x,y,'.-c')
    pause(0.05)
end