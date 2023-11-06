%%

d1 = abs(min(reta1Xvector)-max(reta1Xvector));
d2 = abs(min(reta2Xvector)-max(reta2Xvector));


% R1 = 10;
% R2 = 10;
% delta = pi/8;
% theta1 = (pi/2 - delta) : 0.0001 : ((3*pi)/2 + delta);
% theta2 = -(pi/2 + delta) : 0.0001 : (pi/2 + delta);

angle1 = abs(min(theta1) - max(theta1));
angle2 = abs(min(theta2) - max(theta2));


%Arc lengths:
s1 = R1*angle1;
s2 = R2*angle2;


pathLength = d1+d2+s1+s2;
fprintf("Total Path Length: %.2f\n",pathLength)