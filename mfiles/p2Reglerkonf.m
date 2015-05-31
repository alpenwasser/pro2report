function [ t_n, t_v, k_r ] = p2_reglerkonf(t_nk, t_vk, t_p, k_rk ,reglertyp )
%reglerkonf rechnet die Reglerwerte von der Bodekonformen in die
%Reglerkonforme Darstellung um.

% regelertyp: 0=P-Regler; 1=i-Regler; 2=PI-Regler; 3=PID-Regler

%Diese Funktion wurde im Rahmen einer Projektarbeit an der FHNW
%Brugg-Windisch erstellt. Aller Rechte vorbehalten.
%
%Erstellt durch: Benjamin Müller
%Datum: 4.3.2015
%
%Geprüft durch:
%Datum

if (reglertyp = 1) %I-Regler
     error('!!!! Nicht implementiert zum jetzigen Zeitpunkt !!!!');
end;

if (reglertyp = 2) %PI-Regler
    t_n=t_nk;
    k_r=k_rk;
    t_v=0;
end;


if (reglertyp = 3) %PID-Regler
    k_r=k_rk*(1+t_vk/t_nk);
    t_n=t_nk+t_vk-t_p;
    t_v=(t_nk*t_vk)/(t_nk+t_vk-t_p)-t_p;
end;
end

