%%
clc
timeArray = readSimVar('TimeArray.mat');
timeArray = timeArray.TimeArray;


costArray = readSimVar('costArray.mat');
costArray = costArray.costArray;

firstZero = find(costArray <= 0.05, 1, 'first')
timeZero = timeArray(firstZero)


controlEffortArray = readSimVar('controlEffortArray.mat');
controlEffortArray = controlEffortArray.controlEffortArray;
controlEffortArray = controlEffortArray(1:end-1);


%Total Cost
totalCost = sum(costArray)
controlEffort = sum(controlEffortArray.^2)


%After first crossing the path
totalCost_t0 = sum(costArray(firstZero:end))
controlEffort_t0 = sum(controlEffortArray(firstZero:end).^2)


mediaTotal = mean(costArray);
mediaTotal_t0 = mean(costArray(firstZero:end))



% figure(800), hold on
% h800 = plot(timeArray, controlEffortArray, '-b','LineWidth',1);
% 
% %-------------------------------------------------
% set(gcf, 'Position', get(0, 'Screensize'));
% set(gcf, 'Color', 'w');
% 
% 
% grid on
% 
% xlim([0, max(timeArray)])
% xticksStep = 10;
% xticks(0:xticksStep:max(timeArray))
% 
% ylim([-0.3, 0.3])
% 
% title("Control Effort evolution along time.")
% xlabel("time (seconds)")
% ylabel("Control Effort")
% 
% 
% 
% savePlot(shape+"_ControlEffort")
% warning("ControlEffort Plot saved.")


