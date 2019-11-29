%% Cálculos para o jacobiano 

syms theta1 theta2 theta3 theta4 L1 L2 L3 L4 alfai thetai ai di 

H01 = [cos(theta1 + 90) -sin(theta1 + 90) 0 0; sin(theta1 + 90) cos(theta1 + 90) 0 0; 0 0 1 L1; 0 0 0 1];

H12 = [1 0 0 L2; 0 1 0 0; 0 0 1 0; 0 0 0 1];

H23 = [cos(theta2) -sin(theta2) 0 L3*cos(theta2); sin(theta2) cos(theta2) 0 L3*sin(theta2); 0 0 1 0; 0 0 0 1];

H34 = [cos(theta4) sin(theta4) 0 0; sin(theta4) -cos(theta4) 0 0; 0 0 -1 -theta3; 0 0 0 1];

H02 = H01 * H12;

H03 = H02 * H23;

H04 = H03 * H34;

DH = [cos(thetai) -cos(alfai)*sin(thetai) sin(alfai)*sin(thetai) ai*cos(thetai); ...
    sin(thetai) cos(alfai)*cos(thetai), - sin(alfai)*cos(thetai) ai*sin(thetai); ...
    0 sin(alfai) cos(alfai) di; 0 0 0 1];