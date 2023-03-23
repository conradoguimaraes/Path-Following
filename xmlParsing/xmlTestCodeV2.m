%%
%https://www.mathworks.com/help/matlab/ref/xmlread.html
%

run('init.m')

%filename = 'trajectories.xml';
%trajectoryParams = parseTrajectory(xmlTrajectoriesFilename)

filename = xmlTrajectoriesFilename
run('apagar.m')


function trajectoryParams = parseTrajectory(filename)
    tree = readTrajectoryXML(filename)
    trajectoryParams = NaN
    
    childrens = [];
    if (tree.hasChildNodes)
        childNodes = tree.getChildNodes;
        numChildNodes = childNodes.getLength;
        allocCell = cell(1, numChildNodes);
    else
        error('The XML Tree has no Child Nodes')
    end
    
end