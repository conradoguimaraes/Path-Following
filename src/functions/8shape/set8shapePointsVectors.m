function set8shapePointsVectors()
    %Percurso: Reta1-Arco-Reta2-Arco
    %Corrigir o sentido dos arrays:
    %Arco-2 (sentido descendente) : flip(arc2)
    %Reta-2 (sentido ascendente) : flip(reta2)
    global PontosX PontosY
    global reta1Xvector reta1Yvector
    global reta2Xvector reta2Yvector
    global Xarc1 Yarc1
    global Xarc2 Yarc2
    
    PontosX = [reta1Xvector, flip(Xarc2), flip(reta2Xvector), Xarc1];
    PontosY = [reta1Yvector, flip(Yarc2), flip(reta2Yvector), Yarc1];
end