fprintf("Running 'init_carVars.m'\n")
x0 = Px;
y0 = Py;

R1 = 10;
% R2 = 10;
R2
R_carro = max(R1,R2)/2;
c_max = 1/R_carro

c_max = 0.2

c = c_max;
c_min = -c_max;
v = 0.5;
v = 5

x=x0;
y=y0;
th=th0;
d_ant = 0;