function fixRCPLineVectors()
    %Passar as retas para arrays de muitos pontos
    %para depois os percorrermos no ciclo while
    
    global Xarc2
    
    global LineA1B1x LineA1B1y
    global LineB2C1x LineB2C1y
    global LineC2D1x LineC2D1y
    global LineD2E1x LineD2E1y
    global LineE2F1x LineE2F1y
    global LineF2G1x LineF2G1y
    global LineG2H1x LineG2H1y
    global LineH2I1x LineH2I1y
    global LineI2J1x LineI2J1y
    global LineJ2A2x LineJ2A2y
    
    
    global reta1Xvector reta1Yvector
    global reta2Xvector reta2Yvector
    global reta3Xvector reta3Yvector
    global reta4Xvector reta4Yvector
    global reta5Xvector reta5Yvector
    global reta6Xvector reta6Yvector
    global reta7Xvector reta7Yvector
    global reta8Xvector reta8Yvector
    global reta9Xvector reta9Yvector
    global reta10Xvector reta10Yvector

    reta1Xvector = linspace(LineA1B1x(1), LineA1B1x(end), length(Xarc2));
    reta1Yvector = linspace(LineA1B1y(1), LineA1B1y(end), length(Xarc2));

    reta2Xvector = linspace(LineB2C1x(1), LineB2C1x(end), length(Xarc2));
    reta2Yvector = linspace(LineB2C1y(1), LineB2C1y(end), length(Xarc2));

    reta3Xvector = linspace(LineC2D1x(1), LineC2D1x(end), length(Xarc2));
    reta3Yvector = linspace(LineC2D1y(1), LineC2D1y(end), length(Xarc2));

    reta4Xvector = linspace(LineD2E1x(1), LineD2E1x(end), length(Xarc2));
    reta4Yvector = linspace(LineD2E1y(1), LineD2E1y(end), length(Xarc2));

    reta5Xvector = linspace(LineE2F1x(1), LineE2F1x(end), length(Xarc2));
    reta5Yvector = linspace(LineE2F1y(1), LineE2F1y(end), length(Xarc2));

    reta6Xvector = linspace(LineF2G1x(1), LineF2G1x(end), length(Xarc2));
    reta6Yvector = linspace(LineF2G1y(1), LineF2G1y(end), length(Xarc2));

    reta7Xvector = linspace(LineG2H1x(1), LineG2H1x(end), length(Xarc2));
    reta7Yvector = linspace(LineG2H1y(1), LineG2H1y(end), length(Xarc2));

    reta8Xvector = linspace(LineH2I1x(1), LineH2I1x(end), length(Xarc2));
    reta8Yvector = linspace(LineH2I1y(1), LineH2I1y(end), length(Xarc2));

    reta9Xvector = linspace(LineI2J1x(1), LineI2J1x(end), length(Xarc2));
    reta9Yvector = linspace(LineI2J1y(1), LineI2J1y(end), length(Xarc2));

    reta10Xvector = linspace(LineJ2A2x(1), LineJ2A2x(end), length(Xarc2));
    reta10Yvector = linspace(LineJ2A2y(1), LineJ2A2y(end), length(Xarc2));
    
    
end