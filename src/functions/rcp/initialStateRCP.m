Px = Pxatual;
Py = Pyatual;

[d_retaA1B1, lambdaA1B1, ~ , ~, Q01] = dist_reta_rcp(PA1x, PA1y, PB1x, PB1y, Px, Py);
[d_retaB2C1, lambdaB2C1, ~ , ~, Q02] = dist_reta_rcp(PB2x, PB2y, PC1x, PC1y, Px, Py);
[d_retaC2D1, lambdaC2D1, ~ , ~, Q03] = dist_reta_rcp(PC2x, PC2y, PD1x, PD1y, Px, Py);
[d_retaD2E1, lambdaD2E1, ~ , ~, Q04] = dist_reta_rcp(PD2x, PD2y, PE1x, PE1y, Px, Py);
[d_retaE2F1, lambdaE2F1, ~ , ~, Q05] = dist_reta_rcp(PE2x, PE2y, PF1x, PF1y, Px, Py);
[d_retaF2G1, lambdaF2G1, ~ , ~, Q06] = dist_reta_rcp(PF2x, PF2y, PG1x, PG1y, Px, Py);

[d_retaG2H1, lambdaG2H1, ~ , ~, Q07] = dist_reta_rcp(PG2x, PG2y, PH1x, PH1y, Px, Py);
[d_retaH2I1, lambdaH2I1, ~ , ~, Q08] = dist_reta_rcp(PH2x, PH2y, PI1x, PI1y, Px, Py);
[d_retaI2J1, lambdaI2J1, ~ , ~, Q09] = dist_reta_rcp(PI2x, PI2y, PJ1x, PJ1y, Px, Py);
[d_retaJ2A2, lambdaJ2A2, ~ , ~, Q10] = dist_reta_rcp(PJ2x, PJ2y, PA2x, PA2y, Px, Py);



[d_arcoA2A1 , thetaA2A1 , QA1, ~] = dist_arco_rcp(Cx1,Cy1,R1,Xarc1,Yarc1,Px,Py);
[d_arcoB1B2 , thetaB1B2 , QA2, ~] = dist_arco_rcp(Cx2,Cy2,R2,Xarc2,Yarc2,Px,Py);
[d_arcoC1C2 , thetaC1C2 , QA3, ~] = dist_arco_rcp(Cx3,Cy3,R3,Xarc3,Yarc3,Px,Py);
[d_arcoD1D2 , thetaD1D2 , QA4, ~] = dist_arco_rcp(Cx4,Cy4,R4,Xarc4,Yarc4,Px,Py);
[d_arcoE1E2 , thetaE1E2 , QA5, ~] = dist_arco_rcp(Cx5,Cy5,R5,Xarc5,Yarc5,Px,Py);
[d_arcoF1F2 , thetaF1F2 , QA6, ~] = dist_arco_rcp(Cx6,Cy6,R6,Xarc6,Yarc6,Px,Py);
[d_arcoG1G2 , thetaG1G2 , QA7, ~] = dist_arco_rcp(Cx7,Cy7,R7,Xarc7,Yarc7,Px,Py);
[d_arcoH1H2 , thetaH1H2 , QA8, ~] = dist_arco_rcp(Cx8,Cy8,R8,Xarc8,Yarc8,Px,Py);
[d_arcoI1I2 , thetaI1I2 , QA9, ~] = dist_arco_rcp(Cx9,Cy9,R9,Xarc9,Yarc9,Px,Py);
[d_arcoJ1J2 , thetaJ1J2 , QA10, ~] = dist_arco_rcp(Cx10,Cy10,R10,Xarc10,Yarc10,Px,Py);



menorD = min([d_retaA1B1, d_retaB2C1, d_retaC2D1, ...
             d_retaD2E1, d_retaE2F1, d_retaF2G1, ...
             d_retaG2H1, d_retaH2I1, d_retaI2J1, ...
             d_retaJ2A2, d_arcoA2A1, d_arcoB1B2, ...
             d_arcoC1C2, d_arcoD1D2, d_arcoE1E2, ...
             d_arcoF1F2, d_arcoG1G2, d_arcoH1H2, ...
             d_arcoI1I2, d_arcoJ1J2]);

if(menorD == d_retaA1B1)
	state = 0;
	Q = Q01;
	d = d_retaA1B1;
elseif(menorD == d_retaB2C1)
	state = 2;
	Q = Q02;
	d = d_retaB2C1;
elseif(menorD == d_retaC2D1)
	state = 4;
	Q = Q03;
	d = d_retaC2D1;
elseif(menorD == d_retaD2E1)
	state = 6;
	Q = Q04;
	d = d_retaD2E1;
elseif(menorD == d_retaE2F1)
	state = 8;
	Q = Q05;
	d = d_retaE2F1;
elseif(menorD == d_retaF2G1)
	state = 10;
	Q = Q06;
	d = d_retaF2G1;
elseif(menorD == d_retaG2H1)
	state = 12;
	Q = Q07;
	d = d_retaG2H1;
elseif(menorD == d_retaH2I1)
	state = 14;
	Q = Q08;
	d = d_retaH2I1;
elseif(menorD == d_retaI2J1)
	state = 16;
	Q = Q09;
	d = d_retaI2J1;
elseif(menorD == d_retaJ2A2)
	state = 18;
	Q = Q10;
	d = d_retaJ2A2;
elseif(menorD == d_arcoA2A1)
	state = 19;
	Q = QA1;
	d = d_arcoA2A1;
elseif(menorD == d_arcoB1B2)
	state = 1;
	Q = QA2;
	d = d_arcoB1B2;
elseif(menorD == d_arcoC1C2)
	state = 3;
	Q = QA3;
	d = d_arcoC1C2;
elseif(menorD == d_arcoD1D2)
	state = 5;
	Q = QA4;
	d = d_arcoD1D2;
elseif(menorD == d_arcoE1E2)
	state = 7;
	Q = QA5;
	d = d_arcoE1E2;
elseif(menorD == d_arcoF1F2)
	state = 9;
	Q = QA6;
	d = d_arcoF1F2;
elseif(menorD == d_arcoG1G2)
	state = 11;
	Q = QA7;
	d = d_arcoG1G2;
elseif(menorD == d_arcoH1H2)
	state = 13;
	Q = QA8;
	d = d_arcoH1H2;
elseif(menorD == d_arcoI1I2)
	state = 15;
	Q = QA9;
	d = d_arcoI1I2;
elseif(menorD == d_arcoJ1J2)
	state = 17;
	Q = QA10;
	d = d_arcoJ1J2;
else
	state = 0;
	Q = Q01;
	d = d_retaA1B1;
end

   