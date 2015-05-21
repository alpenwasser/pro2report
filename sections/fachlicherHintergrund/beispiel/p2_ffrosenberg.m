function [k_p, t_n, t_v] = p2_ffrosenberg(t_u,t_g,k_s,reglertyp)

%p2_ffrosenberg gibt die Reglereinstellwerte kp, tn, tv zurück welche gemäss der
%Faustformel von Rosenberg berchnet werden. Dazu dienen als Eingabewerte die
%Schrittantwortkenngrössen tu(Verzugszeit), tg(Anstiegszeit),
%ks(Verstärkung). Zusätzlich wird als letztes der zu berechnende Reglertyp
%angegeben. 0:P-Regler , 1:I-Regler , 2:PI-Regler , 3:PID-Regler


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
    
    k_p=(0.91/k_s)*(t_g/t_u);
    t_n=3.3*t_u;
    t_v=0;

elseif reglertyp == 3 %PID Regler
    
    k_p=(1.2/k_s)*(t_g/t_u);
    t_n=2*t_u;
    t_v=0.45*t_u;
    
else
    error('!!!! Reglertyp nicht berechenbar !!!!')

end;

