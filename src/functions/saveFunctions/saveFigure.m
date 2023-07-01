function saveFigure(filename)
    PNGfileNumber = length(dir(char(pwd+"\.results\*.png")));
    PNGfileNumber = PNGfileNumber;

    %Example: ...\.results\043_myFilename.fig
    
    %Fix for proper alphbetical name order (in the folder):
    if (PNGfileNumber < 10)
        newFilename = "00" + string(PNGfileNumber)+ "_" + filename + ".fig";
    elseif (PNGfileNumber < 100)
        newFilename = "0" + string(PNGfileNumber)+ "_" + filename + ".fig";
    else
        newFilename = string(PNGfileNumber)+ "_" + filename + ".fig";
    end
    filePath = pwd + "\.results\" + newFilename;
    filePath = char(filePath);
    
    
 

    savefig(gcf,filePath)
    
%     warning on
%     warning('* * Plot gravado * *')
    
    fprintf('[file saved] %s',newFilename)
    fprintf('\n')
    
    beep on
    beep
end