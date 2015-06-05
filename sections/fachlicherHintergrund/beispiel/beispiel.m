% TODO: Extract T_u, T_g, K_s from step response of system
% Assume values for now:

clear all;clc
% Tu=1;
% Tg=3;
Tu=1.1;
Tg=8.9;
Ks=2;

figure;
% Create Step Response Plot
[n,T] = p2_sani(Tu,Tg,Ks);
hold on;
plot([Tu,Tu+Tg],[0,1],'r','LineWidth',1);
plot([Tu,Tu],[0,1],'--r','LineWidth',1);
plot([Tg+Tu,Tg+Tu],[0,1],'--r','LineWidth',1);
plot([0,Tu],[0.1,0.1],'b','LineWidth',2);
plot([Tu,Tg+Tu],[1-0.1,1-0.1],'b','LineWidth',2);
% legend('Schrittantwort Strecke','Wendetangente','T_u','T_g+Tu','T_u','T_g');
text(Tu,-0.06,'T_u');
text(Tu+Tg,-0.06,'T_u+T_g');
text(Tu/2,0.12,'Tu');
text((Tu+Tg)/2,.92,'Tg');


% Create Frequency responses
figure;
%p2_phasengang(n, T, Ks,2, 2, 1) % PI
p2_phasengang(n, T, Ks,3, 2, 1) % PID