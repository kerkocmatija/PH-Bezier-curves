function [B, tocke] = PH3(u0,u1,v0,v1,p0,p1,t)
% Opis:
%   funkcija PH3 izračuna vrednosti Bezierjeve krivulje s pitagorejskim
%   hodografom v parametrih t, kjer je krivulja definirana z 
%   u(t) = u0 B_0^1 (t) + u1 B_1^1 (t) in v(t) = v0 B_0^1 (t) + v1 B_1^1 (t)
%   in prvo točko [p0, p1]. Funkcija krivuljo tudi nariše. 
%
% Definicija:
%  [B, tocke] = PH3(u0,u1,v0,v1,p0,p1,t)
%
% Vhodni podatki:
%  u0,u1    kontrolne točke krivulje u(t) 
%  v0,v1    kontrolne točke krivulje v(t) 
%  p0,p1    prva kontrolna točka PH krivulje
%  t        seznam Kx1 parametrov t, pri katerih računamo vrednosti krivulj
%
% Izhodni podatek:
%  B        matrika velikosti 4 x 2, ki predstavlja kontrolne točke
%           krivulje
%  tocke    matrika velikosti K x 2 točk na krivulji, ki pripadajo
%           parametrom t. 


%definirajmo kontrolne točke: 
B = zeros(4,2);
B(1,:) = [p0,p1];
B(2,:) = B(1,:) + 1/3*[u0^2-v0^2,2*u0*v0];
B(3,:) = B(2,:) + 1/3*[u0*u1-v0*v1,u0*v1+u1*v0];
B(4,:) = B(3,:) + 1/3*[u1^2-v1^2,2*u1*v1];

%Sedaj pokličemo funkcijo bezier, ki smo jo spisali pri RPGO
tocke = bezier(B,t);

%Sedaj še narišemo krivuljo pri danih parametrih: 
plot(tocke(:,1), tocke(:,2),'b')
hold on
p = plot(B(:,1),B(:,2),'r');
p.Marker = 'o';
hold off
title('PH krivulja stopnje 3')
end