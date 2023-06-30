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


