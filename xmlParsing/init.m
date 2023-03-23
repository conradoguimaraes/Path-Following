%........................................
%Execution Parameters
%........................................
displayProgramInfo = false
infoFile = 'info.txt'

clearConsole = true
clearVars = true %Clear All Environment Variables
clearInitVars = true %Clear Only the Init Vars
closeAllPlots = true


includeFunctionsFolder = true
%functionsFolder = 'functions'
functionsFolder = 'C:\Users\Podengos\Documents\GitHub\Path-Following\xmlParsing\functions'


xmlTrajectoriesFilename = 'trajectories.xml'


%----------------------------------------

deleteInitVars = {'displayProgramInfo', 'infoFile', ...
    'clearConsole', 'clearInitVars', 'closeAllPlots', ...
    'includeFunctionsFolder', 'functionsFolder', ...
    'deleteInitVars'}

doNotDeleteVars = {'xmlTrajectoriesFilename'}

%----------------------------------------
%----------------------------------------
%----------------------------------------
%----------------------------------------
if displayProgramInfo
    try
        type(infoFile)
    catch
    end
end
%----------------------------------------
if clearConsole
    clc
end
%----------------------------------------
if closeAllPlots
    close all
end
%----------------------------------------

%Add Functions Folder to the 
%Execution/Path/Environment
if includeFunctionsFolder
    try
        addpath(genpath(functionsFolder))
    catch
        warning("Functions Folder '%s' was not added successfully.\n", functionsFolder)
    end
end


%----------------------------------------
if clearInitVars
    clearvars(deleteInitVars{:})
end
%----------------------------------------
%This must be the last evaluation of the
%init script, because if it is True it will also
%delete the conditional variables.
%[OBS]: clearVars overrides the clearInitVars
if clearVars
    clearvars('-except', doNotDeleteVars{:})
else
    clear clearVars doNotDeleteVars
end
%----------------------------------------
