function [argout1 argout2] = odchylky(argin1,argin2)

%metoda porovn�n� spekter

%vstupn� struktura:
%argin1....data z�skan� pomoc� analyza_hlasky.m
%argin2....data z analyza_databaze.m

%vystupni struktura:
% argout1.....minimum odchylky
% argout2.....suma odchylky

mat = argin1; 
vzor = argin2;

n = length(vzor); % po�et prvk� v datab�zi t�to samohl�sky
dist = zeros(n,1); % alokace na vzd�lenosti
x = mat.response; % resp hlasky
frek = mat.frek;
vahy = exp(-frek/500); % v�hy


for i=1:1:n  
    y = vzor(i).response;
    d = sum(((x-y).^2).*vahy);
    dist(i) = sqrt(d); % vazena L^2 norma
dist_c = sum(dist);   %rozdil od vsech
    
end

argout1 = dist;
argout2 = dist_c;