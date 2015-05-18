function [ Zah_r, Nen_r ] = p2_UTFRegler(t_nk, t_vk, t_p, k_rk ,Reglertyp )
%Berechnet Z�hler und Nennerpolynome eines Reglers


% regelertyp: 0=P-Regler; 1=i-Regler; 2=PI-Regler; 3=PID-Regler

%Diese Funktion wurde im Rahmen einer Projektarbeit an der FHNW
%Brugg-Windisch erstellt. Aller Rechte vorbehalten.
%
%Erstellt durch: Benjamin M�ller
%Datum: 22.4.2015
%
%Gepr�ft durch:
%Datum

%F�r PI Regler
if (Reglertyp == 2)
    Zah_r = k_rk*[t_nk 1];
    Nen_r = [t_nk 0];
end;

%F�r PID-Regler
if (Reglertyp == 3)
    Zah_r = k_rk * p2_xdiskConv([t_vk 1],[t_nk 1]);
    Nen_r = [t_nk 0];
end;
end

