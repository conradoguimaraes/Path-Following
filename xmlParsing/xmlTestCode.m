%%
%https://www.mathworks.com/help/matlab/ref/xmlread.html
clc,clear,close all


filename = 'trajectories.xml';
xmltree = readXML(filename)


function xmlTree = readXML(filename)
    %Try to Read the XML File
    try
        tree = xmlread(filename)
        fprintf("Trajectories XML File: %s\n", filename)
    catch
        error('Failed to read XML file %s.',filename)
    end
    
    
    childrens = [];
    if (tree.hasChildNodes)
        childNodes = tree.getChildNodes;
        numChildNodes = childNodes.getLength;
        allocCell = cell(1, numChildNodes);
    else
        error('The XML Tree has no Child Nodes')
    end
    
end