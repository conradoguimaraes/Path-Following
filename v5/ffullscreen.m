function ffullscreen()

%meter em full screen
% set(gcf, 'units','normalized','outerposition',[0 0 1 1]);

% s = get(0, 'ScreenSize');
% figure('Position', [0 0 s(3) s(4)])
% s(3)
% s(4)

% Set up figure properties:
% Enlarge figure to full screen.
%     set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% Get rid of tool bar and pulldown menus that are along top of figure.
%     set(gcf, 'Toolbar', 'none', 'Menu', 'none');


 % get the figure and axes handles
 hFig = gcf;
 hAx  = gca;
 % set the figure to full screen
 set(hFig,'units','normalized','outerposition',[0 0 1 1]);
 % set the axes to full screen
 set(hAx,'Unit','normalized','Position',[0 0 1 1]);
 % hide the toolbar
 set(hFig,'menubar','none')
 % to hide the title
 set(hFig,'NumberTitle','off');

end
