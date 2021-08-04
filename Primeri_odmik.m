%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% BEZIERJEVE KRIVULJE S PITAGOREJSKIM HODOGRAFOM %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SKRIPTA ZA RISANJE KRIVULJ ODMIKA
% 
% Opis: skripta nariše slike 3(a), 3(b), 4 in 5 v seminarju. Vsak izmed
% delov skripte je napisan neodvisno in ga lahko kličemo samostojno. 


%% KRIVULJA ODMIKA ZA PH3
% Drugi primer - risanje in računanje točk na PH krivulji stopnje 3
t = linspace(0,1,101);

u0 = 2;
u1 = 3;
v0 = 2;
v1 = -1;
p0 = 0;
p1 = 0;

% ker imamo že vse sprogramirano v funkciji, tukaj lahko samo kličemo
odmik_PH3(u0,u1,v0,v1,p0,p1,t,-2);


%% KRIVULJA ODMIKA ZA PH5
% Drugi primer - risanje in računanje točk na PH krivulji stopnje 5
t = linspace(0,1,101);

u0 = 2;
u1 = 3;
u2 = 4;
v0 = 2;
v1 = -1;
v2 = -2;
p0 = 0;
p1 = 0;

% Tukaj ne preverjamo pogojev, saj smo jih že v risanju same PH krivulje
odmik_PH5(u0,u1,u2,v0,v1,v2,p0,p1,t,-2);


%% ODMIKI NA EKVIDISTANČNIH d
% (samo na predstavitvi)
u0 = 1;
u1 = 3;
u2 = 1/3;
v0 = 2;
v1 = -1;
v2 = 2;
p0 = 0;
p1 = 0;

d1 = 0.1;
d2 = 0.2;
d3 = 0.3;
d4 = -0.1;
d5 = -0.2;
d6 = -0.3;

dd = [d1 d2 d3 d4 d5 d6];

% Tukaj ne preverjamo pogojev, saj smo jih že v risanju same PH krivulje
[P, tocke_odmika] = PH5(u0,u1,u2,v0,v1,v2,p0,p1,t);

% narisemo originalno krivuljo
[~, tocke_krivulje] = PH5(u0,u1,u2,v0,v1,v2,p0,p1,t);
plot(tocke_krivulje(:,1), tocke_krivulje(:,2),'b','LineWidth',1.5)
hold on

for d = dd
    [~, tocke_odmika_d] = odmik_PH5_brez(u0,u1,u2,v0,v1,v2,p0,p1,t,d);
    plot(tocke_odmika_d(:,1), tocke_odmika_d(:,2),'k','LineWidth',1.2)
end


%% RISANJE + KONTROLNI POLIGON %%
% definiramo parametre za krivuljo odmika stopnje 5
t = linspace(0,1,101);
u0 = 1;
u1 = 3;
u2 = 1;
v0 = 3/2;
v1 = 1/2;
v2 = -1;
p0 = 0;
p1 = 0;

% izračunamo ter narišemo notranji ter zunanji odmik s pripadajočimi
% kontrolnimi poligoni
odmik_PH5(u0,u1,u2,v0,v1,v2,p0,p1,t,0.8);
odmik_PH5(u0,u1,u2,v0,v1,v2,p0,p1,t,-1);


%% KONTROLNE TOČKE SO NA ISTIH PREMICAH
% definiramo parametre za krivuljo odmika stopnje 5
t = linspace(0,1,101);

u0 = 1;
u1 = 3;
u2 = 1;
v0 = 3/2;
v1 = 1/2;
v2 = -1;
p0 = 0;
p1 = 0;

% narisemo originalno krivuljo
PH5(u0,u1,u2,v0,v1,v2,p0,p1,t);

% narišemo tri odmike
odmik_PH5(u0,u1,u2,v0,v1,v2,p0,p1,t,-1);
odmik_PH5(u0,u1,u2,v0,v1,v2,p0,p1,t,-2);
odmik_PH5(u0,u1,u2,v0,v1,v2,p0,p1,t,-3);

% fantomske točke 
[P4, tocke_odmika4] = odmik_PH5_brez(u0,u1,u2,v0,v1,v2,p0,p1,t,-4);
[P1, tocke_odmika1] = odmik_PH5_brez(u0,u1,u2,v0,v1,v2,p0,p1,t,-1);

for i = 1:10
    plot([P1(i,1) P4(i,1)],[P1(i,2) P4(i,2)], 'k','LineStyle','--')
end

