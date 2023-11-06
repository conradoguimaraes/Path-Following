function simulationTime = askSimulationTime()
    try
        lastSimulationTime = load('lastSimulationTime.dat');
    catch
        lastSimulationTime = 160;
    end
    
    prompt = {'Desired Simulation Time (seconds):'};
    dlgtitle = 'Simulation Time';
    boxDimension = [1 40];
    defaultValue = {num2str(lastSimulationTime)};
    answer = inputdlg(prompt,dlgtitle,boxDimension,defaultValue);
    simulationTime = str2num(answer{1})
    
    save('lastSimulationTime.dat','simulationTime','-ascii')
end