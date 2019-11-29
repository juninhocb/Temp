function result = funcionobjetivo(x,y)

% % EXEMPLO 1
% X1 = x(1);
% X2 = x(2);
% 
% result = (X1 - 10)^2 + (X2 - 20)^2;
% 








% EXEMPLO 2
% Manipulador 3 DoF

Theta1 = x(1);
Theta2 = x(2);


L1 = 300;     %Comprimento das pernas
L2 = 150;


Px = 220;    %Posição desejada em X
Py = 100;    %Posição desejada em Y

% Cinematica direta
Efx = L1*cosd(Theta1) + L2*cosd(Theta1 + Theta2); 
Efy = L1*sind(Theta1) + L2*sind(Theta1 + Theta2); 

% Penalizacion de singularidades
pen = 0;
if ((Theta1 > 359) | (Theta1 < 0) | (Theta2 > 359) | (Theta2 < 0))
    pen = pen + 999999999999999;
end

result = (Px - Efx)^2 + (Py - Efy)^2 + pen;

