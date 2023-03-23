function gravar_plot()
    %Gravar em Png
    ext = '.png';
    S = ['Plot_', char(datetime), ext];
    S = strrep(S, ' ', '_');
    S = strrep(S, ':', '.');
    saveas(gcf,S)
    warning on
    warning('* * Plot gravado * *')
    fprintf('%c',S)
    fprintf('\n')
    beep on
    beep
end