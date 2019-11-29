%% Representação do Robo SCARA em MATLAB 

%% Utilizando a biblioteca de Peter Corke.

% Instânciando as juntas
L1 = Link('d', 300, 'a', 0, 'alpha', 0)
L1.isrevolute

%L2 = Link([0,0,1,0,1]);
%L2.isprismatic
%L2.qlim = [0,0];
L2 = Link('d', 0, 'a',300, 'alpha', 0)
L2.isrevolute


L3 = Link('d', 0, 'a', 100, 'alpha', 0)
L3.isrevolute

L4 = Link('d', -150, 'a', 0, 'alpha', 0)
L4.isrevolute



robo = SerialLink([L1 L2 L3 L4 ], 'name', 'SCARA')

qf0 = [0 deg2rad(63.9583) deg2rad(201.5652)  0];
qf1 = [0 deg2rad(51.1247) deg2rad(191.794) 0];
% Primeira iteração
qf2 = [0 deg2rad(51.1247) deg2rad(191.794) 0];
qf3 = [0 deg2rad(55.3788) deg2rad(202.9109) 0];
% Segunda iteração
qf4 = [0 deg2rad(55.3788) deg2rad(202.9109) 0];
qf5 = [0 deg2rad(17.1522) deg2rad(150.7179) 0];
% Terceira iteração 
qf6 = [0 deg2rad(17.1522) deg2rad(150.7179) 0];
qf7 = [0 deg2rad(56.4011) deg2rad(211.3016) 0];
% Quarta iteração
qf8 = [0 deg2rad(56.4011) deg2rad(211.3016) 0];
qf9 = [0 deg2rad(61.634) deg2rad(215.054) 0];
% Quinta iteração
qf10 = [0 deg2rad(61.634) deg2rad(215.054) 0];
qf11 = [0 deg2rad(61.178) deg2rad(218.561) 0];
% Sexta iteração 
qf12 = [0 deg2rad(61.178) deg2rad(218.561) 0];
qf13 = [0 deg2rad(61.634) deg2rad(215.054) 0];
% Sétima iteração
qf14 = [0 deg2rad(61.178) deg2rad(218.561) 0];
qf15 = [0 deg2rad(63.2542) deg2rad(216.3361) 0];
% Oitava iteração
qf16 = [0 deg2rad(63.2542) deg2rad(216.3361) 0];
qf17 = [0 deg2rad(61.9769) deg2rad(223.1136) 0];
% Nona iteração
qf18 = [0 deg2rad(61.9769) deg2rad(223.1136) 0];
qf19 = [0 deg2rad(55.4261) deg2rad(226.017) 0];
% Décima iteração
qf20 = [0 deg2rad(55.4261) deg2rad(226.017) 0];
qf21 = [0 deg2rad(54.1827) deg2rad(233.0505) 0];
% Décima primeira iteração
qf22 = [0 deg2rad(54.1827) deg2rad(233.0505) 0];
qf23 = [0 deg2rad(56.416) deg2rad(243.7056) 0];
% Décima segunda iteração 
qf24 = [0 deg2rad(56.416) deg2rad(243.7056) 0];
qf25 = [0 deg2rad(57.9669) deg2rad(227.8471) 0];
% Décima terceira iteração
qf26 = [0 deg2rad(57.9669) deg2rad(227.8471) 0];
qf27 = [0 deg2rad(60.3005) deg2rad(229.7927) 0];
% Décima terceira iteração
qf28 = [0 deg2rad(60.3005) deg2rad(229.7927) 0];
qf29 = [0 deg2rad(58.5458) deg2rad(236.4804) 0];
% Décima quarta iteração
qf30 = [0 deg2rad(58.5458) deg2rad(236.4804) 0];
qf31 = [0 deg2rad(52.6198) deg2rad(240.0735) 0];
% Décima quinta iteração
qf32 = [0 deg2rad(52.6198) deg2rad(240.0735) 0];
qf33 = [0 deg2rad(50.7953) deg2rad(247.1837) 0];
% Décima sexta iteração
qf34 = [0 deg2rad(50.7953) deg2rad(247.1837) 0];
qf35 = [0 deg2rad(56.5133) deg2rad(243.2563) 0];
% Décima setima iteração
qf36= [0 deg2rad(56.5133) deg2rad(243.2563) 0];
qf37= [0 deg2rad(54.3017) deg2rad(250.1908) 0];







tempo = 0:1:1;
q1 = jtraj(qf0, qf1, tempo);
robo.plot(q1, 'trail', 'r--')
hold on
pause(1)
q2 = jtraj(qf2, qf3, tempo);
robo.plot(q2, 'trail', 'r--')
pause(1)
hold on 
q3 = jtraj(qf4, qf5, tempo);
robo.plot(q3, 'trail', 'r*')
pause(1)
hold on 
q4 = jtraj(qf6, qf7, tempo);
robo.plot(q4)
pause(1)
hold on 
q5 = jtraj(qf8, qf9, tempo);
robo.plot(q5)
pause(1)
hold on 
q6 = jtraj(qf10, qf11, tempo);
robo.plot(q6)
hold on 
pause(1)
q7 = jtraj(qf12, qf13, tempo);
robo.plot(q7)
hold on 
pause(1)
q8 = jtraj(qf14, qf15, tempo);
robo.plot(q8)
hold on 
pause(1)
q9 = jtraj(qf16, qf17, tempo);
robo.plot(q9)
hold on 
pause(1)
q10 = jtraj(qf18, qf19, tempo);
robo.plot(q10)
hold on 
pause(1)
q11 = jtraj(qf20, qf21, tempo);
robo.plot(q11)
hold on 
pause(1)
q12 = jtraj(qf22, qf23, tempo);
robo.plot(q12)
hold on 
pause(1)
q13 = jtraj(qf24, qf25, tempo);
robo.plot(q13)
hold on 
pause(1)
q14 = jtraj(qf26, qf27, tempo);
robo.plot(q14)
hold on 
pause(1)
q15 = jtraj(qf28, qf29, tempo);
robo.plot(q15)
hold on 
pause(1)
q16 = jtraj(qf30, qf31, tempo);
robo.plot(q16)
hold on 
pause(1)
q17 = jtraj(qf32, qf33, tempo);
robo.plot(q17)
hold on 
pause(1)
q18 = jtraj(qf34, qf35, tempo);
robo.plot(q18)
hold on 
pause(1)
q19 = jtraj(qf36, qf37, tempo);
robo.plot(q19)
hold on 
pause(1)



















