function cost = CostControl_PD_KpKdKi( Px, Py, Dx1, Dy1, Ex2, Ey2, Ex1, Ey1, Dx2, Dy2, R1, R2, Cx1, Cy1, Cx2, Cy2, state, Kp, Kd, Ki, threshold, Q)

T = 170;
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


[intersectX, intersectY] = intersections(Dx1, Dy1, Dx2, Dy2, Ex1, Ey1, Ex2, Ey2);
% [intersectX, intersectY] = intersectionsV2(Dx1, Dy1, Dx2, Dy2, Ex1, Ey1, Ex2, Ey2);

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
    TimeArray = [0:h:t];
    %--------------------------------
    %%{
    
    %%}
    %--------------------------------
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
    
    
    %{
    if (t<200)
        subplot(1,2,1), hold on
        plot(x,y,'.-c')
    elseif (t>= 200)
        subplot(1,2,1), hold on
        plot(x,y,'.-m')
    end
    %}
    
    %--------------------------------
%     subplot(1,2,1), hold on
%     plot(x,y,'.-c')

    
    h1=subplot(1,3,1), hold on, grid on
    plot(x,y,'.-c')
    titulo1 = "Vehicle Position (t="+string(t)+"s)";
    title(titulo1)
    
    
    
    h2=subplot(1,3,2), hold on
    plot(x,y,'.-c')
    plot(Q(1), Q(2),'.-r')
    plot([x Q(1)], [y Q(2)], ':m')
    
    xlim([x-1.5, x+1.5])
    ylim([y-0.5, y+0.5])
    
    
    
    h3=subplot(1,3,3), hold on, grid on
    cla
%     hPlotData = subplot(1,3,3);
%     delete(hPlotData);
    costArray(costIndex) = abs(d);
    
    %plot(t,costArray(costIndex),'.-b')
    plot(TimeArray, costArray(1:costIndex), '-b')
    xlim([0,t+0.5])
    ylim([0, max(costArray+0.1)])
    
    media = mean(costArray);
    plot(TimeArray,ones(1,length(TimeArray))*media,'-r','LineWidth',0.8)
    titulo2 = "Cross-track Error(t="+string(t)+"s)";
    title(titulo2)
    %{
    if (min(costArray)<0)
        ylim([min(costArray), ceil(max(costArray))])
    else
        ylim([0, ceil(max(costArray))])
    end
    %}
    
    pause(0.000005)
    
    costIndex = costIndex + 1;
    
    %--------------------------------
    %xlim([3, 57])
    %ylim([8, 22])
    
    %subplot(1,2,2), hold on
    %plot(x,y,'.-c')
       
    
    
       
    cost = cost + abs(d);
    
    
    %figure(5)
    
    if (cost > 99999999)
        continue
    end
    %pause(0.025)
    
    if (rem(t,15) == 0)
          if (t==0)
            input('==== ')
          end
          saveas(gcf,string(t)+".png")
%         handle=subplot(131);
%         get(handle,'position');
%         saveas(gcf,string(t)+".png")
%         handle=subplot(133);
%         H = get(handle,'position');
%         saveas(H,titulo2+".png")
    end
    
end

% t = [0:h:T];
% subplot(1,3,3), hold on
% media = mean(costArray);
% plot(t,ones(1,length(t))*media,'-r','LineWidth',0.8)

end