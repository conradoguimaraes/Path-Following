function [cost,handler1,handler3] = CostControl_PD_KpKdKi(simulationTime,Px, Py, Dx1, Dy1, Ex2, Ey2, Ex1, Ey1, Dx2, Dy2, R1, R2, Cx1, Cy1, Cx2, Cy2, state, Kp, Kd, Ki, threshold, Q)

    T = simulationTime;
    h = 0.5;
    %t = [0:h:T];


    x0 = Px;
    y0 = Py;
    if (state == 3 || state == 4 || state == 2)
        th0 = -pi;
    else
        th0 = 0;
    end
    th0 = 0;

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

    thetad = 0;
    vehicleImage = -1;
    singleFigure = true;
    
    %two laps with color difference:
    lapCounter = 1;
    use2laps = false;
    refT = simulationTime/2;
    legend off
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

        %-----------------------------------------
        dx = v * cos(th);
        dy = v * sin(th);
        dth = v*c;
        x = x + dx*h;
        y = y + dy*h;
        th = th + dth*h;

        sumd = sumd + d;
        d_ant = d;
        d;
        %-----------------------------------------


        if (singleFigure == true)
            h1=subplot(1,2,1); hold on, grid on
        else
            h1=figure(1); hold on, grid on
        end
        
        if (t>=refT && use2laps == true)
            if (lapCounter == 1)
                plot(x,y,'xr','MarkerSize',15)
            end
            P(2) = plot(h1,x,y,'.-g');
        else
            P(2) = plot(h1,x,y,'.-b');
        end
        
        P(3) = plot(h1,x0,y0,'xr','MarkerSize',15);

        thetad = rad2deg(th);
        xrotated = x;
        yrotated = y;
        vehicleImage = plotVehicleV2(xrotated,yrotated,thetad, vehicleImage);
        
        
        
        ax1 = gca;
    
        
        %-----------------------------------------

        %-----------------------------------------


        if (singleFigure == true)
            h3=subplot(1,3,3); hold on, grid on
        else
            h3=figure(3); hold on, grid on
        end
        cla
        costArray(costIndex) = abs(d);
        
        if (t>=refT && use2laps == true)
            if (lapCounter == 1)
                lap2costStartIndex = costIndex;
                fprintf("Soma Custo Total Lap-1: %.2f\n", sum(costArray(1:lap2costStartIndex)))
                lapCounter = -1;
            end
            plot([0:h:refT], costArray(1:lap2costStartIndex), '-b','LineWidth',2.5)
            plot([refT:h:t], costArray(lap2costStartIndex:costIndex), '-g','LineWidth',2.5)
        else
            plot(TimeArray, costArray(1:costIndex), '-b','LineWidth',2.5)
        end
       
        
        xlim([0,t+0.5])
        ylim([0, max(costArray+0.1)])
        media = mean(costArray);
        plot(TimeArray,ones(1,length(TimeArray))*media,'-r','LineWidth',0.8)

        
        ax3 = gca;
       

     
        %-----------------------------------------
        pause(0.0000000000005)

        costIndex = costIndex + 1;

        




        cost = cost + abs(d);



        if (cost > 99999999)
            continue
        end
        

        

    end %end-for
    
    
    if (use2laps == true)
        fprintf("Soma Custo Total Lap-2: %.2f\n", sum(costArray(lap2costStartIndex:end)))
    end
    
    
    
    
    hold all
    if (singleFigure == true)
        %..........................
        P(1) = plot(h1,nan,nan,"-k");
        
        xlabel(h1,"x (metres)")
        ylabel(h1,"y (metres)")

        legend(P(:),{"desired path","vehicle path","initial position"})
        axis(ax1,'square')
        text(h1,x0-3,y0-0.5,"$(P_{x_0}, P_{y_0})$",'Color','red','FontSize',12,'Interpreter','latex')
        
        titulo1 = "Vehicle Position (t="+string(t)+"s) ";
        %KvaluesString = "\{$K_p$="+string(Kp)+",$K_i$="+string(Ki)+",$K_d$="+string(Kd)+"\}";
        KvaluesString = "\{Kp="+string(Kp)+",Ki="+string(Ki)+",Kd="+string(Kd)+"\}";
        title(h1,titulo1+KvaluesString)
        
        
        xlim(ax1,[-5, 65])
        xticks(ax1,-5:5:65)
        
        ylim(ax1,[0, 30])
        yticks(ax1,0:1:30)
        
        %..........................
        xlabel(h3,"Time (seconds)")
        ylabel(h3,"Cross-track Error")
        axisXlength = get(h3, 'XLim');
        text(h3,round(axisXlength(2)/2), media+0.04, "$\overline{d}$ = " + string(vpa(media,2)),'Color','red','FontSize',14,'Interpreter','latex')
        legend(h3,"cross-track error","average cross-track error")
        
        
        set(h3,'Position',[0.54159 0.195 0.34 0.635])
        
        
        xticks(ax3,0:10:max(TimeArray))
        yticks(ax3,0:0.1:max(costArray))
        
        titulo2 = "Cross-track Error (t="+string(t)+"s)" + " (current total "+string(sum(costArray))+")";
        title(titulo2)
        %..........................
        
        set(gcf, 'Color', 'w');
    else
        xlabel(axes('Parent',h1),"x (metres)")
        ylabel(axes('Parent',h1),"y (metres)")
%         legend(h1,"desired path")
        
%         xlabel(axes('Parent',h3),"Time (seconds)")
%         ylabel(axes('Parent',h3),"Cross-track Error")
%         axisXlength = get(h3, 'XLim');
%         text(h3,round(axisXlength(2)/2), media+0.025, "$\overline{d}$ = " + string(vpa(media,2)),'Color','red','FontSize',14,'Interpreter','latex')
%         legend(h3,"cross-track error","average cross-track error")
    end
    
    
    handler1 = h1;
    handler3 = h3;

end



function vehicleImage = plotVehicleV2(x,y,thetad, vehicleImage)

    thetad = round(thetad);
    if (thetad > 360)
        thetad = 1;
    end
    if (thetad < 0)
        thetad = thetad + 359 - 45; 
    else
        thetad = thetad + 45;
        if (thetad+45>360)
            thetad = (thetad+45)-360;
        end
    end

    filePath = pwd + "\missilePictures\" + string(thetad) + ".png";
    filePath = char(filePath);
    [imagem,~,transparency] = imread(filePath);

    try
        delete(vehicleImage)
    catch
    end
    x = x-0.5;
    y = y-0.5;
    vehicleImage = image(imagem, 'XData', [x-3 x+3], 'YData', [y y+1], 'AlphaData', transparency);
end



