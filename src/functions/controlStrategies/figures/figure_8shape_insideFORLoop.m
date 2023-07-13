%----------------------------------------------------------------------------
%Position along the path
%----------------------------------------------------------------------------
if (singleFigure == true)
    h1=subplot(1,2,1); hold on, grid on
else
    h1=figure(1); hold on, grid on
end

if (t>=refT && use2laps == true)
    if (lapCounter == 1)
        plot(x,y,'xr','MarkerSize',15)
    end
    P(2) = plot(h1,x,y,'.-g');
else
    P(2) = plot(h1,x,y,'.-b');
end

P(3) = plot(h1,x0,y0,'xr','MarkerSize',15);

thetad = rad2deg(th);
xrotated = x;
yrotated = y;
vehicleImage = plotVehicleV2(xrotated,yrotated,thetad, vehicleImage);


ax1 = gca;


%----------------------------------------------------------------------------
%Cross-Track Error Figure
%----------------------------------------------------------------------------

if (singleFigure == true)
    h3=subplot(1,3,3); hold on, grid on
else
    h3=figure(3); hold on, grid on
end
cla
costArray(costIndex) = abs(d);

if (t>=refT && use2laps == true)
    if (lapCounter == 1)
        lap2costStartIndex = costIndex;
        fprintf("Soma Custo Total Lap-1: %.2f\n", sum(costArray(1:lap2costStartIndex)))
        lapCounter = -1;
    end
    plot([0:h:refT], costArray(1:lap2costStartIndex), '-b','LineWidth',2.5)
    plot([refT:h:t], costArray(lap2costStartIndex:costIndex), '-g','LineWidth',2.5)
else
    plot(TimeArray, costArray(1:costIndex), '-b','LineWidth',2.5)
end


xlim([0,t+0.5])
ylim([0, max(costArray+0.1)])
media = mean(costArray);
plot(TimeArray,ones(1,length(TimeArray))*media,'-r','LineWidth',0.8)


ax3 = gca;

