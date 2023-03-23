function xmlTree = readTrajectoryXML(filename)
    %Try to Read the XML File
    try
        xmlTree = xmlread(filename)
        fprintf("Trajectories XML File: %s\n", filename)
    catch
        error('Failed to read XML file %s.',filename)
    end
end