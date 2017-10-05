function argout = odchylky_der(argin1,argin2)

%metoda porovnívání derivací

%vstupní struktura:
%argin1....data získaná pomocí analyza_hlasky.m
%argin2....data z analyza_databaze.m

%vystupni struktura:
% argout.....minimální rozdíly

mat = argin1; 
vzor = argin2;

frek = mat.frek; % frekvence
n = length(vzor); % poèet prvkù v databázi této samohlásky
dist = zeros(n,1); 
x = mat.response; 
x1 = diff(x); % derivace
x1 = sign(x1); % znaménko derivace

vahy = exp(-frek/500);
vahy(end)=[]; % váhy

for i=1:1:n
    
    y = vzor(i).response;
    y1 = diff(y);
    y1 = sign(y1);
    d = sum((x1~=y1).*vahy); % kolikrát se nerovnají smìry køivky
    dist(i) = d/length(y1); %vzdálenost
    
end

argout = dist;