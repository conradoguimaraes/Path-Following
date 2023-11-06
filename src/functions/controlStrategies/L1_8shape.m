function [cost,handler1,handler3] = L1_8shape(simulationTime,Px, Py, Dx1, Dy1, Ex2, Ey2, Ex1, Ey1, Dx2, Dy2, R1, R2, Cx1, Cy1, Cx2, Cy2, state, threshold, Q, L1)
    BREAK_MSGBOX = msgbox('Click OK to END peacefully the simulation. Otherwise minimise the window.','ToBreakSimulation','warn');
    run('eightShape_GlobalVars.m')
    T = simulationTime;
    h = 0.1;
    %t = [0:h:T];


    run('init_8shape_startingThetaAngle.m')

    run('init_carVars.m')
    v = 1.0;
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
    
    


% 
%     syms PointX PointY
% 
    xVehicle = [];
    yVehicle = [];
    
    
    %#############################################
    for t = 0:h:T
        drawnow();

        
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
        if (state == 0)
            [d, ~, ~, ~, Q] = dist_reta(Dx1, Dy1, Ex2, Ey2, x, y);      % Parte de cima/baixo da reta D1E2
            %If we are at state 0 we look only at the XY
            %Points which are part of this state
            %or the next state (1)
            
            circleEq = (reta1Xvector - x).^2 + (reta1Yvector - y).^2;
            nearValues = L1^2 - circleEq;
            nearZero = nearValues(nearValues>=0);
            nearZero = sort(nearZero);
            index1 = find(nearValues == nearZero(1));
            index2 = find(nearValues == nearZero(2));
            
            element1X = reta1Xvector(index1);
            element1Y = reta1Yvector(index1);
            
            element2X = reta1Xvector(index2);
            element2Y = reta1Yvector(index2);
            
            if (element1X > element2X)
                Tx = element1X;
                Ty = element1Y;
            else
                Tx = element2X;
                Ty = element2Y;
            end
        
        elseif (state == 1)
            [d, ~, ~, ~, Q] = dist_reta(Dx1, Dy1, Ex2, Ey2, x, y);
            %If we are at state 1 we look only at the XY
            %Points which are part of this state
            %or the next state (2)
            
            circleEq = (reta1Xvector - x).^2 + (reta1Yvector - y).^2;
            nearValuesLine = L1^2 - circleEq;
            nearZeroLine = nearValuesLine(nearValuesLine>=0);
            nearZeroLine = sort(nearZeroLine);
            index1 = find(nearValuesLine == nearZeroLine(1));
            
            element1X = reta1Xvector(index1);
            element1Y = reta1Yvector(index1);
            
            
            try
                circleEq = (Xarc2 - x).^2 + (Yarc2 - y).^2;
                nearValuesArc = L1^2 - circleEq;
                nearZeroArc = nearValuesArc(nearValuesArc>=0);
                nearZeroArc = sort(nearZeroArc);
                index2 = find(nearValuesArc == nearZeroArc(1));
                element2X = Xarc2(index2);
                element2Y = Yarc2(index2);
            catch
                %It means that the arc is not reachable yet
                index2 = find(nearValuesLine == nearZeroLine(2));
                element2X = reta1Xvector(index2);
                element2Y = reta1Yvector(index2);
            end
            
            if (element1X > element2X)
                Tx = element1X;
                Ty = element1Y;
            else
                Tx = element2X;
                Ty = element2Y;
            end
            
        
        elseif (state == 2)
            [d, ~, Q, eq] = dist_arco(Cx2,Cy2,R2,x,y);
            %If we are at state 2 we look only at the XY
            %Points which are part of this state
            %or the next state (3)
            
            circleEq = (Xarc2 - x).^2 + (Yarc2 - y).^2;
            nearValuesArc = L1^2 - circleEq;
            nearZeroArc = nearValuesArc(nearValuesArc>=0);
            nearZeroArc = sort(nearZeroArc);
 
            index1 = find(nearValuesArc == nearZeroArc(1));
            element1X = Xarc2(index1);
            element1Y = Yarc2(index1);

             try
                circleEq = (reta2Xvector - x).^2 + (reta2Yvector - y).^2;
                nearValuesLine = L1^2 - circleEq;
                nearZeroLine = nearValuesLine(nearValuesLine>=0);
                nearZeroLine = sort(nearZeroLine);
                index2 = find(nearValuesLine == nearZeroLine(1));

                element2X = reta2Xvector(index2);
                element2Y = reta2Yvector(index2);
            catch
                %It means that the line is not reachable yet
                index2 = find(nearValuesArc == nearZeroArc(2));
                element2X = Xarc2(index2);
                element2Y = Yarc2(index2);
            end

            if (element2X < element1X && element2Y < element1Y)
                Tx = element2X;
                Ty = element2Y;
            else
                Tx = element1X;
                Ty = element1Y;
            end

            
            
        elseif (state == 3)
            [d, ~, lambda2, ~, Q] = dist_reta(Ex1, Ey1, Dx2, Dy2, x, y);
            %If we are at state 3 we look only at the XY
            %Points which are part of this state
            %or the next state (4)

            circleEq = (reta2Xvector - x).^2 + (reta2Yvector - y).^2;
            nearValues = L1^2 - circleEq;
            nearZero = nearValues(nearValues>=0);
            nearZero = sort(nearZero);
            index1 = find(nearValues == nearZero(1));
            index2 = find(nearValues == nearZero(2));
            
            element1X = reta2Xvector(index1);
            element1Y = reta2Yvector(index1);
            
            element2X = reta2Xvector(index2);
            element2Y = reta2Yvector(index2);
            
            if (element1X < element2X)
                Tx = element1X;
                Ty = element1Y;
            else
                Tx = element2X;
                Ty = element2Y;
            end
        
            
            
        elseif (state == 4)
            [d, ~, lambda2, ~, Q] = dist_reta(Ex1, Ey1, Dx2, Dy2, x, y);
            %If we are at state 4 we look only at the XY
            %Points which are part of this state
            %or the next state (5)
            
            circleEq = (reta2Xvector - x).^2 + (reta2Yvector - y).^2;
            nearValuesLine = L1^2 - circleEq;
            nearZeroLine = nearValuesLine(nearValuesLine>=0);
            nearZeroLine = sort(nearZeroLine);
            index1 = find(nearValuesLine == nearZeroLine(1));
            
            element1X = reta2Xvector(index1);
            element1Y = reta2Yvector(index1);
            
            
            try
                circleEq = (Xarc1 - x).^2 + (Yarc1 - y).^2;
                nearValuesArc = L1^2 - circleEq;
                nearZeroArc = nearValuesArc(nearValuesArc>=0);
                nearZeroArc = sort(nearZeroArc);
                index2 = find(nearValuesArc == nearZeroArc(1));
                element2X = Xarc1(index2);
                element2Y = Yarc1(index2);
            catch
                %It means that the arc is not reachable yet
                index2 = find(nearValuesLine == nearZeroLine(2));
                element2X = reta2Xvector(index2);
                element2Y = reta2Yvector(index2);
            end
                
            if (element1X < element2X)
                Tx = element1X;
                Ty = element1Y;
            else
                Tx = element2X;
                Ty = element2Y;
            end
            
            
        elseif (state == 5)
            [d, ~, Q, eq] = dist_arco(Cx1,Cy1,R1,x,y);
            %If we are at state 5 we look only at the XY
            %Points which are part of this state
            %or the next state (1)
            
            circleEq = (Xarc1 - x).^2 + (Yarc1 - y).^2;
            nearValuesArc = L1^2 - circleEq;
            nearZeroArc = nearValuesArc(nearValuesArc>=0);
            nearZeroArc = sort(nearZeroArc);
 
            index1 = find(nearValuesArc == nearZeroArc(1));
            element1X = Xarc1(index1);
            element1Y = Yarc1(index1);

             try
                circleEq = (reta1Xvector - x).^2 + (reta1Yvector - y).^2;
                nearValuesLine = L1^2 - circleEq;
                nearZeroLine = nearValuesLine(nearValuesLine>=0);
                nearZeroLine = sort(nearZeroLine);
                index2 = find(nearValuesLine == nearZeroLine(1));

                element2X = reta1Xvector(index2);
                element2Y = reta1Yvector(index2);
            catch
                %It means that the line is not reachable yet
                index2 = find(nearValuesArc == nearZeroArc(2));
                element2X = Xarc1(index2);
                element2Y = Yarc1(index2);
            end

            if (element2X < element1X && element2Y < element1Y)
                Tx = element2X;
                Ty = element2Y;
            else
                Tx = element1X;
                Ty = element1Y;
            end
        end

        
        %Angle Point-Target
        anglePT = atan2(Ty-y, Tx-x);
        
        %Eta
        eta = anglePT - th;
        rad2deg(eta);
        
        %acceleration
        ascmd = (2*v^2*sin(eta))/L1;
            
            
            
        
        %-----------------------------------------
        %Euler Discretization of the derivative term
        dd = (d-d_ant)/h;

        %-----------------------------------------
        %Compute the dx,dy,dth and update the variables
        dx = v * cos(th);
        dy = v * sin(th);
%         dth = v*(Kp*(phid-th));
        dth = ascmd;
        
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

        
        controlEffortArray(costIndex) = ascmd;

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
    
    
    run('figure_8shape_afterFORLoop_adjustments_M3.m')
    
    
    %Return the Figure Handlers Variables 
    %(useful to makes changes on the obtained Plots in the Matlab terminal)
    handler1 = h1;
    handler3 = h3;
    
    
    %Save Simulation Variables
    run('saveSimulationVars_PID.m')
    save(pwd + "\.simulationVars\" + ".8shapeVars", char(NaN));
end



