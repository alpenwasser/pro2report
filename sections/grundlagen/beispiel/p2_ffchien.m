function [k_p, t_n, t_v] = p2_ffchien(t_u,t_g,k_s,reglertyp,ueberschwingung)

%p2_ffchien gibt die Reglereinstellwerte kp, tn, tv zurück welche gemäss der
%Faustformel von Chien/Hrones/Reswick berchnet werden. Dazu dienen als Eingabewerte die
%Schrittantwortkenngrössen tu(Verzugszeit), tg(Anstiegszeit),
%ks(Verstärkung). Zusätzlich wird der zu berechnende Reglertyp
%angegeben. 0:P-Regler , 1:I-Regler , 2:PI-Regler , 3:PID-Regler
%Desweiteren wird mit ueberschwingung zwischen 0:0% und
%1:20% Ueberschwingung gewählt.


%Diese Funktion wurde im Rahmen einer Projektarbeit an der FHNW
%Brugg-Windisch erstellt. Aller Rechte vorbehalten.
%
%Erstellt durch: Benjamin Müller
%Datum: 4.3.2015
%
%Geprüft durch:
%Datum

if reglertyp <2
    error('!!!! Nicht implementiert zum jetzigen Zeitpunkt !!!!');


elseif reglertyp == 2 %PI Regler
    if ueberschwingung == 0 %0%Überschwingen
            k_p=0.35*t_g/(k_s*t_u);
            t_n=1.2*t_u;
            t_v=0;
    else %20%Überschwingen
            k_p=0.7*t_g/(k_s*t_u);
            t_n=2.3*t_u;
            t_v=0;
    end;


elseif reglertyp == 3 %PID Regler
    if ueberschwingung == 0 %0%Überschwingen
            k_p=0.95*t_g/(k_s*t_u);
            t_n=2.4*t_u;
            t_v=0.42*t_u;
    else %20%Überschwingen
            k_p=1.2*t_g/(k_s*t_u);
            t_n=2*t_u;
            t_v=0.42*t_u;
    end;
    
else
    error('!!!! Reglertyp nicht berechenbar !!!!')

end;


