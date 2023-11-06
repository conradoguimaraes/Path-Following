axes('fontsize',afs)  %35
hold on
set(gca,'XGrid','on', 'YGrid','on','GridLineStyle','-');
set(gca,'XMinorGrid','off', 'YMinorGrid','off','MinorGridLineStyle','-.');
set(gca,'Fontsize',afs);
xlabel('$\phi$ [$rad$]','fontsize',labfs,'interpreter','latex')
ylabel('$\beta$  [$rad$]','fontsize',labfs,'interpreter','latex')
xlim([-0.60 0.6])
ylim([0.1 0.9])
title("Figure 2")