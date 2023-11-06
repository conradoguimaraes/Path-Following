%%
Qx = 21.189;
Qy = 9.9671;

w1 = (Qx-reta1Xvector(reta1Xvector>=Qx)).^2;
w2 = (Qy-reta1Yvector(reta1Yvector>=Qy)).^2;


%Array com as distancias entre Q e os restantes
%pontos à sua frente na reta
raiz = sqrt(w1+w2);

L0 = 10
% [val,indice]=min(abs(raiz-L0));
%%
for index=length(raiz):-1:1
   if (raiz(index)<=L0)
       break
   end
end
    

Tx = reta1Xvector(10542)
Ty = reta1Yvector(10542)


%%
for index=length(raiz):-1:1
    Tx = reta1Xvector(index);
    Ty = reta1Yvector(index);
    if (distance(Qx,Qy,Tx,Ty)<=L0)
        break
    end
end
Tx
Ty


%%
diferencaL0ComRaiz = L0-raiz;

array = diferencaL0ComRaiz(diferencaL0ComRaiz>0);
[maximo, indice] = max(array);

Tx = reta1Xvector(indice);
Ty = reta1Yvector(indice);



%%

Qx = 21.192;
Qy = 9.9687;

m = (Y_reta1(end)-Y_reta1(1))/(X_reta1(end)-X_reta1(1))
b = Y_reta1(1)-m*X_reta1(1)


syms x y

eqn1 = y == m*x + b;
eqn2 = 20^2 == (Qx-x)^2 + (Qy-y)^2;

[sol1, sol2] = solve(eqn1, eqn2, x,y);
solucaoX = double(vpa(sol1,3));
solucaoY = double(vpa(sol2,3));

Tx = round(max(solucaoX),2)
Ty = round(max(solucaoY),2)

%%

Qx = 43.932;
Qy = 7.0417;

m = (Y_reta2(end)-Y_reta2(1))/(X_reta2(end)-X_reta2(1))
b = Y_reta2(1)-m*X_reta2(1)


syms x y

eqn1 = y == m*x + b;
eqn2 = 5^2 == (Qx-x)^2 + (Qy-y)^2;

[sol1, sol2] = solve(eqn1, eqn2, x,y);
solucaoX = double(vpa(sol1,3))
solucaoY = double(vpa(sol2,3))


Tx = round(max(solucaoX),2)
Ty = round(max(solucaoY),2)
%%

Qx = 21.189;
Qy = 9.9671;

m = (Y_reta1(end) - Y_reta1(1)) / (X_reta1(end) - X_reta1(1));
b = Y_reta1(1) - m * X_reta1(1);

% Calculate the x and y coordinates directly
x = (Qx + m * (Qy - b)) / (m^2 + 1);
y = m * x + b;

% Calculate the second solution if needed
x2 = 2 * Qx - x;
y2 = 2 * Qy - y;

% Display the results
disp(['First Solution: (', num2str(x, 3), ', ', num2str(y, 3), ')']);
disp(['Second Solution: (', num2str(x2, 3), ', ', num2str(y2, 3), ')']);

