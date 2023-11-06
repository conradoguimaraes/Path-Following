hold all
if (singleFigure == true)
    %..........................
    P(1) = plot(h1,nan,nan,"-k");

    xlabel(h1,"x (metres)")
    ylabel(h1,"y (metres)")

    legend(P(:),{"desired path","vehicle path","initial position"})
    axis(ax1,'square')
    text(h1,x0-3,y0-0.5,"$(P_{x_0}, P_{y_0})$",'Color','red','FontSize',12,'Interpreter','latex')

    titulo1 = "Vehicle Position (t="+string(t)+"s) ";
    L1string = "\{L1="+string(L1)+"\}";
    title(h1,titulo1+L1string)


    xlim(ax1,[-5, 65])
    xticks(ax1,-5:5:65)

    ylim(ax1,[0, 30])
    yticks(ax1,0:1:30)

    %..........................
    xlabel(h3,"Time (seconds)")
    ylabel(h3,"Cross-track Error")
    axisXlength = get(h3, 'XLim');
    text(h3,round(axisXlength(2)/2), media+0.04, "$\overline{d}$ = " + string(vpa(media,2)),'Color','red','FontSize',14,'Interpreter','latex')
    legend(h3,"cross-track error","average cross-track error")


    set(h3,'Position',[0.54159 0.195 0.34 0.635])


    xticks(ax3,0:10:max(TimeArray))
    yticks(ax3,0:0.1:max(costArray))

    titulo2 = "Cross-track Error (t="+string(t)+"s)" + " (current total "+string(sum(costArray))+")";
    title(titulo2)
    %..........................

    set(gcf, 'Color', 'w');
else
    xlabel(axes('Parent',h1),"x (metres)")
    ylabel(axes('Parent',h1),"y (metres)")
end