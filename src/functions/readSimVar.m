function variable = readSimVar(filename)
    filePath = pwd + "\.simulationVars\" + filename;
    variable = load(filePath);
end