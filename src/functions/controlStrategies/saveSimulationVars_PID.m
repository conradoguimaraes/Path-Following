try
    delete(char(pwd + "\.simulationVars\*.mat"))
    warning on
    warning("Old simulation variables deleted from folder '.simulationVars'.\n")
catch
end
%-------------------------------------------------
try
    mkdir('.simulationVars')
catch
end
%-------------------------------------------------
save(pwd + "\.simulationVars\" + "simulationTime", 'simulationTime')
%-------------------------------------------------
save(pwd + "\.simulationVars\" + "TimeArray", 'TimeArray')
%-------------------------------------------------
filePath = pwd + "\.simulationVars\" + "initialPosition";

initialPosition = struct('x0',x0,'y0',y0);
                   
save(filePath, 'initialPosition')
%-------------------------------------------------
filePath = pwd + "\.simulationVars\" + "carVars";

carVars = struct('R_carro',R_carro,...
                 'c_max',c_max,...
                 'th0',th0);
                   
save(filePath, 'carVars')
%-------------------------------------------------
try
save(pwd + "\.simulationVars\" + "Kp", 'Kpo')
catch
end
%-------------------------------------------------
try
save(pwd + "\.simulationVars\" + "Ki", 'Kio')
catch
end
%-------------------------------------------------
try
save(pwd + "\.simulationVars\" + "Kd", 'Kdo')
catch
end
%-------------------------------------------------
save(pwd + "\.simulationVars\" + "state", 'state')
save(pwd + "\.simulationVars\" + "dx", 'dx')
save(pwd + "\.simulationVars\" + "dy", 'dy')
save(pwd + "\.simulationVars\" + "dth", 'dth')
%-------------------------------------------------
save(pwd + "\.simulationVars\" + "costArray", 'costArray')
save(pwd + "\.simulationVars\" + "averageCost", 'media')
save(pwd + "\.simulationVars\" + "controlEffortArray", 'controlEffortArray')
%-------------------------------------------------
save(pwd + "\.simulationVars\" + "thetaArrayRAD", 'thetaArray')
thetaArrayDegrees = rad2deg(thetaArray);
save(pwd + "\.simulationVars\" + "thetaArrayDEG", 'thetaArrayDegrees')
%-------------------------------------------------


save(pwd + "\.simulationVars\" + "handler1", 'handler1')
save(pwd + "\.simulationVars\" + "handler3", 'handler3')

%-------------------------------------------------
warning on
warning("New simulation variables saved to folder\n")


