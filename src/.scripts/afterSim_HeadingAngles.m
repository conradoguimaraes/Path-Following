%%
clc
%-------------------------------------------------
fprintf("Running the code that plots the heading angles in the -360deg to 360deg range\n")
timeArray = readSimVar('TimeArray.mat');
timeArray = timeArray.TimeArray;

thetaArrayDegrees = readSimVar('thetaArrayDEG.mat');
thetaArrayDegrees = thetaArrayDegrees.thetaArrayDegrees;
%-------------------------------------------------


h100 = figure(100), hold on
plot(timeArray, thetaArrayDegrees, '-b','LineWidth',1);
%-------------------------------------------------
% set(gcf, 'Position', get(0, 'Screensize'));
set(h100,'Position',[200, 500, 1100, 300])
set(h100, 'Color', 'w');

legend("Heading Angle (degrees)")
grid on

xlim([0, max(timeArray)])
xticksStep = 10;
xticks(0:xticksStep:max(timeArray))

ylim([floor(min(thetaArrayDegrees)-2), floor(max(thetaArrayDegrees)+13)])
yticks(floor(min(thetaArrayDegrees)-2):20:floor(max(thetaArrayDegrees)+13))




title("Heading Angle $$\psi \in [-2\pi, 2\pi]$$ variation.",'interpreter','latex','FontSize', 14)
xlabel("time (seconds)")
ylabel("angle (degrees)")


savePlot(shape+"_HeadingAngle_-360a360")


%%
%-------------------------------------------------
%-------------------------------------------------
fprintf("Running the code that plots the heading angles in the -180deg to 180deg range\n")
timeArray = readSimVar('TimeArray.mat');
timeArray = timeArray.TimeArray;

thetaArray = readSimVar('thetaArrayRAD.mat');
thetaArray = thetaArray.thetaArray;

%-------------------------------------------------

% thetaArrayDegrees = atan2(sin(thetaArrayDegrees * pi/180.0), cos(thetaArrayDegrees * pi/180.0)) * 180.0/pi;
anglesRadians = atan2(sin(thetaArray), cos(thetaArray));
anglesDegrees = rad2deg(anglesRadians);

%-------------------------------------------------

h200 = figure(200), hold on
plot(timeArray, anglesDegrees, '-b','LineWidth',1);

%-------------------------------------------------
% set(gcf, 'Position', get(0, 'Screensize'));
set(h200,'Position',[200, 500, 1100, 300])
set(gcf, 'Color', 'w');

legend("Heading Angle (degrees)")
grid on

xlim([0, max(timeArray)])
xticksStep = 10;
xticks(0:xticksStep:max(timeArray))

% ylim([floor(min(anglesDegrees)-10), floor(max(anglesDegrees)+10)])
ylim([-190, 190])
yticks(-190:20:190)
% yticks(floor(min(anglesDegrees)-10):20:floor(max(anglesDegrees)+10))

title("Heading Angle $$\psi \in [-\pi, \pi]$$ variation.",'interpreter','latex','FontSize', 14)
xlabel("time (seconds)")
ylabel("angle (degrees)")

%-------------------------------------------------

savePlot(shape+"_HeadingAngle_-180a180")
warning("HeadingAngle Plots saved.")

%%
% clc
% timeArray = readSimVar('TimeArray.mat');
% timeArray = timeArray.TimeArray;
% 
% thetaArray = readSimVar('thetaArrayRAD.mat');
% thetaArray = thetaArray.thetaArray;
% 
% 
% 
% figure(100), hold on
% h100 = plot(timeArray, thetaArray, '-b','LineWidth',2)
% 
% legend("Heading Angle (radians)")