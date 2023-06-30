%%

run('init.m')

shapes = ["8shape", "ellipsis"];
shape = shapes(2);
% profile on
if (shape == "8shape")
    run('eightShape_GlobalVars.m')
    run('eightShape_Params.m')
    run('eightShape_Path.m')
    draw8shape()
    fix8shapeLineVectors()
    set8shapePointsVectors()
    
    
    startingPoint(22,8)
%     startingPoint(20,25)
    
    
    [intersectX, intersectY] = intersections(Dx1, Dy1, Dx2, Dy2, Ex1, Ey1, Ex2, Ey2);
    [state, Q, d] = initialState(Pxatual,Pyatual, ...
                              Dx1, Dy1, Ex1, Ey1, Dx2, Dy2, Ex2, Ey2, ...
                              Cx1, Cy1, Cx2 , Cy2, R1, R2, ...
                              intersectX, delta)
    
    run('setPIDparams.m')
    simulationTime = 160;
    Kp = 17
    Ki = 0.1
    Kd = 27.3
    
    [custo,h1,h3] = CostControl_PD_KpKdKi(simulationTime,Pxatual, Pyatual, ...
                Dx1, Dy1, Ex2, Ey2, Ex1, Ey1, Dx2, Dy2, ... 
                R1, R2, Cx1, Cy1, Cx2, Cy2, ...
                state, Kp, Kd, Ki, threshold, Q)
    
    figureFilename = "8shape_"+"t"+string(simulationTime)+"s_"+...
                           "kp"+string(Kp)+"_"+...
                           "ki"+string(Ki)+"_"+...
                           "kd"+string(Kd);
    
elseif (shape == "ellipsis")
    run('ellipsis_GlobalVars.m')
    run('ellipsis_Params.m')
    run('ellipsis_Path.m')
    drawEllipsis()
    fixEllipsisLineVectors()
    setEllipsisPointsVectors()
    
    
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
    
    run('setPIDparams.m')
    simulationTime = 160;
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
            
end
% profile off
% profile viewer

warning on
warning('Save plot&figure?')
R = input('(1)YES  (else)NO > ');
if (R==1)
    
    savePlot(figureFilename)
    saveFigure(figureFilename)
end
warning("End of program.")



