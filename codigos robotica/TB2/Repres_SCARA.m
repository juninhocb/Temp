%% Representa��o do Robo SCARA em MATLAB 

%% Utilizando a biblioteca de Peter Corke.

% Inst�nciando as juntas
L1 = Link('d', 1, 'a', 0, 'alpha', 0)
L1.isrevolute
L1.A(0.2)

L2 = Link([0,0,1,0,1]);
L2.isprismatic
L2.qlim = [0,0];

L3 = Link('d', 0, 'a', 1, 'alpha', 0)
L3.isrevolute
L3.A(0.2)

L4 = Link('d', -1, 'a', 0, 'alpha', 0)
L4.isrevolute

bot = SerialLink([L1 L2 L3 L4], 'name', 'SCARA')
% Disponibilza as informa��es de nosso rob�
bot.n
% Cinem�tica do Rob�
bot.fkine([0.2 0.2 0.2 0.2])

% Apresenta��o do Rob�
bot.plot([0.2 0 0.2 0.2])

% Jacobiano 
q = [0 0 0 0];
J0 = bot.jacob0(q);