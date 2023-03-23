function LState = localizar2(Px,Py, state,...
                            Dx1, Dy1, ...
                            Ex1, Ey1, ...
                            Dx2, Dy2, ...
                            Ex2, Ey2, ...
                            intersectX, intersectY)
    
    
    
	
	%Formato: LState = (Expressão Lógica) * EstadoDesejadoSeForVerdadeiro
	LState = (state==0 && Px >= Dx1 && Py < intersectY); %mantém o Estado 0
	if (LState == 1)
        LState = 0;
		return
	end
	
	LState = (state == 0 && Px >= intersectX && Px < Ex2 && Py >= intersectY) * 1;
	if (LState == 1)
		return
	end
	
	LState = (state == 1 && Px >= intersectX && Px < Ex2 && Py >= intersectY) * 1;
	if (LState == 1)
		return
	end
	
	LState = (state == 1 && (Px >= Ex2 || Px >= Ex1)) * 2;
	if (LState == 2)
		return
	end
	LState = (state == 2 && (Px >= Ex2 || Px >= Ex1)) * 2;
	if (LState == 2)
		return
	end
	
	LState = (state == 2 && Px < Ex1 && Px >= intersectX && Py <= intersectY) * 3;
	if (LState == 3)
		return
	end
	LState = (state == 3 && Px < Ex1 && Px >= intersectX && Py <= intersectY) * 3;
	if (LState == 3)
		return
	end
	
	LState = (state == 3 && Px <= intersectX && Px > Dx2 && Py >= intersectY) * 4;
	if (LState == 4)
		return
	end
	LState = (state == 4 && Px <= intersectX && Px > Dx2 && Py >= intersectY) * 4;
	if (LState == 4)
		return
	end
                       
	LState = (state == 4 && (Px < Dx2 || Px < Dx1)) * 5;
	if (LState == 5)
		return
	end
	LState = (state == 5 && (Px < Dx2 || Px < Dx1)) * 5;
	if (LState == 5)
		return
	end
	
	LState = (state == 5 && Px >= Dx1 && Py < intersectY);
	if (LState == 1)
        LState = 0; %Voltar ao Estado 0
		return
	end

    
	LState = state;
    
end