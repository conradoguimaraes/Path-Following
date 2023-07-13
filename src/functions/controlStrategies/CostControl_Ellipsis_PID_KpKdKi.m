function [cost,handler1,handler3] = CostControl_Ellipsis_PID_KpKdKi(simulationTime,Px, Py, Dx1, Dy1, Ex2, Ey2, Ex1, Ey1, Dx2, Dy2, R1, R2, Cx1, Cy1, Cx2, Cy2, state, Kp, Kd, Ki, threshold, Q)

    T = simulationTime;
    h = 0.1;
    %t = [0:h:T];


    run('init_Ellipsis_startingThetaAngle.m')
    
    run('init_carVars.m')


    %Backup original PID values and Velocity:
    Kpo = Kp;
    Kdo = Kd;
    Kio = Ki;
    vdo = v;
    
    %Initialize total distance sum as 0:
    sumd = 0;
    %thetad = 0;
    
    %Initialize Cost Variables/Arrays:
    cost = 0;
    costArray = (0:h:T)*0;
    costIndex = 1;

    
    vehicleImage = -1;
    VPlotHandler = -1;
    singleFigure = true;
    run('init_LapCounter.m')
    
    hold on
    legend off
    
    %#############################################
    %#############################################
    for t = 0:h:T
        TimeArray = [0:h:t];
        
        %-----------------------------------------
        %Get the state that fits the best concerning
        %the current vehicle position
        state = localizarEllipsis(x,y, state,...
                                Dx1, Dy1, ...
                                Ex1, Ey1, ...
                                Dx2, Dy2, ...
                                Ex2, Ey2);
        
                            
        %-----------------------------------------
        %Evaluate the current state and decide wether it should compute 
        %the distance to the straight line or to a curve:
        
        if (state == 0)
            [d, ~, lambda2, ~, Q] = dist_reta(Dx2, Dy2, Ex2, Ey2, x, y);      % Parte de cima/baixo da reta D1E2

            if(lambda2 <= 0)
                d = d*(-1);
            end
            curvatura = 0;
            v = vdo;
            Kd = Kdo;
            Kp = Kpo;

        elseif (state == 2)
            [d, lambda1, lambda2, ~, Q] = dist_reta(Ex1, Ey1, Dx1, Dy1, x, y);     % Parte de cima/baixo da reta D1E2

            if(lambda2 <= 0)
                d = d*(-1);
            end

            %d = d*(-1);
            curvatura = 0;
            Kd = Kdo;
            Kp = Kpo;
            v = vdo;


        elseif (state == 1)
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

        elseif (state == 3)
            [d, ~, Q, eq] = dist_arco(Cx1,Cy1,R1,x,y);

            if(eq < R1^2)
                curvatura = 1/R1;
            else
                d = d*(-1);
                curvatura = -1/R1;
            end
            %curvatura = 1/R1;
            Kd = Kdo;
            Kp = Kpo;
            v = vdo;

        end

        %-----------------------------------------
        %Euler Discretization of the derivative term
        dd = (d-d_ant)/h;
        
        
        %-----------------------------------------
        %Apply the PID Formulation:
        %c = Kp*d + Kd*dd + Ki*sumd + curvatura;
        if (state == 0 || state == 1)
            c = Kp*d + Kd*dd + Ki*sumd + curvatura;
        elseif (state == 2 || state == 3)
            c = Kp*d + Kd*dd - Ki*sumd + curvatura;
        end


        %-----------------------------------------
        %Evaluate if Curvature Saturation ocurred
        if c>c_max
            c=c_max;
        end
        
        if c<c_min
            c=c_min;
        end

        %-----------------------------------------
        %Compute the dx,dy,dth and update the variables
        dx = v * cos(th);
        dy = v * sin(th);
        dth = v*c;
        x = x + dx*h;
        y = y + dy*h;
        th = th + dth*h;

        sumd = sumd + d; %add the distance (positive or negative)
        d_ant = d; %previous distance
        d;
        %-----------------------------------------
        
        
        %Update the Figures with the new values
        run('figure_Ellipsis_insideFORLoop.m')

        
       

     
        %-----------------------------------------
        %Short pause so that the vehicle's position
        %is updated and moves (visually) with time
        pause(0.0000000000005)
        
        
        
        costIndex = costIndex + 1;
        
        %add the distance (which is the cost) - always absolute (positive)
        %so that we ignore the distance sign variations along the path
        cost = cost + abs(d); 



        if (cost > 99999999)
            continue
        end
        

        

    end %end-for
    %#############################################
    %#############################################
    
    
    if (use2laps == true)
        fprintf("Soma Custo Total Lap-2: %.2f\n", sum(costArray(lap2costStartIndex:end)))
    end
    
    run('figure_Ellipsis_afterFORLoop_adjustments.m')
    
    handler1 = h1;
    handler3 = h3;

end



