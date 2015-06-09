function [y, t] = schrittResidue(B,A,fs,N)
% function [y, t] = schrittResidue(B,A,fs,N)
%
%Bsp.: (unter der Annahme, dass Ordnung von B <= Ordnung von A und keine Mehrfachpole)
% fs = 50;
% N = 4*1024;
% B = [4.0812 1.1400];
% A = [7.4902 33.6613 46.4843 23.2772 7.6612 1.1400];
%[y1, t] = schrittResidue(B,A,fs,N);
%[y2, t] = step(tf(B,A),t);
%figure; plot(t, y1, 'g', t, y2, 'b', t, y1-y2, 'r'); grid on; legend('Via Residuen', 'Via step()', 'Abweichung');

T = 1/fs;

[R, P, K] = residueSimple(B, A);

h = zeros(N,1);
if (~isempty(K))
    h(1) = K;
end;

t = linspace(0, (N-1)*T, N)';
for k=1:length(R)
    h = h + real(R(k)*exp(P(k).*t)/fs);
end;

y = conv(h, ones(1,N+1));
y = y(1:length(y)/2)';
