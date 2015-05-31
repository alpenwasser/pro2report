function [k_p, t_n, t_v] = p2_ffchien(t_u,t_g,k_s,reglertyp,ueberschwingen)

if reglertyp <2
    error('!!!! Nicht implementierter Reglertyp !!!!');
elseif reglertyp == 2 %PI Regler
    if ueberschwingung == 0 % 0% Ueberschwingen
            k_p=0.35*t_g/(k_s*t_u);
            t_n=1.2*t_u;
            t_v=0;
    else % 20% Ueberschwingen
            k_p=0.7*t_g/(k_s*t_u);
            t_n=2.3*t_u;
            t_v=0;
    end;
elseif reglertyp == 3 %PID Regler
    if ueberschwingung == 0 % 0% Ueberschwingen
            k_p=0.95*t_g/(k_s*t_u);
            t_n=2.4*t_u;
            t_v=0.42*t_u;
    else % 20% Ueberschwingen
            k_p=1.2*t_g/(k_s*t_u);
            t_n=2*t_u;
            t_v=0.42*t_u;
    end;
else
    error('!!!! Reglertyp nicht berechenbar !!!!')
end;
