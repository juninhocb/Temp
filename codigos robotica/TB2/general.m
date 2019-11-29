% % EXEMPLO 1
% 
% clc
% 
% VTR = 1.e-12;
% D = 2;                          %Numero de variaveis a otimizar 
% XVmin = [-100 -100];            %no constituyen los limites de busqueda del resultado,  
% XVmax = [100 100];              %solo permiten identificar una poblacion inicial
% y=[];
% NP = 300*D; 
% itermax = 8000; 
% F = 0.8; 
% CR = 0.5; 
% strategy = 7;
% refresh = 100; 
% 
% [bestmem,bestval,nfeval] = devec3('funcionobjetivo',VTR,D,XVmin,XVmax,y,NP,itermax,F,CR,strategy,refresh)




% EXEMPLO 2

clc

VTR = 1.e-12;
D = 4;                          %Numero de variaveis a otimizar 
XVmin = [0 0 0 0];            %no constituyen los limites de busqueda del resultado,  
XVmax = [360 360 360 360];              %solo permiten identificar una poblacion inicial
y=[];
NP = 100*D; 
itermax = 500; 
F = 0.8; 
CR = 0.5; 
strategy = 7;
refresh = 100; 

[bestmem,bestval,nfeval] = devec3('funcionobjetivo',VTR,D,XVmin,XVmax,y,NP,itermax,F,CR,strategy,refresh)




Theta1 = bestmem(1);
Theta2 = bestmem(2);


L1 = 300;     %Comprimento das pernas
L2 = 150;


% Cinematica direta
Ax = 0;
Ay = 0;

Bx = L1*cosd(Theta1); 
By = L1*sind(Theta1); 

Cx = L1*cosd(Theta1) + L2*cosd(Theta1 + Theta2); 
Cy = L1*sind(Theta1) + L2*sind(Theta1 + Theta2); 



line([Ax Bx],[Ay By])
line([Bx Cx],[By Cy])


hold on
plot([Ax],[Ay],'ro')
plot([Ax],[Ay],'rx')
plot([Ax],[Ay],'r+')

plot([Bx],[By],'ro')
plot([Bx],[By],'rx')
plot([Bx],[By],'r+')

plot([Cx],[Cy],'ro')
plot([Cx],[Cy],'rx')
plot([Cx],[Cy],'r+')


grid on

