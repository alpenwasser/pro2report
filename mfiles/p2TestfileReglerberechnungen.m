%Reglerberechnung

clear all;
clc;

t_u=1;
t_g=3;
k_s=1;
reglertyp=2; %0:P-Regler , 1:I-Regler , 2:PI-Regler , 3:PID-Regler


% [k_p_c1,t_n_c1,t_v_c1]=p2_ffchien(t_u,t_g,k_s,reglertyp,1)
% [k_p_c2,t_n_c2,t_v_c2]=p2_ffchien(t_u,t_g,k_s,reglertyp,1)
% [k_p_o,t_n_o,t_v_o]=p2_ffoppelt(t_u,t_g,k_s,reglertyp)
% [k_p_r,t_n_r,t_v_r]=p2_ffrosenberg(t_u,t_g,k_s,reglertyp)
% [k_p_z,t_n_z,t_v_z]=p2_ffziegler(t_u,t_g,k_s,reglertyp)

%[n,t_s]=p2_simplesani(t_u,t_g);
%p2_phasengang(n,t_s,reglertyp,0,0);