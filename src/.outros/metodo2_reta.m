%%
clc,close all, clear

syms sx sy

Qx = 5
Qy = 5

Px = 5
Py = 2


delta = 4
d = sqrt((Qx-Px)^2 + (Qy-Py)^2)
R = sqrt(delta^2 + d^2)



eqn1 = (Qx-sx)^2 + (Qy-sy)^2 == delta^2
eqn2 = (Px-sx)^2 + (Py-sy)^2 == R^2

sol = solve(eqn1, eqn2, sx,sy)

sxsol = vpa(sol.sx,4)
sysol = vpa(sol.sy,4)

figure(1), hold on
plot(Qx,Qy,'xb')
plot(Px,Py,'xb')
plot(sxsol(1),sysol(1),'xr')
plot(sxsol(2),sysol(2),'or')