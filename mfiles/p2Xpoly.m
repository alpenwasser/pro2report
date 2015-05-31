function [C] = p2_xpoly(A)
%p2_xpolymulti multipliziert ein Polynom der Form (1 + A(1)*x)*(1 + A(2)*x)*...
%und gibt ein Array der Form C(1)*x^n+C(2)+x^n-1+...
%BSP:
%A=[1 2 3 4]
%ergibt:
%B=[24 50 35 10 1]


%Diese Funktion wurde im Rahmen einer Projektarbeit an der FHNW
%Brugg-Windisch erstellt. Aller Rechte vorbehalten.
%
%Erstellt durch: Benjamin Müller
%Datum: 21.4.2015
%
%Geprüft durch:
%Datum

C=zeros(size(A,2));
C=[A(1) 1];
for k=2:size(A,2)
    C=p2_xdiskConv([A(k) 1],C);
end;
end