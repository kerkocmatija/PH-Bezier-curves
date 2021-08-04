function [kontrolne_O, tocke_odmika] = odmik_PH3(u0,u1,v0,v1,p0,p1,t,d)
% Opis:
%   funkcija odmik_PH3 izračuna vrednosti odmika Bezierjeve krivulje 
%   s pitagorejskim hodografom na razdalji d, v parametrih t , 
%   kjer je krivulja definirana z u(t) = u0 B_0^1 (t) + u1 B_1^1 (t) in 
%   v(t) = v0 B_0^1 (t) + v1 B_1^1 (t) in prvo točko [p0, p1]. 
%   Funkcija krivuljo tudi nariše. 
%
% Definicija:
%  [kontrolne_O, tocke_odmika] = PH3(u0,u1,v0,v1,p0,p1,t,d)
%
% Vhodni podatki:
%  u0,u1    kontrolne točke krivulje u(t) 
%  v0,v1    kontrolne točke krivulje v(t) 
%  p0,p1    prva kontrolna točka PH krivulje
%  t        seznam Kx1 parametrov t, pri katerih računamo vrednosti krivulj
%  d        razdalja na kateri računamo vrednosti odmika
%
% Izhodni podatki:
%  kontrolne_O     matrika velikosti 6 x 2, ki predstavlja kontrolne točke
%                  krivulje odmika
%  tocke_odmika    matrika velikosti K x 2 točk na krivulji odmika, 
%                  ki pripadajo parametrom t.

[B, tocke] = PH3(u0,u1,v0,v1,p0,p1,t);

P0 = [1 B(1,1) B(1,2)];
P1 = [1 B(2,1) B(2,2)]; 
P2 = [1 B(3,1) B(3,2)];
P3 = [1 B(4,1) B(4,2)];

P = [P0; P1; P2; P3];

sig0 = u0^2 + v0^2;
sig1 = u0*u1 + v0*v1;
sig2 = u1^2 + v1^2;

% definiramo diference
difP = zeros(3, 3);
for k = 1:3
    difP(k,:) = P(k+1,:) - P(k,:);
end

% in še "pravokotne diference"
difPperp = zeros(3, 3);
for k = 1:3
    vec = difP(k,:);
    difPperp(k,:) = [0, vec(3), -vec(2)];
end

% definiramo kontrolne točke za krivuljo odmika
O0 = sig0*P0 + 3*d*difPperp(1,:);
O1 = (1/5)*(2*sig1*P0 + 3*sig0*P1 + 3*d*(3*difPperp(1,:) + 2*difPperp(2,:)));
O2 = (1/10)*(sig2*P0 + 6*sig1*P1 + 3*sig0*P2 + ...
    3*d*(3*difPperp(1,:) + 6*difPperp(2,:) + difPperp(3,:)));
O3 = (1/10)*(3*sig2*P1 + 6*sig1*P2 + sig0*P3 + ...
    3*d*(difPperp(1,:) + 6*difPperp(2,:) + 3*difPperp(3,:)));
O4 = (1/5)*(3*sig2*P2 + 2*sig1*P3 + 3*d*(2*difPperp(2,:) + 3*difPperp(3,:)));
O5 = sig2*P3 + 3*d*difPperp(3,:);

O = [O0; O1; O2; O3; O4; O5];

kontrolne_O = zeros(6,2);
for k = 1:6
    Wk = O(k,1);
    kontrolne_O(k,1) = O(k,2)/Wk;
    kontrolne_O(k,2) = O(k,3)/Wk;
end

% Sedaj pokličemo funkcijo rbezier, ki smo jo spisali pri RPGO,
% uteži so prva vrstica kontrolnih točk
w = O(:,1);
tocke_odmika = rbezier(kontrolne_O,w,t);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sedaj še narišemo krivuljo pri danih parametrih:
% narisemo osnovno krivuljo:
plot(tocke(:,1), tocke(:,2),'b','LineWidth',1.5)
hold on
p = plot(B(:,1),B(:,2),'r');
p.Marker = 'o';

% narisemo krivuljo odmika
plot(tocke_odmika(:,1), tocke_odmika(:,2),'k','LineWidth',1.2)
hold on
r = plot(kontrolne_O(:,1),kontrolne_O(:,2),'r');
r.Marker = 'o';

end





 