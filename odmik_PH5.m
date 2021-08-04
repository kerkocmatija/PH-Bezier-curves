function [kontrolne_O, tocke_odmika] = odmik_PH5(u0,u1,u2,v0,v1,v2,p0,p1,t,d)
% Opis:
%   funkcija odmik_PH5 izračuna vrednosti odmika Bezierjeve krivulje 
%   s pitagorejskim hodografom na razdalji d, v parametrih t, 
%   kjer je krivulja definirana z 
%   u(t) = u0 B_0^2 (t) + u1 B_1^2 (t) + u2 B_2^2 (t) in 
%   v(t) = v0 B_0^2 (t) + v1 B_1^2 (t) + v2 B_2^2 (t)
%   in prvo točko [p0, p1]. Funkcija krivuljo tudi nariše. 
%
% Definicija:
%  [kontrolne_O, tocke_odmika] = PH5(u0,u1,u2,v0,v1,v2,p0,p1,t)
%
% Vhodni podatki:
%  u0,u1,u2    kontrolne točke krivulje u(t) 
%  v0,v1,v2    kontrolne točke krivulje v(t) 
%  p0,p1       prva kontrolna točka PH krivulje
%  t           seznam Kx1 parametrov t, pri katerih računamo vrednosti krivulj
%  d           razdalja na kateri računamo vrednosti odmika
%
% Izhodni podatki:
%  kontrolne_O     matrika velikosti 10 x 2, ki predstavlja kontrolne točke
%                  krivulje odmika
%  tocke_odmika    matrika velikosti K x 2 točk na krivulji odmika, 
%                  ki pripadajo parametrom t.

[B, tocke] = PH5(u0,u1,u2,v0,v1,v2,p0,p1,t);

P0 = [1 B(1,1) B(1,2)];
P1 = [1 B(2,1) B(2,2)]; 
P2 = [1 B(3,1) B(3,2)];
P3 = [1 B(4,1) B(4,2)];
P4 = [1 B(5,1) B(5,2)];
P5 = [1 B(6,1) B(6,2)];

P = [P0; P1; P2; P3; P4; P5];

sig0 = u0^2 + v0^2;
sig1 = u0*u1 + v0*v1;
sig2 = (2/3)*(u1^2 + v1^2) + (1/3)*(u0*u2 + v0*v2);
sig3 = u1*u2 + v1*v2;
sig4 = u2^2 + v2^2;

% definiramo diference
difP = zeros(5, 3);
for k = 1:5
    difP(k,:) = P(k+1,:) - P(k,:);
end

% in še "pravokotne diference"
difPperp = zeros(5, 3);
for k = 1:5
    vec = difP(k,:);
    difPperp(k,:) = [0, vec(3), -vec(2)];
end

% definiramo kontrolne točke za krivuljo odmika
O0 = sig0*P0 + 5*d*difPperp(1,:);
O1 = (1/9)*(4*sig1*P0 + 5*sig0*P1 + 5*d*(5*difPperp(1,:) + 4*difPperp(2,:)));

O2 = (1/18)*(3*sig2*P0 + 10*sig1*P1 + 5*sig0*P2 + ...
    5*d*(5*difPperp(1,:) + 10*difPperp(2,:) + 3*difPperp(3,:)));
O3 = (1/42)*(2*sig3*P0 + 15*sig2*P1 + 20*sig1*P2 + 5*sig0*P3 + ...
    5*d*(5*difPperp(1,:) + 20*difPperp(2,:) + 15*difPperp(3,:) + 2*difPperp(4,:)));

O4 = (1/126)*(sig4*P0 + 20*sig3*P1 + 60*sig2*P2 + 40*sig1*P3 + 5*sig0*P4 + ...
    5*d*(5*difPperp(1,:) + 40*difPperp(2,:) + 60*difPperp(3,:) + ...
    20*difPperp(4,:) + difPperp(5,:)));
O5 = (1/126)*(5*sig4*P1 + 40*sig3*P2 + 60*sig2*P3 + 20*sig1*P4 + sig0*P5 + ...
    5*d*(difPperp(1,:) + 20*difPperp(2,:) + 60*difPperp(3,:) + ...
    40*difPperp(4,:) + 5*difPperp(5,:)));

O6 = (1/42)*(5*sig4*P2 + 20*sig3*P3 + 15*sig2*P4 + 2*sig1*P5 + ...
    5*d*(2*difPperp(2,:) + 15*difPperp(3,:) + 20*difPperp(4,:) + 5*difPperp(5,:)));
O7 = (1/18)*(5*sig4*P3 + 10*sig3*P4 + 3*sig2*P5 + ...
    5*d*(3*difPperp(3,:) + 10*difPperp(4,:) + 5*difPperp(5,:)));

O8 = (1/9)*(5*sig4*P4 + 4*sig3*P5 + 5*d*(4*difPperp(4,:) + 5*difPperp(5,:)));
O9 = sig4*P5 + 5*d*difPperp(5,:);

O = [O0; O1; O2; O3; O4; O5; O6; O7; O8; O9];

kontrolne_O = zeros(10,2);
for k = 1:10
    Wk = O(k,1);
    kontrolne_O(k,1) = O(k,2)/Wk;
    kontrolne_O(k,2) = O(k,3)/Wk;
end

% Sedaj pokličemo funkcijo rbezier, ki smo jo spisali pri RPGO
w = O(:,1);
tocke_odmika = rbezier(kontrolne_O,w,t);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Sedaj še narišemo krivuljo pri danih parametrih:
% % narisemo osnovno krivuljo:
plot(tocke(:,1), tocke(:,2),'b','LineWidth',1.5)
hold on
p = plot(B(:,1),B(:,2),'r');
p.Marker = 'o';

% narisemo krivuljo odmika
plot(tocke_odmika(:,1), tocke_odmika(:,2),'k','LineWidth',1.2)
hold on
r = plot(kontrolne_O(:,1),kontrolne_O(:,2),'r');
r.Marker = 'o';
axis equal

end





 