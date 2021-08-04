function [B, tocke] = PH5(u0,u1,u2,v0,v1,v2,p0,p1,t)
% Opis:
%   funkcija PH5 izračuna vrednosti Bezierjeve krivulje s pitagorejskim
%   hodografom v parametrih t, kjer je krivulja definirana z 
%   u(t) = u0 B_0^2 (t) + u1 B_1^2 (t) + u2 B_2^2 (t) in 
%   v(t) = v0 B_0^2 (t) + v1 B_1^2 (t) + v2 B_2^2 (t)
%   in prvo točko [p0, p1]. Funkcija krivuljo tudi nariše. 
%
% Definicija:
%  [B, tocke] = PH5(u0,u1,u2,v0,v1,v2,p0,p1,t)
%
% Vhodni podatki:
%  u0,u1,u2    kontrolne točke krivulje u(t) 
%  v0,v1,v2    kontrolne točke krivulje v(t) 
%  p0,p1       prva kontrolna točka PH krivulje
%  t           seznam Kx1 parametrov t, pri katerih računamo vrednosti krivulj
%
% Izhodni podatki:
%  B        matrika velikosti 6 x 2, ki predstavljajo kontrolne točke
%           krivulje 
%  tocke    matrika velikosti K x 2 točk na krivulji, ki pripadajo
%           parametrom t. 


%Sestavimo matriko kontrolnih točk
B = zeros(6,2);
B(1,:) = [p0,p1];
B(2,:) = B(1,:) + 1/5*[u0^2-v0^2,2*u0*v0];
B(3,:) = B(2,:) + 1/5*[u0*u1-v0*v1,u0*v1+u1*v0];
B(4,:) = B(3,:) + 2/15*[u1^2-v1^2,2*u1*v1] + 1/15*[u0*u2-v0*v2,u0*v2+u2*v0];
B(5,:) = B(4,:) + 1/5*[u1*u2-v1*v2,u1*v2+u2*v1];
B(6,:) = B(5,:) + 1/5*[u2^2-v2^2,2*u2*v2];

%Sedaj pokličemo funkcijo bezier, ki smo jo spisali pri RPGO
tocke = bezier(B,t);

%Sedaj še narišemo krivuljo pri danih parametrih: 
plot(tocke(:,1), tocke(:,2),'b')
hold on
p = plot(B(:,1),B(:,2),'r');
p.Marker = 'o';

end