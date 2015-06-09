function [R, P, K] = residueSimple(B,A)
% function [R, P, K] = residueSimple(B,A)
%
%Bsp.: (unter der Annahme, dass Ordnung von B <= Ordnung von A und keine Mehrfachpole)
%B = [4.0812 1.1400];
%A = [7.4902 33.6613 46.4843 23.2772 7.6612 1.1400];
%[R, P, K] = residueSimple(B,A)
%[R, P, K] = residue(B,A) % zum Vergleich

% Führende Nullen entfernen
B = B(min(find(B~=0)):length(B));
A = A(min(find(A~=0)):length(A));

% Ordnung von Zaehler und Nennerpolynom bestimmen:
N = length(B)-1;
M = length(A)-1;

% Haben Zaehler und Nenner gleich Ordnung? -> K berechnen und ausdividieren:
if N==M
    K = B(1)/A(1);
    B = B - K*A;
else
    K = [];
end;

% Residuen berechnen:
P = roots(A);
R = zeros(M,1);

for m=1:M
    % Nennerpolynom ohne m-te Nullstelle berechnen
    p = P;
    p(m:M-1) = p(m+1:M);   
    p = p(1:M-1);
    a = poly(p);
    % Residuum m berechnen
    R(m) = polyval(B, P(m))/polyval(a, P(m))/A(1);
end;

