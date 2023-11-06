clear all; 
clc
close all;

L_0=3/sqrt(2);
%L_0=1;
L0=L_0*pi/180;
betinho=-15;
phizinho=30;
lgd_position='southeast';
%lgd_position='southwest';
%lgd_position='northeast';

% %%% plot parameters
% labfs = 22; % label font size
% legfs = 12; % legend font size
% afs   = 22; % axis font size
% lw_t    =  2; % trajectory line width
% lw_k    =  1.5; % kite line width

%%% plot parameters for figure 3 and 4
labfs = 22; % label font size
legfs = 12; % legend font size
afs   = 22; % axis font size
lw_t    =  1.5; % trajectory line width
lw_k    =  1; % kite line width

%Parameters
Ro= 1.2;    % Fluid Density
vw=10;       % Fluid Velocity [m s-1]
m=0.7;        % Mass [Kg]
A=0.28;       % Wing Reference Area of Kite [m^2]
g=9.8;      % Gravidade

% R, Beta, Phi
rmin=50;    % Comprimento mínimo do cabo
rmax=275;   % Comprimento máximo do cabo

phi_star=0*pi/180;      % Phi referência
delta_phi=20*pi/180;    % Variação de phi

beta_star=40*pi/180;    % Beta referência
delta_beta=10*pi/180;   % Variação de beta

%Initial Conditions Retraction phase controller uncomment for RETRACTION
%PHASE
% r0=250;
% beta0=80*pi/180;%going to check an equilibrium point
% phi0=phi_star;%+15*pi/180;
% dr0=0;
% dbeta0=0*pi/180;
% dphi0=0*pi/180;

%Initial Conditions traction phase controller uncomment for TRACTION PHASE
r0= rmin;%rmax;%rmin;%rmax;                              % R inicial
beta0=beta_star+betinho*pi/180;            % Beta inicial
phi0=phi_star+phizinho*pi/180;%-20*pi/180;              % Phi inicial
dr0=0;                                % Velocidade inicial em r
dbeta0=0*pi/180;                      % Velocidade inicial em beta 
dphi0=-0.1*pi/180;                     % Velocidade inicial em phi

% Reta de cima
n1=276;
h1=2*delta_phi/(n1-1);
x1=phi_star-delta_phi:h1:phi_star+delta_phi;
y1=ones(size(x1))*(beta_star+delta_beta);

% Curva da direita
n2=205;
h2=pi/(n2-1);
t1=pi/2:h2:(3/2)*pi;
x2=(phi_star+delta_phi)-delta_beta*cos(t1);
y2=beta_star+delta_beta*sin(t1);

% Reta de baixo
n3=276;
h3=2*delta_phi/(n3-1);
x3i=phi_star-delta_phi:h3:phi_star+delta_phi;
x3=wrev(x3i);
y3=ones(size(x3))*(beta_star-delta_beta);

% Curva da esquerda
n4=205;
h4=pi/(n4-1);
t2=-pi/2:h4:pi/2;
x4=phi_star-delta_phi-delta_beta*cos(t2);
y4=beta_star+delta_beta*sin(t2);

% Trajetoria Completa
phi_total=[x1 x2 x3 x4];
beta_total=[y1 y2 y3 y4];
size=length(phi_total);
imax=size; 

sim('Kite')

r_total=Kite1(end,1)*ones(1,size);

% Trajetorias

Traj_L=[r_total;
        phi_total;
        beta_total];

Traj_G=[r_total.*cos(beta_total).*cos(phi_total);
        r_total.*cos(beta_total).*sin(phi_total);
        r_total.*sin(beta_total)];
   

[xs,ys,zs] = sphere;        %# Makes a 21-by-21 point sphere
xs = xs(11:end,6:16);       %# Keep top 11 x points
ys = ys(11:end,6:16);       %# Keep top 11 y points
zs = zs(11:end,6:16);       %# Keep top 11 z points
rs = Kite1(end,1);                  %# A radius value



%-------------------------------------------------
figure(1)
%-------------------------------------------------
plot3(Traj_G(1,:), Traj_G(2,:), Traj_G(3,:),'--r','Linewidth',lw_t)
%-------------------------------------------------
xlabel('X')
ylabel('Y')
zlabel('Z')
hold all
%plot3(cG(1),cG(2),cG(3), 'o')
lightGrey = 0.8*[1 1 1]; % It looks better if the lines are lighter
surface(rs.*xs,rs.*ys,rs.*zs,'FaceColor', 'none','EdgeColor',lightGrey)
axis equal;            %# Make the scaling on the x, y, and z axes equal
% for i=1:100:length(Kitet)
%      %plot3(Traj_G(1,indice_ref(i)), Traj_G(2,indice_ref(i)), Traj_G(3,indice_ref(i)), '*c')
%      %plot3(Kite(indice_ref(i), 1), Kite(indice_ref(i), 2), Kite(indice_ref(i), 3), '*r')
%      plot3([Traj_G(1, Kitet(i,4)) Kitet(i,1)], [Traj_G(2,Kitet(i,4)) Kite(i, 2) ], [Traj_G(3,Kitet(i,4)) Kite(i, 3)], 'r')
%   
% end
%-------------------------------------------------
plot3(Kite(:,1), Kite(:,2), Kite(:,3), 'k','Linewidth',lw_k)
plot3(Kite(1,1), Kite(1,2), Kite(1,3),'+k')
% plot3(Traj_G(1,ind_follow), Traj_G(2,ind_follow), Traj_G(3,ind_follow),'+g')
%-------------------------------------------------
%-------------------------------------------------
saveas(gcf,'r_phi_beta_3D.jpg')
saveas(gcf,'3d.fig')
%-------------------------------------------------
%-------------------------------------------------
%-------------------------------------------------
%-------------------------------------------------
%-------------------------------------------------
%-------------------------------------------------
figure(2) %2D phi vs Beta
%-------------------------------------------------
axes('fontsize',afs)  %35
hold on
set(gca,'XGrid','on', 'YGrid','on','GridLineStyle','-');
set(gca,'XMinorGrid','off', 'YMinorGrid','off','MinorGridLineStyle','-.');
set(gca,'Fontsize',afs);
xlabel('$\phi$ [$rad$]','fontsize',labfs,'interpreter','latex')
ylabel('$\beta$  [$rad$]','fontsize',labfs,'interpreter','latex')
xlim([-0.60 0.6])
ylim([0.1 0.9])

%-------------------------------------------------
plot(Traj_L(2,:),Traj_L(3,:),'--r','Linewidth',lw_t)
hold all
%-------------------------------------------------
%plot(Traj_L(2,ind_follow),Traj_L(3,ind_follow),'+r')
plot(Kite1(:,2), Kite1(:,3), 'k','Linewidth',lw_k)
plot(Kite1(1,2), Kite1(1,3),'+k','Linewidth',lw_k)
%-------------------------------------------------
h1=legend({'Path','Kite Position'},...
         'Location',lgd_position,'Orientation','Vertical');
set(h1,'fontsize',legfs,'interpreter','latex');

fig_name ='L0_'+string(L_0)+'_beta'+string(betinho)+'_phi'+string(phizinho)+'.jpg';
saveas(gcf,fig_name)
%-------------------------------------------------
%-------------------------------------------------
%-------------------------------------------------
%-------------------------------------------------
%-------------------------------------------------
%-------------------------------------------------
figure(3) %Cross Track Error
%-------------------------------------------------
axes('fontsize',afs)  %35
hold on
set(gca,'XGrid','on', 'YGrid','on','GridLineStyle','-');
set(gca,'XMinorGrid','off', 'YMinorGrid','off','MinorGridLineStyle','-.');
set(gca,'Fontsize',afs);
xlabel('$t$ [$s$]','fontsize',labfs,'interpreter','latex')
ylabel('$d$ [$rad$]','fontsize',labfs,'interpreter','latex')
% xlim([-0.60 0.6])
% ylim([0.4 0.9])
%-------------------------------------------------
plot(tout, cross_track_error, 'k','Linewidth',lw_k)
plot(tout, ones(1,length(tout))*error_integral(end)/40, ':r', 'Linewidth',lw_k+1)
plot(tout(tout>5), ones(1,length(tout(tout>5)))*error_integral_5s(end)/35, '--k', 'Linewidth',lw_k+1)
%-------------------------------------------------
h1=legend({'$d$','$\bar{d}_{40s}=0.0108$', '$\bar{d}_{35s}=0.0027$'},...
         'Location','northeast','Orientation','Vertical');
set(h1,'fontsize',legfs,'interpreter','latex');
%-------------------------------------------------

fig_name ='L0_'+string(L_0)+'dist.jpg';
saveas(gcf,fig_name)

disp('Error Full: ')
disp(error_integral(end)/40)

disp('Error >5s: ')
disp(error_integral_5s(end)/35)
%-------------------------------------------------




%%


% figure(3)
% % Plot options
% axes('fontsize',afs)  %35
% grid on, hold on
% set(gca,'XGrid','on', 'YGrid','on','GridLineStyle','-');
% set(gca,'XMinorGrid','off', 'YMinorGrid','off','MinorGridLineStyle','-.');
% set(gca,'Fontsize',afs);
% xlabel('$t$ [$s$]','fontsize',labfs,'interpreter','latex')
% ylabel('$\phi$ [$rad$]','fontsize',labfs,'interpreter','latex')
% xlim([0 20])
% ylim([-0.6 0.6])
% plot(tout,Kite1(:,2),'k','Linewidth',lw_k)
% plot(tout,Traj_L(2,ind_min),'--r','Linewidth',lw_t)
% 
% h1=legend({'${\phi}$','${\phi_{path}}$'},...
%          'Location','southeast','Orientation','Vertical');
% set(h1,'fontsize',legfs+3,'interpreter','latex');
% 
% % axes('position',[.6 .25 .25 .25])
% % indexOfInterest = (tout>=0)& (tout<=5); % range of t near perturbation
% % plot(tout(indexOfInterest),Kite1(indexOfInterest,2),'-b'); % plot on new axes
% % %xlim=[0 0.2];
% % hold on
% % phi_path = Traj_L(2,:);
% % plot(tout(indexOfInterest),phi_path(indexOfInterest),'--r') % plot on new axes
% % axis tight
% 
% phi_path='L0_'+string(L_0)+'phi_path.jpg';
% saveas(gcf,phi_path)
% 
% 
% 
% figure(4)
% % Plot options
% axes('fontsize',afs)  %35
% %axis tight
% grid on, hold on
% % set(gca,'XGrid','on', 'YGrid','on','GridLineStyle','-');
% % set(gca,'XMinorGrid','off', 'YMinorGrid','off','MinorGridLineStyle','-.');
% set(gca,'Fontsize',afs);
% xlabel('$t$ [$s$]','fontsize',labfs,'interpreter','latex')
% ylabel('$\beta$ [$rad$]','fontsize',labfs,'interpreter','latex')
% xlim([0 20])
% ylim([0.4 0.9])
% plot(tout,Kite1(:,3),'k','Linewidth',lw_k)
% plot(tout,Traj_L(3,ind_min),'--r','Linewidth',lw_t)
% 
% h1=legend('${\beta}$','${\beta_{path}}$',...
%          'Location','southeast','Orientation','Vertical');
% set(h1,'fontsize',legfs+3,'interpreter','latex');

% axes('position',[.25 .25 .3 .25])
% indexOfInterest = (tout>=0)& (tout<=10); % range of t near perturbation
% plot(tout(indexOfInterest),Kite1(indexOfInterest,3),'-b') % plot on new axes
% %ylim=[0.25 1];
% hold on
% beta_path = Traj_L(2,:)';
% beta_path(indexOfInterest)
% plot(tout(indexOfInterest),beta_path(indexOfInterest),'--r')
% %
% beta_path='L0_'+string(L_0)+'beta_path.jpg';
% saveas(gcf,beta_path)
