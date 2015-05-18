function [y, t] = p2_xschrittIfft(B,A,fs,N)
% function [y, t] = schritt(B,A,fs,N)
%
%Bsp.:
%fs = 50;
%N = 4*1024;
%B = [4.0812 1.1400];
%A = [7.4902 33.6613 46.4843 23.2772 7.6612 1.1400];
%[y1, t] = schrittIfft(B,A,fs,N);
%[y2, t] = step(tf(B,A),t);
%figure; plot(t, y1, 'g', t, y2, 'b', t, y1-y2, 'r'); grid on; legend('Via ifft()', 'Via step()', 'Abweichung');

T = 1/fs;
w = linspace(0, fs*pi, N/2);
H = freqs(B, A, w); %Erstellt übertragungsfunktion aus Polynomarrays B,A
H = [H(1:N/2) 0 conj(H(N/2:-1:2))];
h = ifft(H);


%Anstelle der Faltung wird hier eine Aufsummierung gemacht (ist schneller)
%y = conv(h, ones(1,N+1));
y(1)=h(1);
for k=2:N
    y(k)=y(k-1)+h(k);
end;


y = y(1:length(y)/2)'; %halbiert die Länge von y
t = linspace(0, (length(y)-1)*T, length(y))'; %Zeitachse generieren
