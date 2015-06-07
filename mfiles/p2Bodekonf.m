function [ t_nk, t_vk, k_rk ] = p2_bodekonf(t_n, t_v, t_p, k_r ,reglertyp )

if (reglertyp = 2) %PI-Regler
    t_nk=t_n;
    k_rk=k_r;
    t_vk=0;
elseif (reglertyp = 3) %PID-Regler
    epsilon=sqrt(1-(4*t_n*(t_v-t_p))/(t_n+t_p)^2;
    t_nk=0.5*(t_n+t_p)*(1+epsilon);
    k_rk=0.5*k_r(1+t_p/t_nk)*(1+epsilon);
    t_vk=0.5*(t_n+t_p)*(1+epsilon);   
else 
     error('!!!! Nicht implementierter Reglertyp !!!!');
end;
