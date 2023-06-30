function draw8shape()
    global Xarc1 Yarc1
    global Xarc2 Yarc2
    
    global X_reta1 Y_reta1
    global X_reta2 Y_reta2
    
    
    singleFigure = true;
    if (singleFigure == true)
        figure(1),hold on,grid on


%         subplot(1,3,1), hold on
        subplot(1,2,1), hold on, axis square
        % plot(Xarc1,Yarc1,'-r')
        % plot(Xarc2,Yarc2,'-r')
        % plot(Xarc3,Yarc3,'--r')
        % plot(X_reta1,Y_reta1,'-b');
        % plot(X_reta2,Y_reta2,'-b');
        plot(Xarc1,Yarc1,'-k', Xarc2,Yarc2,'-k', ...
            X_reta1,Y_reta1,'-k', X_reta2,Y_reta2,'-k')
        

%         subplot(1,3,2), hold on
%         plot(Xarc1,Yarc1,'-r', Xarc2,Yarc2,'-r', ...
%             X_reta1,Y_reta1,'-b', X_reta2,Y_reta2,'-b')


%         subplot(1,3,3), hold on
        subplot(1,2,2), hold on, axis square
        

        %FullScreen:
        set(gcf, 'Position', get(0, 'Screensize'));
    else
        figure(1),hold on,grid on
        plot(Xarc1,Yarc1,'-r', Xarc2,Yarc2,'-r', ...
            X_reta1,Y_reta1,'-b', X_reta2,Y_reta2,'-b')
        set(gcf, 'Position', get(0, 'Screensize'));
        set(gcf, 'Color', 'w');
%         figure(2),hold on,grid on
%         plot(Xarc1,Yarc1,'-r', Xarc2,Yarc2,'-r', ...
%             X_reta1,Y_reta1,'-b', X_reta2,Y_reta2,'-b')
%         set(gcf, 'Position', get(0, 'Screensize'));
        
        figure(3),hold on,grid on
        xlabel('time')
        ylabel('cross track error')
        set(gcf, 'Position', get(0, 'Screensize'));
        set(gcf, 'Color', 'w');
    end
end