function [cost,handler1,handler3] = CostControl_RCP_PID_KpKdKi(simulationTime,Px, Py, state, Kp, Kd, Ki, threshold, Q)
    run('rcp_GlobalVars.m')
    
    T = simulationTime;
    h = 0.1;
    %t = [0:h:T];

    
    run('init_RCP_startingThetaAngle.m')
    run('init_carVars_RCP.m')
    
    
    
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

    
    %Initialize Angle Array:
    thetaArray = (0:h:T)*0;
    thetaArray(1) = th;
    thetaIndex = 1;
    
    
    vehicleImage = -1;
    singleFigure = true;
    

    run('init_LapCounter.m')
    
    hold on
    legend off
    %Initialize the Control Effort Array:
    controlEffortArray = (0:h:T)*0;
    
    finishingLineX = 103;
    finishingLineY = 31;
    passedState19 = false;
    %#############################################
    %#############################################
    for t = 0:h:T
        TimeArray = [0:h:t];
        
        %-----------------------------------------
        %Get the state that fits the best concerning
        %the current vehicle position
        state = localizarRCP(x,y, state);
        
        if (false)
            %Manual Input
            h1=subplot(1,2,1); hold on, grid on
            xPoints = [];
            yPoints = [];
            for k = 1:1:100
                Px = input('Px= ');
                Py = input('Py= ');
                if (length(Px) == 0)
                    Px = xPoints(end) + 5;
                elseif (Px == -1)
                    Px = xPoints(end);
                end
                if (length(Py) == 0)
                    Py = yPoints(end) + 5;
                elseif (Py == -1)
                    Py = yPoints(end);
                end
                Px
                Py

                xPoints = [xPoints, Px];
                yPoints = [yPoints, Py];
                plot(h1,xPoints,yPoints,'*y');
                state = localizarRCP(Px,Py, state)
                title(h1,"State = "+string(state))
            end
        end
        
        %-----------------------------------------
        %Evaluate the current state and decide wether it should compute 
        %the distance to the straight line or to a curve:
        if (state == 0)               
            [d, ~, lambda2, ~, Q] = dist_reta_rcp(PA1x, PA1y, PB1x, PB1y, x, y);

            if(lambda2 <= 0)
                d = d*(-1);
            end
            
            curvatura = 0;
            v = vdo;
            Kd = Kdo;
            Kp = Kpo;
            
        elseif (state == 1)
            [d, ~, Q, eq] = dist_arco(Cx2,Cy2,R2,x,y);

%             if(eq < R2^2)
%                 curvatura = 1/R2;
%             else
%                 d = d*(-1);
%                 curvatura = -1/R2;
%             end
            if(eq < R1^2)
                d = d*(-1);
                curvatura = -1/R2;
            else
                curvatura = 1/R2;
            end

            %d = d*(-1);
            Kd = Kdo;
            Kp = Kpo;
            v = vdo;
            
        elseif (state == 2)               
            [d, ~, lambda2, ~, Q] = dist_reta_rcp(PB2x, PB2y, PC1x, PC1y, x, y);

            if(lambda2 <= 0)
                d = d*(-1);
            end
            
            curvatura = 0;
            v = vdo;
            Kd = Kdo;
            Kp = Kpo;
            
        elseif (state == 3)
            [d, ~, Q, eq] = dist_arco(Cx3,Cy3,R3,x,y);

%             if(eq < R2^2)
%                 curvatura = 1/R2;
%             else
%                 d = d*(-1);
%                 curvatura = -1/R2;
%             end
            if(eq < R3^2)
                d = d*(-1);
                curvatura = -1/R3;
            else
                curvatura = 1/R3;
            end

            %d = d*(-1);
            Kd = Kdo;
            Kp = Kpo;
            v = vdo;
            
        elseif (state == 4)               
            [d, ~, lambda2, ~, Q] = dist_reta_rcp(PC2x, PC2y, PD1x, PD1y, x, y);

            if(lambda2 <= 0)
                d = d*(-1);
            end
            
            curvatura = 0;
            v = vdo;
            Kd = Kdo;
            Kp = Kpo;
            
        elseif (state == 5)
            [d, ~, Q, eq] = dist_arco(Cx4,Cy4,R4,x,y);

            if(eq < R4^2)
                curvatura = 1/R4;
            else
                d = d*(-1);
                curvatura = -1/R4;
            end
%             if(eq < R4^2)
%                 d = d*(-1);
%                 curvatura = -1/R4;
%             else
%                 curvatura = 1/R4;
%             end

            %d = d*(-1);
            Kd = Kdo;
            Kp = Kpo;
            v = vdo;
            
        elseif (state == 6)               
            [d, ~, lambda2, ~, Q] = dist_reta_rcp(PD2x, PD2y, PE1x, PE1y, x, y);

            if(lambda2 <= 0)
                d = d*(-1);
            end
            
            curvatura = 0;
            v = vdo;
            Kd = Kdo;
            Kp = Kpo;
            
        elseif (state == 7)
            [d, ~, Q, eq] = dist_arco(Cx5,Cy5,R5,x,y);

            if(eq < R5^2)
                curvatura = 1/R5;
            else
                d = d*(-1);
                curvatura = -1/R5;
            end
%             if(eq < R5^2)
%                 d = d*(-1);
%                 curvatura = -1/R5;
%             else
%                 curvatura = 1/R5;
%             end

            %d = d*(-1);
            Kd = Kdo;
            Kp = Kpo;
            v = vdo;
            
        elseif (state == 8)               
            [d, ~, lambda2, ~, Q] = dist_reta_rcp(PE2x, PE2y, PF1x, PF1y, x, y);

            if(lambda2 <= 0)
                d = d*(-1);
            end
            
            curvatura = 0;
            v = vdo;
            Kd = Kdo;
            Kp = Kpo;
            
        elseif (state == 9)
            [d, ~, Q, eq] = dist_arco(Cx6,Cy6,R6,x,y);

%             if(eq < R2^2)
%                 curvatura = 1/R2;
%             else
%                 d = d*(-1);
%                 curvatura = -1/R2;
%             end
            if(eq < R6^2)
                d = d*(-1);
                curvatura = -1/R6;
            else
                curvatura = 1/R6;
            end

            %d = d*(-1);
            Kd = Kdo;
            Kp = Kpo;
            v = vdo;
            
        elseif (state == 10)               
            [d, ~, lambda2, ~, Q] = dist_reta_rcp(PF2x, PF2y, PG1x, PG1y, x, y);

            if(lambda2 <= 0)
                d = d*(-1);
            end
            
            curvatura = 0;
            v = vdo;
            Kd = Kdo;
            Kp = Kpo;
            
        elseif (state == 11)
            [d, ~, Q, eq] = dist_arco(Cx7,Cy7,R7,x,y);

%             if(eq < R7^2)
%                 curvatura = 1/R7;
%             else
%                 d = d*(-1);
%                 curvatura = -1/R7;
%             end
            if(eq < R7^2)
                d = d*(-1);
                curvatura = -1/R7;
            else
                curvatura = 1/R7;
            end

            %d = d*(-1);
            Kd = Kdo;
            Kp = Kpo;
            v = vdo;
            
        elseif (state == 12)               
            [d, ~, lambda2, ~, Q] = dist_reta_rcp(PG2x, PG2y, PH1x, PH1y, x, y);

            if(lambda2 <= 0)
                d = d*(-1);
            end
            
            curvatura = 0;
            v = vdo;
            Kd = Kdo;
            Kp = Kpo;
            
        elseif (state == 13)
            [d, ~, Q, eq] = dist_arco(Cx8,Cy8,R8,x,y);

%             if(eq < R8^2)
%                 curvatura = 1/R8;
%             else
%                 d = d*(-1);
%                 curvatura = -1/R8;
%             end
            if(eq < R8^2)
                d = d*(-1);
                curvatura = -1/R8;
            else
                curvatura = 1/R8;
            end

            %d = d*(-1);
            Kd = Kdo;
            Kp = Kpo;
            v = vdo;
            
        elseif (state == 14)               
            [d, ~, lambda2, ~, Q] = dist_reta_rcp(PH2x, PH2y, PI1x, PI1y, x, y);

            if(lambda2 <= 0)
                d = d*(-1);
            end
            
            curvatura = 0;
            v = vdo;
            Kd = Kdo;
            Kp = Kpo;
            
        elseif (state == 15)
            [d, ~, Q, eq] = dist_arco(Cx9,Cy9,R9,x,y);

            if(eq < R9^2)
                curvatura = 1/R9;
            else
                d = d*(-1);
                curvatura = -1/R9;
            end
%             if(eq < R9^2)
%                 d = d*(-1);
%                 curvatura = -1/R9;
%             else
%                 curvatura = 1/R9;
%             end

            %d = d*(-1);
            Kd = Kdo;
            Kp = Kpo;
            v = vdo;
            
        elseif (state == 16)               
            [d, ~, lambda2, ~, Q] = dist_reta_rcp(PI2x, PI2y, PJ1x, PJ1y, x, y);

            if(lambda2 <= 0)
                d = d*(-1);
            end
            
            curvatura = 0;
            v = vdo;
            Kd = Kdo;
            Kp = Kpo;
            
        elseif (state == 17)
            [d, ~, Q, eq] = dist_arco(Cx10,Cy10,R10,x,y);

%             if(eq < R2^2)
%                 curvatura = 1/R2;
%             else
%                 d = d*(-1);
%                 curvatura = -1/R2;
%             end
            if(eq < R10^2)
                d = d*(-1);
                curvatura = -1/R10;
            else
                curvatura = 1/R10;
            end

            %d = d*(-1);
            Kd = Kdo;
            Kp = Kpo;
            v = vdo;
            
        elseif (state == 18)               
            [d, ~, lambda2, ~, Q] = dist_reta_rcp(PJ2x, PJ2y, PA2x, PA2y, x, y);

            if(lambda2 <= 0)
                d = d*(-1);
            end
            
            curvatura = 0;
            v = vdo;
            Kd = Kdo;
            Kp = Kpo;
            
        elseif (state == 19)
            [d, ~, Q, eq] = dist_arco(Cx1,Cy1,R1,x,y);

%             if(eq < R2^2)
%                 curvatura = 1/R2;
%             else
%                 d = d*(-1);
%                 curvatura = -1/R2;
%             end
            if(eq < R1^2)
                d = d*(-1);
                curvatura = -1/R1;
            else
                curvatura = 1/R1;
            end

            %d = d*(-1);
            Kd = Kdo;
            Kp = Kpo;
            v = vdo;
            
            passedState19 = true;
        end
        


        
        
        %-----------------------------------------
        %Euler Discretization of the derivative term
        dd = (d-d_ant)/h;


        %-----------------------------------------
        %Apply the PID Formulation:
%         if (state == 0 || state == 1 || state == 5)
%             c = Kp*d + Kd*dd + Ki*sumd + curvatura;
%         elseif (state == 3 || state == 4 || state == 2)
%             c = Kp*d + Kd*dd - Ki*sumd + curvatura;
%         end
        if (state == 0 || state == 1 || state == 2 || state == 3 || state == 6 || state == 16)
            c = Kp*d + Kd*dd + Ki*sumd + curvatura;
        elseif (state == 4 || state == 5  || state == 7)
            c = Kp*d + Kd*dd - Ki*sumd + curvatura;
        elseif (state == 8 || state == 9 || state == 10 || state == 11 || state == 13 || state == 17)
            c = Kp*d + Kd*dd + Ki*sumd + curvatura;
        elseif (state == 12 || state == 14 || state == 15 || state == 18 || state == 19)
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
        costArray(costIndex) = abs(d);
        %-----------------------------------------
        %Update the Figures with the new values
        run('figure_RCP_insideFORLoop.m')
%         if (costIndex == 100)
%             plot(h1,Q(1),Q(2),'oy')
%         end
        %-----------------------------------------
        
        
        
        if (rem(t,T) == 0)
            fprintf("Current Total Cost is %.2 at time %.f\n", sum(costArray), t)
        end
        
        %-----------------------------------------
        
        
        %Short pause so that the vehicle's position
        %is updated and moves (visually) with time
        pause(0.0000000000005)

        
        
        thetaArray(1) = th;
        
        costIndex = costIndex + 1;
        thetaIndex = thetaIndex + 1;
        
        %add the distance (which is the cost) - always absolute (positive)
        %so that we ignore the distance sign variations along the path
        cost = cost + abs(d);


        controlEffortArray(costIndex) = c;
        if (cost > 99999999)
            continue
        end
        

        if (passedState19 && x > finishingLineX)
            break %Track completed!
        end

    end %end-for
    %#############################################
    %#############################################
    
    fprintf("Simulation Loop ended!\n")
    
    
    
    if (use2laps == true)
        fprintf("Soma Custo Total Lap-2: %.2f\n", sum(costArray(lap2costStartIndex:end)))
    end
    
    
    
    run('figure_RCP_afterFORLoop_adjustments.m')
    
    
    %Return the Figure Handlers Variables 
    %(useful to makes changes on the obtained Plots in the Matlab terminal)
    handler1 = h1;
    handler3 = h3;
    
    
    %Save Simulation Variables (uncomment)
    fprintf("Saving simulation variables...\n")
    run('saveSimulationVars_PID.m')
    save(pwd + "\.simulationVars\" + ".RCP", char(NaN));
end



