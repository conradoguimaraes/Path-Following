function [d, theta, Q, eq_circ] = dist_arco(Cx,Cy,R,Px,Py)
% help dist_arco
% [INPUTs]: 
%     Coordenadas Centro (Cx, Cy)
%     Raio (R)
%     Coordenadas Ponto (Px, Py)
% 
% 
% [OUTPUTs]:
%     d
%     theta
%


%fprintf("Função [dist_arco]\n");
%t1 = datetime('now','Format','HH:mm:ss.SSS')
%fprintf("%s\n-----------------\n")

P = [Px,Py];
C = [Cx,Cy];

Qx = Cx + R*((Px-Cx) / norm(P-C));
Qy = Cy + R*((Py-Cy) / norm(P-C));

Q = [Qx, Qy];

d = norm(P-Q);


%plot(P(1), P(2), 'xr')
%plot(Q(1), Q(2), 'or')
%plot([P(1) Q(1)], [P(2) Q(2)],':m')



%ângulo em radianos
theta = atan((Py-Cy) / (Px-Cx));

%ângulo em graus
theta1 = atand((Py-Cy) / (Px-Cx));

eq_circ = (Px-Cx)^2 + (Py-Cy)^2;

end