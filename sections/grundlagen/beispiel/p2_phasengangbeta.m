function [] = p2_phasengangbeta(n, t_s, reglertyp, ueberschwingung, bode)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


% regelertyp: 0=P-Regler; 1=i-Regler; 2=PI-Regler; 3=PID-Regler
% Überschwingung: 0=0%; 1=4.6%;  2=16.3%;  3=23.3%;

%Diese Funktion wurde im Rahmen einer Projektarbeit an der FHNW
%Brugg-Windisch erstellt. Aller Rechte vorbehalten.
%
%Erstellt durch: Benjamin Müller
%Datum: 4.3.2015
%
%Geprüft durch:
%Datum:

%Mit der Variable Test = 1 werden einige Werte zur überwachung ausgegeben
%mit Test = 2 zusätzlich noch die Plots
test=1;

if (test==2)
    bode=1;
end;




syms omega
amplGang=1;
for k=1:n 
    amplGang=amplGang*(1/sqrt(1+omega^2*t_s(k)^2));
end;
phasenGang=0;
for k=1:n 
    phasenGang=phasenGang-atan(omega*t_s(k));
end;

if (bode ==1) %Bodediagramm Ploten
    
    omega_num=logspace(-2, 2, 1e3);
    
    %Amplitudengang
    subplot(2,1,1);
    loglog(omega_num,subs(amplGang,omega,omega_num));
    hold on; grid on;
    
    %Phasengang
    subplot(2,1,2);
    semilogx(omega_num,subs(phasenGang,omega,omega_num));
    hold on, grid on;
end;



%Überschwingungsdefinition

if (ueberschwingung == 0) % 0%
    phi_s=-1.8099064; %-103.7/180*pi
elseif (ueberschwingung ==1)% 4.6%
    phi_s=-2.0001473; %-114.6/180*pi
elseif (ueberschwingung ==2)% 16.3%    
    phi_s=-2.2427481; %-128.5/180*pi
else % 23.3%
    phi_s=-2.3561945; %-135/180*pi
end;



%alpha bestimmen für die einzelnen Regler

if (reglertyp == 1) %I-Regler
     error('!!!! Nicht implementiert zum jetzigen Zeitpunkt !!!!');
     %alpha= -45/180*pi;
end;

if (reglertyp == 2) %PI-Regler
    alpha=-1.5707963 %-90/180*pi
end;

if (reglertyp == 3) %PID-Regler
    alpha= -135/180*pi; 
    %phasenGang_regler=atan(omega*t_nk)+atan(omega*t_vk)-atan(omega*t_p)-pi/2; 
end;




%Bestimmung der Frequenz im Punkt Phasengang = alpha mithilfe einer
%Näherung

xx=1;
k=0;
xx_u=0.001;
while (k<1)
    yy=subs(phasenGang,omega,xx);
    if (yy > alpha)
        xx_u=xx;
        xx=xx*2;
        k=0;
    elseif (yy < alpha)
        k=2;
        xx_o=xx;
    end;
end;
for k=0:20
    xx=(xx_o-xx_u)/2+xx_u;
    yy=subs(phasenGang,omega,xx);
    if (yy > alpha)
        xx_u=xx;
    elseif (yy < alpha)
        xx_o=xx;
    end;
end;
omega_regler=xx;
clear k xx_u xx_o xx yy ;
    
%Ausgabe berechneter Werte zur Kontrolle
if (test > 0)
    disp('Vergleich von der angenäherten Frequenz eingesetzt in den Phasengang zu alpha')
    vpa(subs(phasenGang,omega,omega_regler),8)
    alpha
end;
    


%Reglerspezifische Berechnungen

if (reglertyp == 2) %PI-Regler
    %Berechnung T_n
    t_n=1/omega_regler

    %Berechnung Phasengang Regler und Summe Streche + Regler
    phasenGang_regler=atan(omega*t_n)-pi/2;
    phasenGang_summe=phasenGang+phasenGang_regler;
    
    %Berechnung Phasengang Regler mit Kp=1
    amplGang_regler=1*(1+1/t_n);
    
    %Plot zur Kontrolle
    if (bode==1)
        subplot(2,1,2);
        plot(omega_num,subs(phasenGang_regler,omega,omega_num),'r');
        plot(omega_num,subs(phasenGang_summe,omega,omega_num),'g');
        subplot(2,1,1);
        plot(omega_num,subs(amplGang_regler,omega,omega_num),'r');
    end;
    
    %Bestimmung der Frequenz im Punkt Phasengang_summe = phi_s mithilfe einer
    %Näherung
    xx=1;
    k=0;
    xx_u=0.001;
    while (k<1)
        yy=subs(phasenGang_summe,omega,xx);
        if (yy > phi_s)
            xx_u=xx;
            xx=xx*2;
            k=0;
         elseif (yy < phi_s)
            k=2;
            xx_o=xx;
         end;
    end;
    for k=0:20
        xx=(xx_o-xx_u)/2+xx_u;
        yy=subs(phasenGang_summe,omega,xx);
        if (yy > phi_s)
            xx_u=xx;
        elseif (yy < phi_s)
            xx_o=xx;
        end;
    end;
    omega_durchtritt=xx;
    clear k xx_u xx_o xx yy ;
    
     %Ausgabe berechneter Werte zur Kontrolle
    if (test > 0)
        disp('Vergleich von der angenäherten Frequenz eingesetzt in den Phasengang zu phi_s')
        vpa(subs(phasenGang_summe,omega,omega_durchtritt),8)
        phi_s
    end;   
end;


end

