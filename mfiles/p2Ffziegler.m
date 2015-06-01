function [k_p, t_n, t_v] = p2_ffziegler(t_u,t_g,k_s,reglertyp)

if reglertyp <2
     error('!!!! Nicht implementierter Reglertyp !!!!');
elseif reglertyp == 2 %PI Regler
    k_p=(0.9/k_s)*(t_g/t_u);
    t_n=3.33*t_u;
    t_v=0;
elseif reglertyp == 3 %PID Regler
    k_p=(1.2/k_s)*(t_g/t_u);
    t_n=2*t_u;
    t_v=0.5*t_u;
else
    error('!!!! Reglertyp nicht berechenbar !!!!')
end;
