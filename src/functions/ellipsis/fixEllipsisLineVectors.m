function fix8shapeLineVectors()
    %Passar as retas para arrays de muitos pontos
    %para depois os percorrermos no ciclo while
    global X_reta1 Y_reta1
    global X_reta2 Y_reta2
    
    global Xarc2
    
    global reta1Xvector reta1Yvector
    global reta2Xvector reta2Yvector

    reta1Xvector = linspace(X_reta1(1), X_reta1(2), length(Xarc2));
    reta1Yvector = linspace(Y_reta1(1), Y_reta1(2), length(Xarc2));

    reta2Xvector = linspace(X_reta2(1), X_reta2(2), length(Xarc2));
    reta2Yvector = linspace(Y_reta2(1), Y_reta2(2), length(Xarc2));
end