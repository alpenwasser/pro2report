function [k_p, t_n, t_v] = p2_ffoppelt(t_u,t_g,k_s,reglertyp)

if reglertyp <2
     error('!!!! Nicht implementierter Reglertyp !!!!');
elseif reglertyp <= 2 %PI Regler
    k_p=(0.8/k_s)*(t_g/t_u);
    t_n=3*t_u;
    t_v=0;
elseif reglertyp <= 3 %PID Regler
    k_p=(1.2/k_s)*(t_g/t_u);
    t_n=2*t_u;
    t_v=0.42*t_u;
else
    error('!!!! Reglertyp nicht berechenbar !!!!')
end;
