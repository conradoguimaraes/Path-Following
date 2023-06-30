%%
clc,clear,close all





t = 0:0.01:10;

delta = pi/2;
a = 1
A = 50;
C = 50;
x = A*sin(a*t + delta) + C;

b = 1
B = 50;
D = 50;
y = B*sin(b*t) + D;


figure(1), hold on, grid on
plot(x,y,'-b')
axis square
% xticks([-1:1:1])
% yticks([-1:1:1])

%title('$$Q \geq \frac{I_h H}{I_h H+I_z C}, b_1 \geq b_2$$','interpreter','latex')

phrase = '$$ a=1, b=1, \delta = \frac{\pi}{2}$$'
% text(-0.5,-1.5,phrase, 'interpreter','latex','FontSize',14)




set(gcf, 'Position',  [500, 100, 800, 800])
set(gcf, 'Color', 'w');
