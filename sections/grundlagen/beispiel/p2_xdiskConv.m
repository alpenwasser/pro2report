function [C] = p2_xdiskConv(A,B)
%p2_polyconv Faltet zwei Matrizen/Arrays und gibt das Resultat als neuen
%Array zurück
%BSP:
%A=[1 2 3 4] * B=[7 6 5] = C=[7 20 38 56 39 20]


%Diese Funktion wurde im Rahmen einer Projektarbeit an der FHNW
%Brugg-Windisch erstellt. Aller Rechte vorbehalten.
%
%Erstellt durch: Benjamin Müller
%Datum: 21.4.2015
%
%Geprüft durch:
%Datum

a=size(A,2);
b=size(B,2);
C=zeros(1,a+b-1);

for k=0:(b-1)
    for m=1:a
        C(k+m)=C(k+m)+A(m)*B(k+1);
    end;
end;
end