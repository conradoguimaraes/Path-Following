h1=legend({'$d$','$\bar{d}_{40s}=0.0108$', '$\bar{d}_{35s}=0.0027$'},...
         'Location','northeast','Orientation','Vertical');
set(h1,'fontsize',legfs,'interpreter','latex');
%-------------------------------------------------

fig_name ='L0_'+string(L_0)+'dist.jpg';
saveas(gcf,fig_name)