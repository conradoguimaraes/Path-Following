h1=legend({'Path','Kite Position'},...
         'Location',lgd_position,'Orientation','Vertical');
set(h1,'fontsize',legfs,'interpreter','latex');

fig_name ='L0_'+string(L_0)+'_beta'+string(betinho)+'_phi'+string(phizinho)+'.jpg';
saveas(gcf,fig_name)