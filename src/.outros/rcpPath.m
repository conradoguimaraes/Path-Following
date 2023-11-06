%%
clc,clear, close all


%-------------------------------------------------
% Replace 'your_output_file.csv' with the actual filename exported from Python
% csv_filename = 'XYcoordinates.csv';
% 
% Load the CSV file
% data = csvread(csv_filename, 1, 0); % Skip the header row
% 
% Extract X and Y coordinates
% X = data(:, 1);
% Y = data(:, 2);

%-------------------------------------------------

% Replace 'your_image_file.png' with the actual filename of the image you want to use
image_filename = 'rcp.png';

% Load the image
background_image = imread(image_filename);
[ySize, xSize, ~] = size(background_image)
% Plot the image
% imshow(background_image);

% Hold on to overlay the plot on top of the image
hold on;


%-------------------------------------------------

% Plot the coordinates on top of the image
% pathXoffset = -150
% pathYoffset = -100
% X = X+pathXoffset;
% Y = Y+pathYoffset;
% plot(X, Y, '-g', 'LineWidth',1);


%-------------------------------------------------
% Set the axis labels and title
xlabel('X Coordinates');
ylabel('Y Coordinates');
title('Plot of SVG Path Nodes');


% xlim([5, xSize-10])
% ylim([5, ySize-25])

% Add grid if desired
grid on;

% Release the 'hold' state to prevent further superimposition
% hold off;

%-------------------------------------------------


%left arc C1
% Cx1 = 252;
Cx1 = 250;
Cy1 = 228;
R1 = 80;
% theta1 = (pi/2)+0.1745 : 0.0001 : ((3*pi)/2)+0.1745;
theta1 = 180:0.0001:170+100;
Xarc1 = Cx1+R1*cosd(theta1);
Yarc1 = Cy1+R1*sind(theta1);
plotXY(Xarc1,Yarc1)


%right arc C2
Cx2 = Cx1 + 1200;
Cy2 = Cy1;
R2 = 80;
theta2 = -90:0.0001:-90+90;
Xarc2 = Cx2+R2*cosd(theta2);
Yarc2 = Cy2+R2*sind(theta2);
plotXY(Xarc2,Yarc2)


%line
PA1x = Xarc1(end);
PA1y = Yarc1(end);
PB1x = PA1x+1200;
PB1y = PA1y;
LineA1B1x = PA1x:PB1x;
LineA1B1y = PA1y*ones(length(LineA1B1x));
plotXY(LineA1B1x, LineA1B1y)




%right arc C3
Cx3 = Cx2;
Cy3 = Cy2+270;
R3 = 80;
theta3 = 0:0.0001:90;
Xarc3 = Cx3+R3*cosd(theta3);
Yarc3 = Cy3+R3*sind(theta3);
plotXY(Xarc3,Yarc3)



%line
PB2x = Xarc2(end);
PB2y = Yarc2(end);
PC1x = PB2x;
PC1y = PB2y+270;
LineB2C1y = PB2y:PC1y;
LineB2C1x = PB2x*ones(length(LineB2C1y));
plotXY(LineB2C1x, LineB2C1y)


%left arc c4
R4 = 80;
Cx4 = Cx3 - 360;
Cy4 = Yarc3(end) + R4;
theta4 = 180:0.0001:270;
Xarc4 = Cx4+R4*cosd(theta4);
Yarc4 = Cy4+R4*sind(theta4);
plotXY(Xarc4,Yarc4)


%Line
PC2x = Xarc3(end);
PC2y = Yarc3(end);
PD1x = PC1x - 360 - R4;
PD1y = PC2y;
LineC2D1x = PD1x:PC2x;
LineC2D1y = PD1y*ones(length(LineC2D1x));
plotXY(LineC2D1x, LineC2D1y)



%left arc c5
R5 = 80;
Cx5 = Cx4;
Cy5 = Cy4 + 200;
theta5 = 90:0.0001:180;
Xarc5 = Cx5+R5*cosd(theta5);
Yarc5 = Cy5+R5*sind(theta5);
plotXY(Xarc5,Yarc5)

%Line
PD2x = Xarc4(1);
PD2y = Yarc4(1);
PE1x = PD2x;
PE1y = PD2y+200;
LineD2E1y = PD2y:PE1y;
LineD2E1x = PD2x*ones(length(LineD2E1y));
plotXY(LineD2E1x, LineD2E1y)



%left arc c6
R6 = 80;
Cx6 = Cx5 + 380;
Cy6 = Cy5 + R6 + R6;
theta6 = -90:0.0001:0;
Xarc6 = Cx6+R6*cosd(theta6);
Yarc6 = Cy6+R6*sind(theta6);
plotXY(Xarc6,Yarc6)


%Line
PE2x = Xarc5(1);
PE2y = Yarc5(1);
PF1x = PE2x + 380;
PF1y = PE2y;
LineE2F1x = PE2x:PF1x;
LineE2F1y = PF1y*ones(length(LineE2F1x));
plotXY(LineE2F1x, LineE2F1y)



%right arc C7
Cx7 = Cx6;
Cy7 = Cy6+200;
R7 = 80;
theta7 = 0:0.0001:90;
Xarc7 = Cx7+R7*cosd(theta7);
Yarc7 = Cy7+R7*sind(theta7);
plotXY(Xarc7,Yarc7)


%Line
PF2x = Xarc6(end);
PF2y = Yarc6(end);
PG1x = PF2x;
PG1y = PF2y+200;
LineF2G1y = PF2y:PG1y;
LineF2G1x = PG1x*ones(length(LineF2G1y));
plotXY(LineF2G1x, LineF2G1y)



%left arc C8
Cx8 = Cx7 - 650;
Cy8 = Cy7;
R8 = 80;
theta8 = 90:0.0001:180;
Xarc8 = Cx8+R8*cosd(theta8);
Yarc8 = Cy8+R8*sind(theta8);
plotXY(Xarc8,Yarc8)


%Line
PG2x = Xarc7(end);
PG2y = Yarc7(end);
PH1x = PG2x - 650;
PH1y = PG2y;
LineG2H1x = PH1x:PG2x;
LineG2H1y = PH1y*ones(length(LineG2H1x));
plotXY(LineG2H1x, LineG2H1y)


%arc C9
Cx9 = Cx8 - 220;
Cy9 = Cy8 - 580;
R9 = 140;
theta9 = -180:0.0001:0;
Xarc9 = Cx9+R9*cosd(theta9);
Yarc9 = Cy9+R9*sind(theta9);
plotXY(Xarc9,Yarc9)


%Line
PH2x = Xarc8(end);
PH2y = Yarc8(end);
PI1x = PH2x;
PI1y = PH2y-580;
LineH2I1y = PI1y:PH2y;
LineH2I1x = PI1x*ones(length(LineH2I1y));
plotXY(LineH2I1x, LineH2I1y)


%arc C10
Cx10 = Cx9 - 285;
Cy10 = Cy9 + 580;
R10 = 145;
theta10 = 0:0.0001:180;
Xarc10 = Cx10+R10*cosd(theta10);
Yarc10 = Cy10+R10*sind(theta10);
plotXY(Xarc10,Yarc10)



%Line
PI2x = Xarc9(1);
PI2y = Yarc9(1);
PJ1x = PI2x;
PJ1y = PI2y + 580;
LineI2J1y = PI2y:PJ1y;
LineI2J1x = PJ1x*ones(length(LineI2J1y));
plotXY(LineI2J1x, LineI2J1y)



%Line
PJ2x = Xarc10(end);
PJ2y = Yarc10(end);
PA2x = Xarc1(1);
PA2y = Yarc1(1);
LineJ2A2y = PA2y:PJ2y;
LineJ2A2x = PA2x*ones(length(LineJ2A2y));
plotXY(LineJ2A2x, LineJ2A2y)




fprintf("Ponto A1: x=%g | y=%g\n",PA1x,PA1y)
fprintf("Ponto A2: x=%g | y=%g\n",PA2x,PA2y)
fprintf("Ponto B1: x=%g | y=%g\n",PB1x,PB1y)
fprintf("Ponto B2: x=%g | y=%g\n",PB2x,PB2y)
fprintf("Ponto C1: x=%g | y=%g\n",PC1x,PC1y)
fprintf("Ponto C2: x=%g | y=%g\n",PC2x,PC2y)
fprintf("Ponto D1: x=%g | y=%g\n",PD1x,PD1y)
fprintf("Ponto D2: x=%g | y=%g\n",PD2x,PD2y)
fprintf("Ponto E1: x=%g | y=%g\n",PE1x,PE1y)
fprintf("Ponto E2: x=%g | y=%g\n",PE2x,PE2y)
fprintf("Ponto F1: x=%g | y=%g\n",PF1x,PF1y)
fprintf("Ponto F2: x=%g | y=%g\n",PF2x,PF2y)
fprintf("Ponto G1: x=%g | y=%g\n",PG1x,PG1y)
fprintf("Ponto G2: x=%g | y=%g\n",PG2x,PG2y)
fprintf("Ponto H1: x=%g | y=%g\n",PH1x,PH1y)
fprintf("Ponto H2: x=%g | y=%g\n",PH2x,PH2y)
fprintf("Ponto I1: x=%g | y=%g\n",PI1x,PI1y)
fprintf("Ponto I2: x=%g | y=%g\n",PI2x,PI2y)
fprintf("Ponto J1: x=%g | y=%g\n",PJ1x,PJ1y)
fprintf("Ponto J2: x=%g | y=%g\n",PJ2x,PJ2y)

fprintf("\nPonto C1: x=%g | y=%g\n",Cx1,Cy1)
fprintf("Ponto C2: x=%g | y=%g\n",Cx2,Cy2)
fprintf("Ponto C3: x=%g | y=%g\n",Cx3,Cy3)
fprintf("Ponto C4: x=%g | y=%g\n",Cx4,Cy4)
fprintf("Ponto C5: x=%g | y=%g\n",Cx5,Cy5)
fprintf("Ponto C6: x=%g | y=%g\n",Cx6,Cy6)
fprintf("Ponto C7: x=%g | y=%g\n",Cx7,Cy7)
fprintf("Ponto C8: x=%g | y=%g\n",Cx8,Cy8)
fprintf("Ponto C9: x=%g | y=%g\n",Cx9,Cy9)
fprintf("Ponto C10: x=%g | y=%g",Cx10,Cy10)

function plotXY(x,y)
    plot(x,y,'-c','LineWidth',2)
end