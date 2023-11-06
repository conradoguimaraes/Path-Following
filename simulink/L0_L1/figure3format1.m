axes('fontsize',afs)  %35
hold on
set(gca,'XGrid','on', 'YGrid','on','GridLineStyle','-');
set(gca,'XMinorGrid','off', 'YMinorGrid','off','MinorGridLineStyle','-.');
set(gca,'Fontsize',afs);
xlabel('$t$ [$s$]','fontsize',labfs,'interpreter','latex')
ylabel('$d$ [$rad$]','fontsize',labfs,'interpreter','latex')
% xlim([-0.60 0.6])
% ylim([0.4 0.9])
title("Figure 3")