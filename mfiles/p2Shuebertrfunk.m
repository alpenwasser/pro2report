function [] = p2_shuebertrfunk(n,T,k_s )
%Stellt das Polynom zu einem PT1 Glied mit Grad n und den
%Zeitkonstanten T dar.

%Diese Funktion wurde im Rahmen einer Projektarbeit an der FHNW
%Brugg-Windisch erstellt. Aller Rechte vorbehalten.
%
%Erstellt durch: Benjamin Müller
%Datum: 10.3.2015
%
%Geprüft durch:
%Datum:

syms s

F_s=k_s;
for k=1:n
    F_s=F_s*1/(1+s*T(k));
end;
pretty(F_s);
end