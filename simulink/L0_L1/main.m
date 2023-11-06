%%
clear all; close all; clc


L_0=3/sqrt(2);
L_0 = deg2rad(60)
%L_0=1;
L0=L_0*pi/180;
betinho=-15;
phizinho=30;
lgd_position='southeast';


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
rmax=250;   % Comprimento máximo do cabo

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
%-------------------------------------------------
% Trajetoria Completa
phi_total=[x1 x2 x3 x4];
beta_total=[y1 y2 y3 y4];
size=length(phi_total);
imax=size; 
phiTotal1 = phi_total;
%-------------------------------------------------
sim('Kite')


%-------------------------------------------------
r_total=Kite1(end,1)*ones(1,size);

% Trajetorias

Traj_L=[r_total;
        phi_total;
        beta_total];

Traj_G=[r_total.*cos(beta_total).*cos(phi_total);
        r_total.*cos(beta_total).*sin(phi_total);
        r_total.*sin(beta_total)];

%-------------------------------------------------

[xs,ys,zs] = sphere;        %# Makes a 21-by-21 point sphere
xs = xs(11:end,6:16);       %# Keep top 11 x points
ys = ys(11:end,6:16);       %# Keep top 11 y points
zs = zs(11:end,6:16);       %# Keep top 11 z points
rs = Kite1(end,1);                  %# A radius value



%-------------------------------------------------
f1 = figure(1);
%-------------------------------------------------
f1h1 = plot3(Traj_G(1,:), Traj_G(2,:), Traj_G(3,:),'--r','Linewidth',lw_t);
%-------------------------------------------------
run('figure1format1.m')
%-------------------------------------------------
f1h2 = plot3(Kite(:,1), Kite(:,2), Kite(:,3), 'k','Linewidth',lw_k);
f1h3 = plot3(Kite(1,1), Kite(1,2), Kite(1,3),'+k');
% plot3(Traj_G(1,ind_follow), Traj_G(2,ind_follow), Traj_G(3,ind_follow),'+g')
%-------------------------------------------------
saveas(gcf,'r_phi_beta_3D.jpg')
saveas(gcf,'3d.fig')
set(gcf, 'Color', 'w');
% legend(f1,['Kite Trajectory', 'Desired Path'])


%-------------------------------------------------
figure(2) %2D phi vs Beta
%-------------------------------------------------
run('figure2format1.m')
%-------------------------------------------------
plot(Traj_L(2,:),Traj_L(3,:),'--r','Linewidth',lw_t)
hold all
%-------------------------------------------------
%plot(Traj_L(2,ind_follow),Traj_L(3,ind_follow),'+r')
plot(Kite1(:,2), Kite1(:,3), 'k','Linewidth',lw_k) %curva
plot(Kite1(1,2), Kite1(1,3),'+k','Linewidth',lw_k) %posicao em que come�a
%-------------------------------------------------
run('figure2format2.m')
set(gcf, 'Color', 'w');
title("Kite following the desired path in the $$(\phi,\beta)$$ space",'interpreter','latex')



%-------------------------------------------------
figure(3) %Cross Track Error
%-------------------------------------------------
run('figure3format1.m')
%-------------------------------------------------
plot(tout, cross_track_error, 'k','Linewidth',lw_k)
plot(tout, ones(1,length(tout))*error_integral(end)/40, ':r', 'Linewidth',lw_k+1)
plot(tout(tout>5), ones(1,length(tout(tout>5)))*error_integral_5s(end)/35, '--b', 'Linewidth',lw_k+1)
%-------------------------------------------------
xticks(0:5:60)
run('figure3format2.m')
%-------------------------------------------------
disp('Error Full: ')
disp(error_integral(end)/40)

disp('Error >5s: ')
disp(error_integral_5s(end)/35)
%-------------------------------------------------
set(gcf, 'Color', 'w');
title("Cross-track error progress",'Fontsize',14)




xMinimo = min(x4);
xMaximo = max(x2);

% [rows,cols] = find(tetherLengthArray>=rmax);

% timeRMaxLength = tout(rows(1))

f4 = figure(4), hold on, grid on

%r
subplot(3,1,1), hold on, grid on
h1 = plot(tout, tetherLengthArray);
ylabel("$$r$$"+" (m)"+"$$\hspace{1cm}$$",'interpreter','latex','Fontsize',18,'rotation',0)
title("Simulated $$(r,\phi,\beta)$$ for L0=$60^\circ$",'interpreter','latex')
%phi
subplot(3,1,2), hold on, grid on
% h2 = plot(tout, rad2deg(Kite1(:,2)));
h2 = plot(tout, Kite1(:,2));
ylabel("$$\phi (rad)\hspace{1cm}$$",'interpreter','latex','Fontsize',18,'rotation',0)

%beta
subplot(3,1,3), hold on, grid on
% h3 = plot(tout, rad2deg(Kite1(:,3)));
h3 = plot(tout, Kite1(:,3));
ylabel("$$\beta (rad)\hspace{1cm}$$",'interpreter','latex','Fontsize',18,'rotation',0)


LW = 2
set(h1,'LineWidth',LW)
set(h2,'LineWidth',LW)
set(h3,'LineWidth',LW)
set(gcf, 'Color', 'w');

xlabel("Time (seconds)")



%%
f77 = figure(77), hold on, grid on
subplot(2,1,1), hold on, grid on
h1 = plot(tout, angleOfAttack);
ylabel("$$\alpha \hspace{0.5cm}$$",'interpreter','latex','Fontsize',18,'rotation',0)
title("Simulated $$\alpha$$ and $$\psi$$ for L0=$60^\circ$",'interpreter','latex')
%phi
subplot(2,1,2), hold on, grid on
% h2 = plot(tout, rad2deg(Kite1(:,2)));
h2 = plot(tout, rollAnglePsi);
ylabel("$$\psi \hspace{0.5cm}$$",'interpreter','latex','Fontsize',18,'rotation',0)



%%
figure(5),hold on, grid on

subplot(2,1,1), hold on, grid on
h11 = plot(tout, powerValues,'-b')

title("Generated Power and Energy")

ylabel("Power (W)",'Fontsize',15,'rotation',90)

xticks(0:5:60)
xlim([0, 60])
yticks(0:500:3000)

subplot(2,1,2), hold on, grid on
conversionFactor = 0.0002777778;
h22 = plot(tout, energyValues*conversionFactor,'-b')
xlabel("Time (seconds)")

set(h11,'LineWidth',LW)
set(h22,'LineWidth',LW)
set(gcf, 'Color', 'w');

yticks(0:5:30)
ylabel("Energy (Wh)",'Fontsize',15,'rotation',90)
xticks(0:5:60)
xlim([0, 60])