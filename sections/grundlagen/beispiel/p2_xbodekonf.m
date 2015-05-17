function [ t_nk, t_vk, k_rk ] = p2_xbodekonf(t_n, t_v, t_p, k_r ,reglertyp )
%bodekonf rechnet die Reglerwerte von der Regelkonformen in die
%Bodekonforme Darstellung um.

% regelertyp: 0=P-Regler; 1=i-Regler; 2=PI-Regler; 3=PID-Regler

%Diese Funktion wurde im Rahmen einer Projektarbeit an der FHNW
%Brugg-Windisch erstellt. Aller Rechte vorbehalten.
%
%Erstellt durch: Benjamin Müller
%Datum: 4.3.2015
%
%Geprüft durch:
%Datum


if (reglertyp == 1) %I-Regler
     error('!!!! Nicht implementiert zum jetzigen Zeitpunkt !!!!');
end;

if (reglertyp == 2) %PI-Regler
    t_nk=t_n;
    k_rk=k_r;
    t_vk=0;
end;


if (reglertyp == 3) %PID-Regler
    epsilon=sqrt(1-(4*t_n*(t_v-t_p))/(t_n+t_p)^2);
    t_nk=0.5*(t_n+t_p)*(1+epsilon);
    k_rk=0.5*k_r*(1+t_p/t_nk)*(1+epsilon);
    t_vk=0.5*(t_n+t_p)*(1+epsilon);   
end;
end

