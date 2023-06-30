Xarc1 = Cx1+R1*cos(theta1);
Yarc1 = Cy1+R1*sin(theta1);

Xarc2 = Cx2+R2*cos(theta2);
Yarc2 = Cy2+R2*sin(theta2);




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