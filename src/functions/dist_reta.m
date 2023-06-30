function [d, lambda1, lambda2, theta, Q] = dist_reta(Ax,Ay,Bx,By,Px,Py)
% help dist_reta
% [INPUTs]: 
%     Coordenadas A (Ax, Ay)
%     Coordenadas B (Bx, Ay)
%     Coordenadas Ponto (Px, Py)
% 
% 
% [OUTPUTs]:
%     d
%     lambda1
%     lambda2
%     theta
%


%syms l1 l2
% fprintf("Função [dist_reta]\n");
% t1 = datetime('now','Format','HH:mm:ss.SSS')
% fprintf("%s\n-----------------\n")

A = [Ax Ay];
B = [Bx By];
P = [Px Py];


ux = (Bx-Ax) * (1/norm(B-A));
uy = (By-Ay) * (1/norm(B-A));

nx = -uy;
ny = ux;

u = [ux uy];
n = [nx ny];


%eqn1 = (Ax + l1*ux == Px + l2*nx);
%eqn2 = (Ay + l1*uy == Py + l2*ny);
%[lambda1, lambda2] = solve(eqn1, eqn2, l1, l2);

solucao = [ux, -nx; uy, -ny] \ [Px-Ax; Py-Ay];
lambda1 = solucao(1);
lambda2 = solucao(2);



%Q = vpa(A + lambda1*u, 9);
Q = A + lambda1*u;
Q1 = Q;

%Q = vpa(P + lambda2*n, 9);
Q = P + lambda2*n;
Q2 = Q;

%if (Q1 ~= Q2)
 %  warning("[LINE 45 - dist_reta] Q calculados são diferentes")
%end


Qx = Q(1);
Qy = Q(2);

d = sqrt((Qx-Px)^2 + (Qy-Py)^2);

%figure(1)
%hold on, grid on
%plot([A(1) B(1)], [A(2) B(2)],'-b')


%plot(P(1), P(2), 'xr')
%plot(Q(1), Q(2), 'or')
%plot([P(1) Q(1)], [P(2) Q(2)],':m')

%legend("Segmento AB", "PxPy", "QxQx", "Segmento PQ", 'Location','best')
%shg
%hold off


%Obter o declive entre as duas retas
%(deve dar 90º)
m1 = (Ay-By) / (Ax-Bx);
m2 = (Py-Qy) / (Px-Qx);

%ângulo em radianos:
theta = atan((m1-m2)/(1+(m1*m2)));
%theta2 = vpa(theta,5);

%ângulo em graus (atand):
% theta1 = atand((m1-m2)/(1+(m1*m2)))
%theta1 = vpa(theta1,5);

%{
plot(P(1), P(2), 'xr', 'MarkerSize',4)
plot(Q(1), Q(2), 'or', 'MarkerSize',2)
plot([P(1) Q(1)], [P(2) Q(2)],':m')
%}

end