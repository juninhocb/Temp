%% Representação do Robo SCARA em MATLAB 

%% Utilizando a biblioteca de Peter Corke.

% Instânciando as juntas
L1 = Link('d', 10, 'a', 0, 'alpha', 0)
L1.isrevolute
L1.A(0.2)

%L2 = Link('d', 0, 'a', 5, 'alpha', 0)
%L2.isrevolute
%L2.A(0.2)
L2 = Link([0,0,5,0,1]);
L2.qlim = [0,0];

%L3 = Link([0,0,0,0,1]);
%L3.qlim = [0,0];

L4 = Link('d', 0, 'a', 10, 'alpha', 0)
L4.isrevolute
L4.A(0.2)

L5 = Link('d', -15, 'a', 0, 'alpha', 0)
L5.isrevolute

bot = SerialLink([L1 L2 L4 L5], 'name', 'SCARA')
% Disponibilza as informações de nosso robô
bot.n
% Cinemática do Robô
bot.fkine([0.2 0.2 0.2 0.2])

% Apresentação do Robô
bot.plot([0.2 0 0.2 0.2])