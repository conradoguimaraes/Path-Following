function drawRCP()
    global Xarc1 Yarc1
    global Xarc2 Yarc2
    global Xarc3 Yarc3
    global Xarc4 Yarc4
    global Xarc5 Yarc5
    global Xarc6 Yarc6
    global Xarc7 Yarc7
    global Xarc8 Yarc8
    global Xarc9 Yarc9
    global Xarc10 Yarc10

    global LineA1B1x LineA1B1y
    global LineB2C1x LineB2C1y
    global LineC2D1x LineC2D1y
    global LineD2E1x LineD2E1y
    global LineE2F1x LineE2F1y
    global LineF2G1x LineF2G1y
    global LineG2H1x LineG2H1y
    global LineH2I1x LineH2I1y
    global LineI2J1x LineI2J1y
    global LineJ2A2x LineJ2A2y
    
    
    singleFigure = true;
    if (singleFigure == true)
        figure(1),hold on,grid on

        subplot(1,2,1), hold on, axis square
        image_filename = 'rcp2.png';

        % Load the image
        background_image = imread(image_filename);
        [ySize, xSize, ~] = size(background_image);
        xlim([2, xSize-5])
        ylim([2, ySize-5])
        % Plot the image
        imshow(background_image);
        plot(Xarc1,Yarc1,'-g','LineWidth',2)
        plot(Xarc2,Yarc2,'-g','LineWidth',2)
        plot(Xarc3,Yarc3,'-g','LineWidth',2)
        plot(Xarc4,Yarc4,'-g','LineWidth',2)
        plot(Xarc5,Yarc5,'-g','LineWidth',2)
        plot(Xarc6,Yarc6,'-g','LineWidth',2)
        plot(Xarc7,Yarc7,'-g','LineWidth',2)
        plot(Xarc8,Yarc8,'-g','LineWidth',2)
        plot(Xarc9,Yarc9,'-g','LineWidth',2)
        plot(Xarc10,Yarc10 ,'-g','LineWidth',2)

        plot(LineA1B1x,LineA1B1y,'-g','LineWidth',2)
        plot(LineB2C1x,LineB2C1y,'-g','LineWidth',2)
        plot(LineC2D1x,LineC2D1y,'-g','LineWidth',2)
        plot(LineD2E1x,LineD2E1y,'-g','LineWidth',2)
        plot(LineE2F1x,LineE2F1y,'-g','LineWidth',2)
        plot(LineF2G1x,LineF2G1y,'-g','LineWidth',2)
        plot(LineG2H1x,LineG2H1y,'-g','LineWidth',2)
        plot(LineH2I1x,LineH2I1y,'-g','LineWidth',2)
        plot(LineI2J1x,LineI2J1y,'-g','LineWidth',2)
        plot(LineJ2A2x,LineJ2A2y,'-g','LineWidth',2)
        
        
        RegionWidth = 15;
        opacity = 0.1;
        plot(Xarc1,Yarc1,'-','LineWidth',RegionWidth,'Color',[0 1 0 opacity])
        plot(Xarc2,Yarc2,'-','LineWidth',RegionWidth,'Color',[0 1 0 opacity])
        plot(Xarc3,Yarc3,'-','LineWidth',RegionWidth,'Color',[0 1 0 opacity])
        plot(Xarc4,Yarc4,'-','LineWidth',RegionWidth,'Color',[0 1 0 opacity])
        plot(Xarc5,Yarc5,'-','LineWidth',RegionWidth,'Color',[0 1 0 opacity])
        plot(Xarc6,Yarc6,'-','LineWidth',RegionWidth,'Color',[0 1 0 opacity])
        plot(Xarc7,Yarc7,'-','LineWidth',RegionWidth,'Color',[0 1 0 opacity])
        plot(Xarc8,Yarc8,'-','LineWidth',RegionWidth,'Color',[0 1 0 opacity])
        plot(Xarc9,Yarc9,'-','LineWidth',RegionWidth,'Color',[0 1 0 opacity])
        plot(Xarc10,Yarc10 ,'-','LineWidth',RegionWidth,'Color',[0 1 0 opacity])

        plot(LineA1B1x,LineA1B1y,'-','LineWidth',RegionWidth,'Color',[0 1 0 opacity])
        plot(LineB2C1x,LineB2C1y,'-','LineWidth',RegionWidth,'Color',[0 1 0 opacity])
        plot(LineC2D1x,LineC2D1y,'-','LineWidth',RegionWidth,'Color',[0 1 0 opacity])
        plot(LineD2E1x,LineD2E1y,'-','LineWidth',RegionWidth,'Color',[0 1 0 opacity])
        plot(LineE2F1x,LineE2F1y,'-','LineWidth',RegionWidth,'Color',[0 1 0 opacity])
        plot(LineF2G1x,LineF2G1y,'-','LineWidth',RegionWidth,'Color',[0 1 0 opacity])
        plot(LineG2H1x,LineG2H1y,'-','LineWidth',RegionWidth,'Color',[0 1 0 opacity])
        plot(LineH2I1x,LineH2I1y,'-','LineWidth',RegionWidth,'Color',[0 1 0 opacity])
        plot(LineI2J1x,LineI2J1y,'-','LineWidth',RegionWidth,'Color',[0 1 0 opacity])
        plot(LineJ2A2x,LineJ2A2y,'-','LineWidth',RegionWidth,'Color',[0 1 0 opacity])
        

        subplot(1,2,2), hold on, axis square
        

        %FullScreen:
        set(gcf, 'Position', get(0, 'Screensize'));

    end
end