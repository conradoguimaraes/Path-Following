%%
clc, clear all, close all

%profile on

Cx1 = 10;
Cy1 = 15;
Cx2 = 50;
Cy2 = 15;
R1 = 10;
R2 = 10;

delta = pi/8;

theta1 = [ (pi/2 - delta) : 0.0001 : ((3*pi)/2 + delta) ];
theta2 = [ -(pi/2 + delta) : 0.0001 : (pi/2 + delta) ];

%theta3 = [ -(pi/2 + delta) : 0.0001 : (3*pi)/2 ];

Xarc1 = Cx1+R1*cos(theta1);
Yarc1 = Cy1+R1*sin(theta1);

Xarc2 = Cx2+R2*cos(theta2);
Yarc2 = Cy2+R2*sin(theta2);

%Xarc3 = Cx2+R2*cos(theta3);
%Yarc3 = Cy2+R2*sin(theta3);


Dx1 = Xarc1(length(Xarc1));
Dy1 = Yarc1(length(Yarc1));

Dx2 = Xarc1(1);
Dy2 = Yarc1(1);

Ex1 = Xarc2(1);
Ey1 = Yarc2(1);

Ex2 = Xarc2(length(Xarc2));
Ey2 = Yarc2(length(Yarc2));


X_reta1= [Dx1 Ex2];
Y_reta1= [Dy1 Ey2];
X_reta2= [Dx2 Ex1];
Y_reta2= [Dy2 Ey1];




figure(1)
hold on
grid on
%ffullscreen()

%subplot(1,2,1), hold on
subplot(1,3,1), hold on
% plot(Xarc1,Yarc1,'-r')
% plot(Xarc2,Yarc2,'-r')
% plot(Xarc3,Yarc3,'--r')
% plot(X_reta1,Y_reta1,'-b');
% plot(X_reta2,Y_reta2,'-b');
plot(Xarc1,Yarc1,'-r', Xarc2,Yarc2,'-r', ...
    X_reta1,Y_reta1,'-b', X_reta2,Y_reta2,'-b')


%subplot(1,2,2), hold on
subplot(1,3,2), hold on
plot(Xarc1,Yarc1,'-r', Xarc2,Yarc2,'-r', ...
    X_reta1,Y_reta1,'-b', X_reta2,Y_reta2,'-b')


subplot(1,3,3), hold on
xlabel('time')
ylabel('cross track error')

%FullScreen:
set(gcf, 'Position', get(0, 'Screensize'));

%Passar as retas para arrays de muitos pontos
%para depois os percorrermos no ciclo while
reta1Xvector = linspace(X_reta1(1), X_reta1(2), length(Xarc2));
reta1Yvector = linspace(Y_reta1(1), Y_reta1(2), length(Xarc2));

reta2Xvector = linspace(X_reta2(1), X_reta2(2), length(Xarc2));
reta2Yvector = linspace(Y_reta2(1), Y_reta2(2), length(Xarc2));


% 
% reta1Xvector = linspace(X_reta1(1), X_reta1(2), ceil(39270/6));
% reta1Yvector = linspace(Y_reta1(1), Y_reta1(2), ceil(39270/6));
% 
% reta2Xvector = linspace(X_reta2(1), X_reta2(2), ceil(39270/6));
% reta2Yvector = linspace(Y_reta2(1), Y_reta2(2), ceil(39270/6));



%Percurso: Reta1-Arco-Reta2-Arco
%Corrigir o sentido dos arrays:
%Arco-2 (sentido descendente) : flip(arc2)
%Reta-2 (sentido ascendente) : flip(reta2)
PontosX = [reta1Xvector, flip(Xarc2), flip(reta2Xvector), Xarc1];
PontosY = [reta1Yvector, flip(Yarc2), flip(reta2Yvector), Yarc1];





%Definir um ponto inicial no mapa adicionando um Offset
%para que n�o coincida exatamente com o ponto da curva
startIndex = randi([1 length(PontosX)]);
Pxinicial = PontosX(startIndex) + gerarOffset(rand());
Pyinicial = PontosY(startIndex) + gerarOffset(rand());


%Pxatual = Pxinicial
%Pyatual = Pyinicial


%Pxatual = 15;  %Pxinicial
%Pyatual = 13;  %Pyinicial


Pxatual = 20 + 2*round(randn,2)  %Pxinicial
Pyatual = 11 + 2*round(randn,2)  %Pyinicial

%Obter a interse��o das duas retas:
%[intersectX, intersectY] = intersections(Dx1, Dy1, Dx2, Dy2, Ex1, Ey1, Ex2, Ey2);
[intersectX, intersectY] = intersections(Dx1, Dy1, Dx2, Dy2, Ex1, Ey1, Ex2, Ey2);
%Obter o estado inicial:

%Estado 0: tri�ngulo inferior esquerdo
%Estado 1: tri�ngulo superior direito
%Estado 2: arco-2 (o da direita)
%Estado 3: tri�ngulo inferior direito
%Estado 4: tri�ngulo superior esquerdo
%Estado 5: arco-1 (o da esquerda)
[state, Q, d] = initialState(Pxatual,Pyatual, ...
                          Dx1, Dy1, Ex1, Ey1, Dx2, Dy2, Ex2, Ey2, ...
                          Cx1, Cy1, Cx2 , Cy2, R1, R2, ...
                          intersectX, delta)
% subplot(1,2,1)
% plot(Pxatual,Pyatual,'.-c')
% plot(Q(1), Q(2),'.-r')
% plot([Pxatual Q(1)], [Pyatual Q(2)], ':m')




%Control_PD(Pxatual, Pyatual, Dx1, Dy1, Ex2, Ey2, Ex1, Ey1, Dx2, Dy2, R1, R2, state)
% Kp = 0.08125;
% Kd = 0.5005;
threshold = d;
Kp = 5 %0.0709      
Kd = 10 %0.467

Kp = 5.0700
Kp = 2
Kd = 9.9300

Ki = 0.005;

custo = 0;
profile off
profile on
%{
custo = CostControl_PD_KpKd(Pxatual, Pyatual, ...
                Dx1, Dy1, Ex2, Ey2, Ex1, Ey1, Dx2, Dy2, ... 
                R1, R2, Cx1, Cy1, Cx2, Cy2, ...
                state, Kp, Kd, Ki, threshold, Q)
custo = CostControl_PD_KpKd(Pxatual, Pyatual, ...
                Dx1, Dy1, Ex2, Ey2, Ex1, Ey1, Dx2, Dy2, ... 
                R1, R2, Cx1, Cy1, Cx2, Cy2, ...
                state, Kp, Kd, Ki, threshold, Q)

%}





tic

custo = CostControl_PD_KpKdKi(Pxatual, Pyatual, ...
                Dx1, Dy1, Ex2, Ey2, Ex1, Ey1, Dx2, Dy2, ... 
                R1, R2, Cx1, Cy1, Cx2, Cy2, ...
                state, Kp, Kd, Ki, threshold, Q)
toc

profile off
profile viewer


%%
close all
figure(2)

















%%
clc, close all

Kp = 5.0700
Kd = 9.9300

custo = 0
melhorCusto = 78.075 %Kp = 5.07, Kd = 9.93, Ki = 0.005
iter = 0;
totalIters = 0;
j=25000;

%Kp = 5.07, Kd = 9.93, Ki = 0.005
loopTime = tic;

step = 0.001*10

for Kp = 4.000:step:5.000
    for Kd = 8.000:step:12.000
        for Ki = 0.001:step:10.00
            t0 = tic;
            custo = CostControl_PD_KpKdKi_SemPlots(Pxatual, Pyatual, ...
                    Dx1, Dy1, Ex2, Ey2, Ex1, Ey1, Dx2, Dy2, ... 
                    R1, R2, Cx1, Cy1, Cx2, Cy2, ...
                    state, Kp, Kd, Ki, threshold, Q);
            if (custo < melhorCusto)
                dt = toc(t0);
                melhorCusto = custo;
                fprintf("Kp = %.4f | Kd = %.4f | Ki = %.4f | Custo = %.5f | dt = %.4f [s]\n-------------\n", Kp, Kd, Ki, melhorCusto, dt);
                fid = fopen('valoresKpKdKi.txt','a');
                fprintf(fid, "Kp = %.4f | Kd = %.4f | Ki = %.4f | Custo = %.5f | dt = %.4f [s]\n-------------\n", Kp, Kd, Ki, melhorCusto, dt);
                fclose(fid);
            end

            if (rem(iter, j) == 0)
                %De j em j mostra quantas itera��es j� fez
                totalIters = totalIters + j;
                fprintf("TotalIterations = %d | Kp = %.4f | Kd = %.4f | Ki = %.4f\n", totalIters, Kp, Kd, Ki)
            end
            iter = iter + 1;
        end
        
    end
end


totalTime = toc('loopTime');
fprintf("TotalIterations = %d | TotalTime = %.4f [s]\n\n", totalIters, totalTime)






%%
custo = 0
melhorCusto = 276.85
for Kp = 4.90:0.01:5.10
    for Kd = 9.90:0.01:10.10
        custo = CostControl_PD_KpKd(Pxatual, Pyatual, ...
                Dx1, Dy1, Ex2, Ey2, Ex1, Ey1, Dx2, Dy2, ... 
                R1, R2, Cx1, Cy1, Cx2, Cy2, ...
                state, Kp, Kd, Ki, threshold, Q);
        if (custo < melhorCusto)
            melhorCusto = custo;
            fprintf("Kp = %.4f | Kd = %.4f | Custo = %.5f\n-------------\n", Kp, Kd, melhorCusto);
            fid = fopen('valoresKpKd.txt','a');
            fprintf(fid, "Kp = %.4f | Kd = %.4f | Custo = %.5f\n-------------\n", Kp, Kd, melhorCusto);
            fclose(fid);
        end
        
    end
end


















%%
%codigo iterativo
clc, close all

pastaInicial = 'C:\Users\Podengos\Documents\MATLAB\SYSTEC - SummerSchool\v3';
pastaPlots = 'C:\Users\Podengos\Documents\MATLAB\SYSTEC - SummerSchool\v3\plots';
%Kp = 0.0805
%Kd = 0.5002
Ki = 0;
threshold = d;
for Kp = 0.0700:0.0001:0.0900
    for Kd = 0.400:0.001:0.600
        fprintf("Kp = %.4f | Kd = %.4f \n", Kp, Kd)
        
        
        figure(1)
        hold on
        grid on
        ffullscreen()

        subplot(1,2,1), hold on
        plot(Xarc1,Yarc1,'-r', Xarc2,Yarc2,'-r', ...
            X_reta1,Y_reta1,'-b', X_reta2,Y_reta2,'-b')


        subplot(1,2,2), hold on
        plot(Xarc1,Yarc1,'-r', Xarc2,Yarc2,'-r', ...
            X_reta1,Y_reta1,'-b', X_reta2,Y_reta2,'-b')

        shg

        
        
        Control_PD_KpKd(Pxatual, Pyatual, ...
                Dx1, Dy1, Ex2, Ey2, Ex1, Ey1, Dx2, Dy2, ... 
                R1, R2, Cx1, Cy1, Cx2, Cy2, ...
                state, Kp, Kd, Ki, threshold, Q)
        titulo = "Kp = " + string(Kp) + "| Kd = " + string(Kd);
        title(titulo)
        
        cd(pastaPlots)
        gravar_plot()
        cd(pastaInicial)
        
        close all
        
    end
end










%{



%%
clc, close all

pastaInicial = 'C:\Users\Podengos\Documents\MATLAB\SYSTEC - SummerSchool\v3';
pastaPlots = 'C:\Users\Podengos\Documents\MATLAB\SYSTEC - SummerSchool\v3\plots';
%Kp = 0.0805
%Kd = 0.5002

for Kp = 0.0700:0.0001:0.0900
    for Kd = 0.400:0.001:0.600
        fprintf("Kp = %.4f | Kd = %.4f \n", Kp, Kd)
        figure(1)
        hold on
        grid on

        plot(Xarc1,Yarc1,'-r')
        plot(Xarc2,Yarc2,'-r')
        plot(X_reta1,Y_reta1,'-b');
        plot(X_reta2,Y_reta2,'-b');
        
        Control_PD_KpKd(Pxatual, Pyatual, Dx1, Dy1, Ex2, Ey2, Ex1, Ey1, Dx2, Dy2, R1, R2, state, Kp, Kd)
        
        titulo = "Kp = " + string(Kp) + "| Kd = " + string(Kd);
        title(titulo)
        
        cd(pastaPlots)
        gravar_plot()
        cd(pastaInicial)
        
        close all
        
    end
end
%}


    




