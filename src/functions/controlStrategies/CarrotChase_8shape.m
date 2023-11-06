function [cost,handler1,handler3] = CarrotChase_8shape(simulationTime,Px, Py, Dx1, Dy1, Ex2, Ey2, Ex1, Ey1, Dx2, Dy2, R1, R2, Cx1, Cy1, Cx2, Cy2, state, threshold, Q, L0, Kp, alfa)
    BREAK_MSGBOX = msgbox('Click OK to END peacefully the simulation. Otherwise minimise the window.','ToBreakSimulation','warn');
    run('eightShape_GlobalVars.m')
    T = simulationTime;
    h = 0.1;
    %t = [0:h:T];


    run('init_8shape_startingThetaAngle.m')

    run('init_carVars.m')
    v = 4.0;
    %Compute Straight Lines Intersections (8shape)
    [intersectX, intersectY] = intersections(Dx1, Dy1, Dx2, Dy2, Ex1, Ey1, Ex2, Ey2);
    % [intersectX, intersectY] = intersectionsV2(Dx1, Dy1, Dx2, Dy2, Ex1, Ey1, Ex2, Ey2);
    
    
    
    %Backup original PID values and Velocity:
    vdo = v;
    
    %Initialize total distance sum as 0:
    sumd = 0;
    %thetad = 0;
    
    %Initialize Cost Variables/Arrays:
    cost = 0;
    costArray = (0:h:T)*0;
    costIndex = 1;

    
    %Initialize Angle Array:
    thetaArray = (0:h:T)*0;
    thetaArray(1) = th;
    thetaIndex = 1;
    
    
    %Initialize the Control Effort Array:
    controlEffortArray = (0:h:T)*0;
    
    
    vehicleImage = -1;
    singleFigure = true;
    

    run('init_LapCounter.m')
    
    hold on
    legend off
    %#############################################
    hold off
    
    
    
    
    %!!!!!!!!!!!!!!!!!!!!!!!
%     L0 = 4;
%     alfa = deg2rad(-5);
%     
%     Kp = 2.55;
    %!!!!!!!!!!!!!!!!!!!!!!!
    Kpo = Kp;
    
    
    


    syms PointX PointY

    xVehicle = [];
    yVehicle = [];
    
    
    %#############################################
    for t = 0:h:T
        drawnow();     %give time for callback

        
        TimeArray = [0:h:t];
        
        %-----------------------------------------
        %Get the state that fits the best concerning
        %the current vehicle position
        state = localizar(x,y, state,...
                                Dx1, Dy1, ...
                                Ex1, Ey1, ...
                                Dx2, Dy2, ...
                                Ex2, Ey2, ...
                                intersectX, intersectY);
        
        %-----------------------------------------
        %state
        %Evaluate the current state and decide wether it should compute 
        %the distance to the straight line or to a curve:
        if (state == 0 || state == 1)               
        %[d, ~, ~ , ~, ~] = dist_reta(Ex1, Ey1, Dx2, Dy2, x, y);    % Parte de cima/baixo da reta E1D2
            [d, lambda1, lambda2, ~, Q] = dist_reta(Dx1, Dy1, Ex2, Ey2, x, y);      % Parte de cima/baixo da reta D1E2
            
            Qx = Q(1);
            Qy = Q(2);
            
            Ax = Dx1;
            Ay = Dy1;
            Bx = Ex2;
            By = Ey2;


%             angleThetaAtan2 = atan2(By-Ay, Bx-Ax);
%             Tx = (distance(Ax,Ay,Qx,Qy)+L0)*cos(angleThetaAtan2)
%             Ty = (distance(Ax,Ay,Qx,Qy)+L0)*sin(angleThetaAtan2)


            m = (Y_reta1(end)-Y_reta1(1))/(X_reta1(end)-X_reta1(1));
            b = Y_reta1(1)-m*X_reta1(1);
            
            eqn1 = PointY == m*PointX + b;
            eqn2 = L0^2 == (Qx-PointX)^2 + (Qy-PointY)^2;
            [sol1, sol2] = solve(eqn1, eqn2, PointX,PointY);
            solucaoX = double(vpa(sol1,3));
            solucaoY = double(vpa(sol2,3));

            Tx = round(max(solucaoX),2);
            Ty = round(max(solucaoY),2);

            
            phid = atan2(Ty - y, Tx - x);


        elseif (state == 3 || state == 4)
            [d, ~, lambda2, ~, Q] = dist_reta(Ex1, Ey1, Dx2, Dy2, x, y);     % Parte de cima/baixo da reta D1E2
            
            Qx = Q(1);
            Qy = Q(2);
            
            Ax = Ex1;
            Ay = Ey1;
            Bx = Dx2;
            By = Dy2;

            m = (Y_reta2(end)-Y_reta2(1))/(X_reta2(end)-X_reta2(1));
            b = Y_reta2(1)-m*X_reta2(1);
            
            eqn1 = PointY == m*PointX + b;
            eqn2 = L0^2 == (Qx-PointX)^2 + (Qy-PointY)^2;
            
            [sol1, sol2] = solve(eqn1, eqn2, PointX,PointY);
            solucaoX = double(vpa(sol1,3));
            solucaoY = double(vpa(sol2,3));

            Tx = round(min(solucaoX),2);
            Ty = round(max(solucaoY),2);

            
         
            phid = atan2(Ty - y, Tx - x);
            
        elseif (state == 2)
            [d, ~, Q, eq] = dist_arco(Cx2,Cy2,R2,x,y);
            
            Qx = Q(1);
            Qy = Q(2);
            
            beta = atan2(y - Cy2, x - Cx2);
            targetAheadAngle = beta + alfa;


            Tx = Cx2 + R1 * cos(targetAheadAngle);
            Ty = Cy2 + R1 * sin(targetAheadAngle);

            phid = atan2(Ty - y, Tx - x);
    
            
        elseif (state == 5)
            [d, ~, Q, eq] = dist_arco(Cx1,Cy1,R1,x,y);
            
            Qx = Q(1);
            Qy = Q(2);
            
            beta = atan2(Qy - Cy1, Qx - Cx1);

            targetAheadAngle = beta - alfa;


            Tx = Cx1 + R1 * cos(targetAheadAngle);
            Ty = Cy1 + R1 * sin(targetAheadAngle);
            
            phid = atan2(Ty - y, Tx - x);
        end


            
        
        %-----------------------------------------
        %Euler Discretization of the derivative term
        dd = (d-d_ant)/h;

        %-----------------------------------------
        %Compute the dx,dy,dth and update the variables
        dx = v * cos(th);
        dy = v * sin(th);
        dth = v*(Kp*(phid-th));
        
        x = x + dx*h;
        y = y + dy*h;
        th = th + dth*h;

        sumd = sumd + d; %add the distance (positive or negative)
        d_ant = d; %previous distance
        d;
        %-----------------------------------------
        costArray(costIndex) = abs(d);
        %-----------------------------------------
        %Update the Figures with the new values
        run('figure_8shape_insideFORLoop.m')
       
        %-----------------------------------------
        
        
        
        if (rem(t,T) == 0)
            fprintf("Current Total Cost is %.2 at time %.f\n", sum(costArray), t)
        end
        
        %-----------------------------------------
        
        
        %Short pause so that the vehicle's position
        %is updated and moves (visually) with time
        pause(0.0000000000005)

        
        
        thetaArray(costIndex) = th;
        
        costIndex = costIndex + 1;
        thetaIndex = thetaIndex + 1;
        
        %add the distance (which is the cost) - always absolute (positive)
        %so that we ignore the distance sign variations along the path
        cost = cost + abs(d);

        
        controlEffortArray(costIndex) = Kp*(phid-th);

        if (cost > 99999999)
            continue
        end
        
        if (~ishandle(BREAK_MSGBOX))
            simulationTime = t;
            break
        end

    end %end-for
    %#############################################
    %#############################################
    
    
    
    
    
    if (use2laps == true)
        fprintf("Soma Custo Total Lap-2: %.2f\n", sum(costArray(lap2costStartIndex:end)))
    end
    
    
    
    run('figure_8shape_afterFORLoop_adjustments_M2.m')
    
    
    %Return the Figure Handlers Variables 
    %(useful to makes changes on the obtained Plots in the Matlab terminal)
    handler1 = h1;
    handler3 = h3;
    
    
    %Save Simulation Variables
    run('saveSimulationVars_PID.m')
    save(pwd + "\.simulationVars\" + ".8shapeVars", char(NaN));
end



