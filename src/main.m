%%

run('init.m')

shapes = ["8shape", "ellipsis","rcp"];


shape = shapes(3);
method = 3



% profile on
simulationTime = askSimulationTime();


if (shape == "8shape")
    run('eightShape_GlobalVars.m')
    run('eightShape_Params.m')
    run('eightShape_Path.m')
    draw8shape()
    fix8shapeLineVectors()
    set8shapePointsVectors()
    run('compute8ShapePathLength.m')
    
    startingPoint(22,8)
%     startingPoint(20,25)
%     startingPoint(20,12)
%     startingPoint(60,23)
%     startingPoint(15,23)
    [intersectX, intersectY] = intersections(Dx1, Dy1, Dx2, Dy2, Ex1, Ey1, Ex2, Ey2);
    [state, Q, d] = initialState(Pxatual,Pyatual, ...
                              Dx1, Dy1, Ex1, Ey1, Dx2, Dy2, Ex2, Ey2, ...
                              Cx1, Cy1, Cx2 , Cy2, R1, R2, ...
                              intersectX, delta)
%     
%     %run('setPIDparams.m')
    
    custo = 0;
    threshold = d;
    
    
    
    if (method == 1)
        fprintf("Running Method-1.\n")
        Kp = 17
        Ki = 0.11
        Kd = 27.3
        [custo,h1,h3] = CostControl_8shape_PID_KpKdKi(simulationTime,Pxatual, Pyatual, ...
                    Dx1, Dy1, Ex2, Ey2, Ex1, Ey1, Dx2, Dy2, ... 
                    R1, R2, Cx1, Cy1, Cx2, Cy2, ...
                    state, Kp, Kd, Ki, threshold, Q)
    
        figureFilename = "8shape_"+"t"+string(simulationTime)+"s_"+...
                               "kp"+string(Kp)+"_"+...
                               "ki"+string(Ki)+"_"+...
                               "kd"+string(Kd);
    elseif (method == 2)
        fprintf("Running Method-2.\n")
        L0 = 4
        Kp = 2.55
        alfa = deg2rad(-5)
        [custo,h1,h3] = CarrotChase_8shape(simulationTime,Pxatual, Pyatual, ...
                    Dx1, Dy1, Ex2, Ey2, Ex1, Ey1, Dx2, Dy2, ... 
                    R1, R2, Cx1, Cy1, Cx2, Cy2, ...
                    state,threshold, Q, L0, Kp, alfa)
    
        figureFilename = "8shape_M2_"+"t"+string(simulationTime)+"s_"+...
                               "L0"+string(L0)+"_"+...
                               "Kp"+string(Kp)+"_"+...
                               "alfa"+string(alfa);
    
    elseif (method == 3)
        fprintf("Running Method-3.\n")
        L1 = 3
        [custo,h1,h3] = L1_8shape(simulationTime,Pxatual, Pyatual, ...
                    Dx1, Dy1, Ex2, Ey2, Ex1, Ey1, Dx2, Dy2, ... 
                    R1, R2, Cx1, Cy1, Cx2, Cy2, ...
                    state,threshold, Q, L1)
    
        figureFilename = "8shape_M3_"+"t"+string(simulationTime)+"s_"+...
                               "L1"+string(L1);
    end
    
    
    
                       
elseif (shape == "ellipsis")
    run('ellipsis_GlobalVars.m')
    run('ellipsis_Params.m')
    run('ellipsis_Path.m')
    drawEllipsis()
    fixEllipsisLineVectors()
    setEllipsisPointsVectors()
    run('computeEllipsisPathLength.m')
    
    
    %Linha de cima
    startingPoint(15,28)
    
    %Linha de baixo
%     startingPoint(45,3)
    
    %Arco esquerdo
%     startingPoint(-2, 10)
    
    %Arco direito
%     startingPoint(60, 23)


%     startingPoint(20,0)
%     startingPoint(0,6)
    [state, Q, d] = initialStateEllipsis(Pxatual,Pyatual, ...
                              Dx1, Dy1, Ex1, Ey1, Dx2, Dy2, Ex2, Ey2, ...
                              Cx1, Cy1, Cx2 , Cy2, R1, R2,delta)
    
    %run('setPIDparams.m');
    
    
    custo = 0;
    threshold = d;
    
    if (method == 1)
        fprintf("Running Method-1.\n")
        Kp = 19
        Ki = 0.075
        Kd = 25
        [custo,h1,h3] = CostControl_Ellipsis_PID_KpKdKi(simulationTime,Pxatual, Pyatual, ...
                Dx1, Dy1, Ex2, Ey2, Ex1, Ey1, Dx2, Dy2, ... 
                R1, R2, Cx1, Cy1, Cx2, Cy2, ...
                state, Kp, Kd, Ki, threshold, Q)
            
        figureFilename = "ellipsis_"+"t"+string(simulationTime)+"s_"+...
                               "kp"+string(Kp)+"_"+...
                               "ki"+string(Ki)+"_"+...
                               "kd"+string(Kd);
    elseif (method == 2)
        fprintf("Running Method-2.\n")
        L0 = 4
        Kp = 2.55
        alfa = deg2rad(-5)
        [custo,h1,h3] = CarrotChase_Ellipsis(simulationTime,Pxatual, Pyatual, ...
                    Dx1, Dy1, Ex2, Ey2, Ex1, Ey1, Dx2, Dy2, ... 
                    R1, R2, Cx1, Cy1, Cx2, Cy2, ...
                    state,threshold, Q, L0, Kp, alfa)
    
        figureFilename = "Ellipsis_M2_"+"t"+string(simulationTime)+"s_"+...
                               "L0"+string(L0)+"_"+...
                               "Kp"+string(Kp)+"_"+...
                               "alfa"+string(alfa);
    
    elseif (method == 3)
        fprintf("Running Method-3.\n")
        L1 = 7
        [custo,h1,h3] = L1_Ellipsis(simulationTime,Pxatual, Pyatual, ...
                    Dx1, Dy1, Ex2, Ey2, Ex1, Ey1, Dx2, Dy2, ... 
                    R1, R2, Cx1, Cy1, Cx2, Cy2, ...
                    state,threshold, Q, L1)
    
        figureFilename = "Ellipsis_M3_"+"t"+string(simulationTime)+"s_"+...
                               "L1"+string(L1);
    end
    
    
            





elseif (shape == "rcp")
    run('rcp_GlobalVars.m')
    run('rcp_Path.m')
    run('rcp_ScalePath.m')
    drawRCP()
    fixRCPLineVectors()
    setRCPPointsVectors()
    
    
    startingPoint(110,20)
%     startingPoint(191,124)
%     startingPoint(309,117)
%     startingPoint(198,151)
%     startingPoint(156,237)

%     subplot(1,2,1)
%     plot(Pxatual,Pyatual,'*r')
    
    run('initialStateRCP.m')
%     plot(Pxatual,Pyatual,'*c')
%     plot([Pxatual,Q(1)],[Pyatual,Q(2)],'-y')
%     title("State = " + string(state))
    
    
    %run('setPIDparams.m');
    Tu = 1.17;
    Ku = 0.5
    
%     Kp = Ku*10*Tu
%     Ki = 0.075*Ku*Tu*10
%     Kd = ((1.2*Ku)/Tu)
    Kp = 14
    Ki = 0.095
    Kd = 22
    
    state
    custo = 0;
    threshold = d;
    
    [custo,h1,h3] = CostControl_RCP_PID_KpKdKi(simulationTime,Px, Py, state, Kp, Kd, Ki, threshold, Q)
            
    figureFilename = "rcpTrack_"+"t"+string(simulationTime)+"s_"+...
                           "kp"+string(Kp)+"_"+...
                           "ki"+string(Ki)+"_"+...
                           "kd"+string(Kd);
            
end



% profile offs
% profile viewer

warning on
warning('Save plot&figure?')
R = input('(1)YES  (else)NO > ');
if (R==1)
    savePlot(figureFilename)
    saveFigure(figureFilename)
end


try
    fprintf("Running AfterSimulation Scripts...\n")
    run('afterSim_DCost_and_ControllEffort.m')
    run('afterSim_HeadingAngles.m')
catch
    fprintf("Error while running AfterSimulation Scripts.\n")
    fprintf("Check if the sim vars were properly saved.\n")
end

warning("End of program.")



