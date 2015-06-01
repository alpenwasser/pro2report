function [ Zah_r, Nen_r ] = p2_UTFRegler(t_nk, t_vk, t_p, k_rk ,Reglertyp )

% PI Regler
if (Reglertyp == 2)
    Zah_r = k_rk*[t_nk 1];
    Nen_r = [t_nk 0];
end;

%ID-Regler
if (Reglertyp == 3)
    Zah_r = k_rk * p2_xdiskConv([t_vk 1],[t_nk 1]);
    Nen_r = [t_nk 0];
end;
