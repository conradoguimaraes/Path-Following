%%
clc,clear,close all



angulo= 0:0.0001:pi/2;


Xarc1 = 0+1*cos(angulo);
Yarc1 = 0+1*sin(angulo);

px = 0.6
py = 0.95

figure(1), hold on, grid on
plot(Xarc1,Yarc1,'-b')
plot(px,py,'xr')
axis square



menorD = 99999;
menorQx = 99999;
menorQy = 99999;


for index=1:1:numel(angulo)
    distancia = distance(px,py,Xarc1(index),Yarc1(index));
    if (distancia < menorD)
        menorD = distancia;
        menorQx = Xarc1(index);
        menorQy = Yarc1(index);
    end
end

display("Done")
menorD
menorQx
menorQy
function d = distance(px,py,qx,qy)
    d = sqrt((px-qx)^2 + (py-qy)^2);
end