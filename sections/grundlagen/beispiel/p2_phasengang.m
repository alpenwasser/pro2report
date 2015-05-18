function [t_nk, t_vk, k_rk] = p2_phasengang(n, t_s, k_s, reglertyp, ueberschwingung, bode)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


% regelertyp: 0=P-Regler; 1=i-Regler; 2=PI-Regler; 3=PID-Regler
% �berschwingung: 0=0%; 1=4.6%;  2=16.3%;  3=23.3%;

%Diese Funktion wurde im Rahmen einer Projektarbeit an der FHNW
%Brugg-Windisch erstellt. Aller Rechte vorbehalten.
%
%Erstellt durch: Benjamin M�ller
%Datum: 4.3.2015
%
%Gepr�ft durch:
%Datum:

%Mit der Variable Test = 1 werden einige Werte zur �berwachung ausgegeben
%mit Test = 2 zus�tzlich noch die Plots
test=2;

if (test==2)
    bode=1;
end;


% Unteres limit der vertikalen Markierungen fuer Omega im Phasengang
VERT_LOWER_LIMIT_PHASE=-8;
VERT_UPPER_LIMIT_PHASE=2;
VERT_LOWER_LIMIT_ABS=1e-10;
VERT_UPPER_LIMIT_ABS=1e10;


%Berechnung von Amplituden und Phasengang der Strecke
syms omega

A_s=k_s;
for k=1:n 
    A_s=A_s*(1/sqrt(1+omega^2*t_s(k)^2));
end;
phi_s=0;
for k=1:n 
    phi_s=phi_s-atan(omega*t_s(k));
end;

%Bodediagramm Ploten
if (bode ==1)
    
    omega_num=logspace(-5, 2, 1e3);
    
    %Amplitudengang
    subplot(2,1,1);
    loglog(omega_num,subs(A_s,omega,omega_num));
    title('Frequenzgang');
    legend('Strecke');
    xlabel('Kreisfrequenz \omega [rad/s]');
    ylabel('Betrag [normiert]');
    hold on; grid on;
    
    %Phasengang
    subplot(2,1,2);
    semilogx(omega_num,subs(phi_s,omega,omega_num));
    legend('Strecke');
    xlabel('Kreisfrequenz \omega [rad/s]');
    ylabel('Phase [rad]');
    hold on, grid on;
end;



%�berschwingungsdefinition
if (ueberschwingung == 0) % 0%
    phi_u=-1.8099064; %-103.7/180*pi
elseif (ueberschwingung ==1)% 4.6%
    phi_u=-2.0001473; %-114.6/180*pi
elseif (ueberschwingung ==2)% 16.3%    
    phi_u=-2.2427481; %-128.5/180*pi
else % 23.3%
    phi_u=-2.3561945; %-135/180*pi
end;



%alpha bestimmen f�r die einzelnen Regler
if (reglertyp == 1) %I-Regler
     error('!!!! Nicht implementiert zum jetzigen Zeitpunkt !!!!');
     %alpha= -45/180*pi;
end;
if (reglertyp == 2) %PI-Regler
    alpha=-1.5707963; %-90/180*pi
end;
if (reglertyp == 3) %PID-Regler
    alpha=-2.3561802; %-135/180*pi; 
end;



%Bestimmung der Frequenz im Punkt Phasengang = alpha mithilfe einer N�herung
xx=1;
k=0;
xx_u=0.001;
while (k<1)
    yy=subs(phi_s,omega,xx);
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
    yy=subs(phi_s,omega,xx);
    if (yy > alpha)
        xx_u=xx;
    elseif (yy < alpha)
        xx_o=xx;
    end;
end;
omega_regler=xx;

%Output for control:
omega_regler
clear k xx_u xx_o xx yy ;

%Plot Punkt Omega_regler
if bode==1
    subplot(2,1,2);
    plot([omega_regler,omega_regler],[VERT_LOWER_LIMIT_PHASE,VERT_UPPER_LIMIT_PHASE],'--b'); % Phasengang blau
    if (reglertyp == 2)
        legend('Strecke','\omega_{pi}');
    elseif (reglertyp == 3)
        legend('Strecke','\omega_{pid}');
    end;
            
    subplot(2,1,1);
    plot([omega_regler,omega_regler],[VERT_LOWER_LIMIT_ABS,VERT_UPPER_LIMIT_ABS],'--b'); % Betragsplot blau
    if (reglertyp == 2)
        legend('Strecke','\omega_{pi}');
    elseif (reglertyp == 3)
        legend('Strecke','\omega_{pid}');
    end;
end;
    

%Ausgabe berechneter Werte zur Kontrolle
if (test > 0)
    disp('Vergleich von der angen�herten Frequenz eingesetzt in den Phasengang zu alpha')
    vpa(subs(phi_s,omega,omega_regler),8)
    alpha
end;
    


%Reglerspezifische Berechnungen f�r t_nk t_vk bzw. t_p
if (reglertyp == 2) %PI-Regler
    
    %Berechnung T_n
    t_nk=1/omega_regler;
    t_vk=0;
    t_p=0;

    %Berechnung Phasengang Regler und Summe Strecke + Regler
    phi_r=atan(omega*t_nk)-pi/2;
    phi_o=phi_s+phi_r;
    
    %Berechnung Amplitudengang Regler mit Kr=1
    A_r=1*sqrt(1+1/(omega^2*t_nk^2));
    A_o=A_r*A_s;
    
    % Control
    t_nk
end;

% return

if (reglertyp == 3) %PID-Regler
    
    %Steigung anpassen auf 1/2 mit t_nk und t_vk
    
    beta_u=1e-12;
    beta_o=1;
    
    %Ableitung Strecke
    dphi_s=subs(diff(phi_s,omega),omega,omega_regler);
    dphi_s

    for m=0:20
        beta=(beta_o-beta_u)/2+beta_u;
        t_vk=1/(omega_regler/beta);
        t_nk=1/(beta*omega_regler);
        t_p=0;
        phi_r=atan(omega*t_nk)+atan(omega*t_vk)-pi/2;
        
        %Ableitung Regler
        dphi_r=subs(diff(phi_r,omega),omega,omega_regler);
        %vpa(dphi_r,6)
        
        %Berechnung Steigung Summe Phasengang Regler + Strecke
        dphi_o=dphi_r+dphi_s;
        %vpa(dphi_o,6)
        
        %Multiplikation mit omega_regler f�r Steigungsbestimmung
        wdphi_o=dphi_o*omega_regler;
        %vpa(wdphi_o,6)
        
        if wdphi_o < -0.5
            beta_u=beta;
        elseif wdphi_o > -0.5
            beta_o=beta;
        end;
    end;
    t_vk=1/(omega_regler/beta);
    t_nk=1/(beta*omega_regler);
    clear beta_u beta_o k_rk beta
    
    
    %Ausgabe berechneter Werte zur Kontrolle
    if (test > 0)
        disp('Vergleich von der angen�herten Werte f�r T_nk und T_vk eingesetzt in die Steigung')
        %dphi_o_num=;
        wdphi_o_num=subs((diff(atan(omega*t_nk)+atan(omega*t_vk)-pi/2,omega)+dphi_s)*omega_regler,omega,omega_regler);
        vpa(wdphi_o_num,6)
        -0.5
        clear wdphi_o_num
    end;
    
    %Berechnung Phasengang Regler und Summe Strecke + Regler
    phi_r=atan(omega*t_nk)+atan(omega*t_vk)-pi/2;
    phi_o=phi_s+phi_r;
    
    %Berechnung Amplitudengang Regler mit Krk=1
    A_r=1*abs(((1+j*omega*t_vk)*(1+j*omega*t_nk))/(j*omega*t_nk));
    A_o=A_r*A_s;
    
    %Plot Punkt t_nk und t_vk
    if bode==1
        subplot(2,1,1);
        plot([1/t_nk,1/t_nk],[VERT_LOWER_LIMIT_ABS,VERT_UPPER_LIMIT_ABS],'--g');
        plot([1/t_vk,1/t_vk],[VERT_LOWER_LIMIT_ABS,VERT_UPPER_LIMIT_ABS],'--g');
        if (reglertyp == 2)
            legend('Strecke','\omega_{pi}');
        elseif (reglertyp == 3)
            legend('Strecke','\omega_{pid}');
        end;
    end;
end;
   
%Plot zur Kontrolle
if (bode==1)
    subplot(2,1,2);
    plot(omega_num,subs(phi_r,omega,omega_num),'g');
    plot(omega_num,subs(phi_o,omega,omega_num),'r');
    if (reglertyp == 2)
        legend('Strecke','\omega_{pi}','Regler','Offener Regelkreis');
    elseif (reglertyp == 3)
        legend('Strecke','\omega_{pid}','Regler','Offener Regelkreis');
    end;
    subplot(2,1,1);
    plot(omega_num,subs(A_r,omega,omega_num),'g');
    plot(omega_num,subs(A_o,omega,omega_num),'r');
    if (reglertyp == 2)
        legend('Strecke','\omega_{pi}','Regler','Offener Regelkreis');
    elseif (reglertyp == 3)
        legend('Strecke','\omega_{pid}','Regler','Offener Regelkreis');
    end;
end;



%Bestimmung der Frequenz omega_durchtritt anhand der
%�berschwingungsdefinition
if (phi_u==-2.3561945)
    %omega_durchtritt = omega_regler bei 23.3% �berschwingung
    omega_durchtritt=omega_regler;
else
    %Bestimmung der Frequenz omega_durchtritt f�r den Punkt phi_o = phi_u
    %(�berschwingung) mithilfe einer N�herung
    xx=1;
    k=0;
    xx_u=0.001;
    while (k<1)
        yy=subs(phi_o,omega,xx);
        if (yy > phi_u)
            xx_u=xx;
            xx=xx*2;
            k=0;
        elseif (yy < phi_u)
            k=2;
            xx_o=xx;
        end;
    end;
    for k=0:20
        xx=(xx_o-xx_u)/2+xx_u;
        yy=subs(phi_o,omega,xx);
        if (yy > phi_u)
            xx_u=xx;
        elseif (yy < phi_u)
            xx_o=xx;
        end;
    end;
    omega_durchtritt=xx;
    clear k xx_u xx_o xx yy ;
end;
% Control
omega_durchtritt


    
%Plot Punkt Omega_durchtritt
if bode==1
    subplot(2,1,2);
    plot([omega_durchtritt,omega_durchtritt],[VERT_LOWER_LIMIT_PHASE,0],'--r');
   if (reglertyp == 2)
        legend('Strecke','\omega_{pi}','Regler','Offener Regelkreis','\omega_{d}');
    elseif (reglertyp == 3)
        legend('Strecke','\omega_{pid}','Regler','Offener Regelkreis','\omega_{d}');
    end;
    subplot(2,1,1);
    plot([omega_durchtritt,omega_durchtritt],[VERT_LOWER_LIMIT_ABS,VERT_UPPER_LIMIT_ABS],'--r');
   if (reglertyp == 2)
        legend('Strecke','\omega_{pi}','Regler','Offener Regelkreis','\omega_{d}');
    elseif (reglertyp == 3)
        legend('Strecke','\omega_{pid}','Regler','Offener Regelkreis','\omega_{d}');
    end;
end;

%Ausgabe berechneter Werte zur Kontrolle
if (ueberschwingung == 2 && test>0)
    disp('Vergleich von omega_regler zu omega_durchtritt sollte gleich sein, da 23.3% Ueberschw.')
    omega_regler
    omega_durchtritt
end;
if (test > 0)
    disp('Vergleich von der angen�herten Frequenz eingesetzt in den Phasengang zu phi_s')
    vpa(subs(phi_o,omega,omega_durchtritt),8)
    phi_u
end;


%Berechnung von K_rk
A_o_durchtritt=subs(A_r*A_s,omega,omega_durchtritt);
k_rk=1/A_o_durchtritt;
vpa(k_rk,6)
% disp('K_rk')
% double(k_rk)


%Ausgabe berechneter Werte zur Kontrolle
%{
Irgendwie mit Fehler
if (test > 0)
    disp('dieser Wert entspricht omega_durchtritt in A_o eingesetzt und sollte 1 sein')
    subs(A_s,omega,omega_durchtritt)*subs(A_r,omega,omega_durchtritt)*k_rk
    vpa(ans,6)
    k_s
end;
%}


%Umwandlung in Reglerkonforme Darstellung
%[t_n,t_v,k_r]=p2_reglerkonf(t_nk,t_vk,t_p,k_rk,reglertyp)
end
