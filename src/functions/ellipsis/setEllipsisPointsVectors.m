function set8shapePointsVectors()
    %Percurso: Reta2-Arco-Reta1-Arco
    %Corrigir o sentido dos arrays:
    %Arco-2 (sentido descendente) : flip(arc2)
    %Reta-2 (sentido ascendente) : flip(reta2)
    global PontosX PontosY
    global reta1Xvector reta1Yvector
    global reta2Xvector reta2Yvector
    global Xarc1 Yarc1
    global Xarc2 Yarc2
    
%     PontosX = [reta1Xvector, flip(Xarc2), reta2Xvector, Xarc1];
%     PontosY = [reta1Yvector, flip(Yarc2), reta2Yvector, Yarc1];
    PontosX = [reta2Xvector, flip(Xarc2), reta1Xvector, Xarc1];
    PontosY = [reta2Yvector, flip(Yarc2), reta1Yvector, Yarc1];
end