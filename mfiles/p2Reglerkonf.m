function [ t_n, t_v, k_r ] = p2_reglerkonf(t_nk, t_vk, t_p, k_rk ,reglertyp )
if (reglertyp = 1) %I-Regler
     error('!!!! Nicht implementierter Reglertyp !!!!');
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
