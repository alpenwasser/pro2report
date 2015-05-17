function [] = p2_simGeschRegelkreis( Zah_s, Nen_s, Zah_r, Nen_r, t_g )
%Simuliert den geschlossenen Regelkreis, gegeben durch Zähler und
%Nennerpolynome der Strecke und des Reglers.


%Diese Funktion wurde im Rahmen einer Projektarbeit an der FHNW
%Brugg-Windisch erstellt. Aller Rechte vorbehalten.
%
%Erstellt durch: Benjamin Müller
%Datum: 22.4.2015
%
%Geprüft durch:
%Datum

Zah=p2_xdiskConv(Zah_s,Zah_r);
Nen=p2_xdiskConv(Nen_s,Nen_r);
Nen(length(Nen)-length(Zah)+1:length(Nen)) = Nen(length(Nen)-length(Zah)+1:length(Nen)) + Zah;


%Ist noch zu optimieren!!! gibt bereich an welcher berechnet wird
if (nargin > 4)          
    fs=1/t_g*500;
else
    fs = 100;    % Wahl dürfte von fg (Grenzfrequenz) abhängen ...
end;


%fs = 100;    % Wahl dürfte von fg (Grenzfrequenz) abhängen ...
N = 8*1024;
[y, t] = p2_xschrittIfft(Zah,Nen,fs,N);
figure;
plot(t,y);

end

