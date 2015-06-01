function [] = p2_shschrittantwort(n,T,k_s)
%Plotet die Schrittantwort zu einem PT1 Glied mit Grad n und den
%Zeitkonstanten T

%Diese Funktion wurde im Rahmen einer Projektarbeit an der FHNW
%Brugg-Windisch erstellt. Aller Rechte vorbehalten.
%
%Erstellt durch: Benjamin Müller
%Datum: 10.3.2015
%
%Geprüft durch:
%Datum:

figure(3);
syms s;
s=tf('s');
F_s=k_s;
for k=1:n
    F_s=F_s*1/(1+s*T(k));
end;
step(F_s);
grid on;
end