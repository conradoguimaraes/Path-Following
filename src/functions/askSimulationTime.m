function simulationTime = askSimulationTime()
    prompt = {'Desired Simulation Time (seconds):'};
    dlgtitle = 'Simulation Time';
    boxDimension = [1 40];
    defaultValue = {'160'};
    answer = inputdlg(prompt,dlgtitle,boxDimension,defaultValue);
    simulationTime = str2num(answer{1})
end