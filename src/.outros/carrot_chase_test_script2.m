%%
clc
R1
Cx1
Cy1

Qx = 10;
Qy = 25;

Qx =14.96
Qy =23.683
theta = deg2rad(-5);

phi = atan2(Qy - Cy1, Qx - Cx1)

phi_new = phi - theta


Tx = Cx1 + R1 * cos(phi_new)
Ty = Cy1 + R1 * sin(phi_new)

%%
clc
R1
Cx2
Cy2

Qx = 10;
Qy = 25;

Qx =52.566
Qy =5.3348
theta = deg2rad(-5);

phi = atan2(Qy - Cy2, Qx - Cx2)

phi_new = phi + theta


Tx = Cx2 + R2 * cos(phi_new)
Ty = Cy2 + R2 * sin(phi_new)

