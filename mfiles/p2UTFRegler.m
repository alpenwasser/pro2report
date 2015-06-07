function [ Zah_r, Nen_r ] = p2_UTFController(t_nk, t_vk, t_p, k_rk ,Reglertyp )


if (Reglertyp == 2) % PI Regler
    Zah_r = k_rk*[t_nk 1];
    Nen_r = [t_nk 0];
elseif (Reglertyp == 3) % PID-Regler
    Zah_r = k_rk * p2_xdiskConv([t_vk 1],[t_nk 1]);
    Nen_r = [t_nk 0];
else
     error('!!!! Nicht implementierter Reglertyp !!!!');
end;
