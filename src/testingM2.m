


L0 = 3;


Ax = Dx1;
Ay = Dy1;
Bx = Ex2;
By = Ey2;


r = sqrt(L0^2 + d^2);
angleThetaAtan2 = atan2(By-Ay, Bx-Ax);

Tx = (distance(Ax,Ay,Qx,Qy)+L0)*cos(angleThetaAtan2);
Ty = (distance(Ax,Ay,Qx,Qy)+L0)*cos(angleThetaAtan2);



phid = atan2(Ty - y, Tx - x)




function distance = computeDistance(Ax,Ay,Bx,By)
    distance = sqrt((Ax-Bx)^2 + (Ay-By)^2);
end