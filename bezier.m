function b = bezier(B,t)
% Opis:
%  bezier vrne tocke na Bezierjevi krivulji pri danih
%  parametrih
%
% Definicija:
%  b = bezier(B,t)
%
% Vhodna podatka:
%  B    matrika velikosti n+1 x d, ki predstavlja kontrolne
%       tocke Bezierjeve krivulje stopnje n v
%       d-dimenzionalnem prostoru,
%  t    seznam parametrov dolzine k, pri katerih racunamo
%       vrednost Bezierjeve krivulje
%
% Izhodni podatek:
%  b    matrika velikosti k x d, kjer i-ta vrstica
%       predstavlja tocko na Bezierjevi krivulji pri
%       parametru iz t na i-tem mestu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funkcija je sprogramirana v splošnem, tako da lahko za argument B podamo
% matriko dimenzij n+1 x d (torej točke v d-dimenzionalnem prostoru).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[n, d] = size(B);
n = n-1;  % n spravimo na realno velikost
k = length(t);

% konstruiramo izhodno matriko b
b = zeros(k, d);

for j = 1:k
    % konstruitamo shemo pri parametru v seznamu t na j-tem mestu
    D = decasteljau(B, t(j));
    b(j, :) = D(1, n+1, :);
end

end