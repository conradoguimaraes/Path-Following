function savePlot(filename)
    PNGfileNumber = length(dir(char(pwd+"\.results\*.png")));
    PNGfileNumber = PNGfileNumber + 1;

    %Example: ...\.results\043_myFilename.png
    
    %Fix for proper alphbetical name order (in the folder):
    if (PNGfileNumber < 10)
        newFilename = "00" + string(PNGfileNumber)+ "_" + filename + ".png";
    elseif (PNGfileNumber < 100)
        newFilename = "0" + string(PNGfileNumber)+ "_" + filename + ".png";
    else
        newFilename = string(PNGfileNumber)+ "_" + filename + ".png";
    end
    filePath = pwd + "\.results\" + newFilename;
    filePath = char(filePath);
    
    
 
    
    saveas(gcf,filePath)
    
%     warning on
%     warning('* * Plot gravado * *')
    
    fprintf('[file saved] %s',newFilename)
    fprintf('\n')
    
    beep on
    beep
end