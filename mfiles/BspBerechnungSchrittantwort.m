%% Beispiel
clear all; close all; clc;

% Dank an Peter Niklaus für die Werte ...

% Strecke:
% Strecke gegeben mit Schrittantwort. Wird graphisch vermessen: 	Ks=1, Tu=1.71, Tg=7.6
% Identifikation mit Hudzovic/Sani liefert ein Modell der Strecke (PT4):

T1 = 0.41;
T2 = 0.84;
T3 = 1.72;
T4 = 3.532;

% Zaehler- und Nennerpolynom der Strecke
Bs = 1;
As = poly([-1/T1 -1/T2 -1/T3 -1/T4])*(T1*T2*T3*T4);

% Kontrolle:
roots(As)
figure; freqs(Bs,As);

% Regler:
% PI-Regler dimensioniert nach Phasengangmethode mit Vorgabe von 23% Überschwingen
% (Phasenrand von 45°).

Kr = 1.14;
Tn = 3.58;

% Zaehler- und Nennerpolynom des Reglers
Br = Kr*[Tn 1];
Ar = [Tn 0];

roots(Ar)
figure; freqs(Br, Ar);

% Geschlossener Regelkreis
B = conv(Bs, Br);
A = conv(As, Ar);
A(length(A)-length(B)+1:length(A)) = A(length(A)-length(B)+1:length(A)) + B;

% Kontrolle
roots(A)
figure; freqs(B, A);

% Kontrolle für gleich Ordnung von Zaehler und Nenner:
% [B, A] = ellip(4, 3, 40, 1, 's');

% Schrittantwort:
fs = 100;    % Wahl dürfte von fg (Grenzfrequenz) abhängen ...
N = 8*1024; % Wahl dürfte von der Einschwingzeit abhängen ...
[y1, t] = schrittIfft(B,A,fs,N); % Methode via ifft().
[y2, t] = schrittResidue(B,A,fs,N); % Methode via residuen.
[y3, t] = step(tf(B,A),t); % bench mark ...
figure; plot(t, y1, 'g', t, y2, 'b', t, y3, 'r' ); grid on; legend('Via ifft()', 'Via residuen()', 'Via step()');

