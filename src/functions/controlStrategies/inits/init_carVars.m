fprintf("Running 'init_carVars.m'\n")
x0 = Px;
y0 = Py;

R_carro = max(R1,R2)/2;
c_max = 1/R_carro
c = c_max;
c_min = -c_max;
v = 1.0;

x=x0;
y=y0;
th=th0;
d_ant = 0;