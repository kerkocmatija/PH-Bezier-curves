function D = decasteljau(b,t)
% Opis:
%  decasteljau vrne shemo de Casteljaujevega postopka za dan
%  seznam koordinat b pri danem parametru t
%
% Definicija:
%  D = decasteljau(b,t)
%
% Vhodna podatka:
%  b    seznam koordinat kontrolnih tock Bezierjeve krivulje
%       stopnje n,
%  t    parameter, pri katerem racunamo koordinato
%       Bezierjeve krivulje
%
% Izhodni podatek:
%  D    tabela velikosti n+1 x n+1, ki predstavlja de
%       Casteljaujevo shemo za koordinate b pri parametru t
%       (element na mestu (1,n+1) je koordinata Bezierjeve
%       krivulje pri parametru t, elementi na mestih (i,j)
%       za i > n-j+2 so NaN)
%
%  Če kot argument podamo točke dimenzije d, nam bo program tudi vrnil d
%  matrik velikosti n+1 x n+1. ČE pokličemo le na eni dimenziji nam vrne
%  rešitve po tisti dimenziji, ki jo podamo.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% POZOR! Funkcija je sprogramirana v splošnem: kot argument b lahko kar
% podamo kot n+1 x d dimenzionalno matriko. Funkcija bo vrnila matriko
% velikosti n+1 x n+1 x d (torej v d-dimenzionalnem prostoru). Če podamo
% argument b kot retuno (torej 1D) bo funkcija vrnila deCastelajujev
% postopek po tisti dimenziji.
%
% PRIMER: če kličemo funkcijo v 2D lahko kličemo kot: 
%                1) decasteljau(B,t) in dobimo dve rezini,
% ali pokličemo
%                2) decasteljau(B(:,1),t) in decasteljau(B(:,2),t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[n, d] = size(b);
n = n-1;  % sedaj imamo n realne velikosti

% konstruiramo matriko za d dimenzij (če bomo dali kot argument
% točke le po eni dimenziji bo vrnilo po eni dimenziji, sicer po večih)
D = NaN(n+1, n+1, d);

% prvi stolpec sestavljajo kontrolne točke
for i=1:n+1
    D(i, 1, :) = b(i, :);
end

% sedaj izvajamo decasteljauev postopek, tukaj nekoliko drugače, ker delamo
% zgornjetrikotno shemo (namesto spodnjetrikotne kot na predavanjih)
for j = 1:n
    for i = 0:(n-j)
        D(i+1, j+1, :) = (1-t)*D(i+1, j, :) + t*D(i+2, j, :);
    end
end

end