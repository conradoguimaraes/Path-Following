%........................................
%Execution Parameters
%........................................
infoFile = 'info.txt'
displayProgramInfo = false


clearConsole = true
clearVars = true %Clear All Environment Variables
clearInitVars = true %Clear Only the Init Vars
closeAllPlots = true


includeFolders = true
%functionsFolder = 'functions'
%functionsFolder = 'C:\Users\Podengos\Documents\GitHub\Path-Following\src\functions'
folders2include = {...
    'C:\Users\Admin\Documents\GitHub\Path-Following\src\functions', ...
    'C:\Users\Admin\Documents\GitHub\Path-Following\src\trajectories', ...
    'C:\Users\Admin\Documents\GitHub\Path-Following\src\.simulationVars', ...
    'C:\Users\Admin\Documents\GitHub\Path-Following\src\.scripts'
    }

// folders2include = {...
//     'C:\Users\Podengos\Documents\GitHub\Path-Following\src\functions', ...
//     'C:\Users\Podengos\Documents\GitHub\Path-Following\src\trajectories', ...
//     'C:\Users\Podengos\Documents\GitHub\Path-Following\src\.simulationVars', ...
//     'C:\Users\Podengos\Documents\GitHub\Path-Following\src\.scripts'
//     }

%xmlTrajectoriesFilename = 'trajectories.xml'


%----------------------------------------

deleteInitVars = {...
    'infoFile', ...
    'displayProgramInfo', ...
    'clearConsole', ...
    'clearInitVars', ...
    'closeAllPlots', ...
    'includeFolders', ...
    'functionsFolder', ...
    'deleteInitVars' ...
    }

doNotDeleteVars = {''}

%----------------------------------------
%----------------------------------------
%----------------------------------------
if clearConsole
    clc
end
%----------------------------------------
if displayProgramInfo
    try
        type(infoFile)
    catch
    end
end
%----------------------------------------
%----------------------------------------
if closeAllPlots
    close all
end
%----------------------------------------

%Add Functions Folder to the 
%Execution/Path/Environment
if includeFolders
    for folder2include = folders2include
        try
            addpath(genpath(folder2include{1,1}))
            %fprintf("'%s' folder included.\n", folder2include{1,1})
        catch
            warning("Functions Folder '%s' was not added successfully.\n", folder2include{1,1})
        end
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
