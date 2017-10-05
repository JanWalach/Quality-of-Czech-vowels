function argout = odchylky_der(argin1,argin2)

%metoda porovn�v�n� derivac�

%vstupn� struktura:
%argin1....data z�skan� pomoc� analyza_hlasky.m
%argin2....data z analyza_databaze.m

%vystupni struktura:
% argout.....minim�ln� rozd�ly

mat = argin1; 
vzor = argin2;

frek = mat.frek; % frekvence
n = length(vzor); % po�et prvk� v datab�zi t�to samohl�sky
dist = zeros(n,1); 
x = mat.response; 
x1 = diff(x); % derivace
x1 = sign(x1); % znam�nko derivace

vahy = exp(-frek/500);
vahy(end)=[]; % v�hy

for i=1:1:n
    
    y = vzor(i).response;
    y1 = diff(y);
    y1 = sign(y1);
    d = sum((x1~=y1).*vahy); % kolikr�t se nerovnaj� sm�ry k�ivky
    dist(i) = d/length(y1); %vzd�lenost
    
end

argout = dist;