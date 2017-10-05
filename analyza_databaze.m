function argout1 = analyza_databaze(argin)

% argin je samohlaska tytu char (napr 'u')
% argout je matice vystup 

% projde mnoho ruznych nahravek teze samhlasky
% kazdou p�evzorkuje na 10 000 Hz a rozd�l� do p�ek�vaj�c�ch se oken


% vystupni struktura je 'vystup'
% vystup.jmeno ......jmeno souboru
% vystup.frek .......frekvencni osa (pro vsechny stejna)
% vystup.response....je pr�m�rn� LPC logaritnick� spektrum na tomto souboru
% vystup.peaks ......formanty jako lok�ln� maxima
% vystup.koreny......formanty pomoc� metody ko�en�


etalon = argin; % tohle bude hledat v nazvech


%% na��t�n� dat
% pozor COKOLIV obsahuje etalon bude vybrano

S = dir('data\*.wav'); % nacte vsechny wavky ve slozce data
names = {S.name}; % tohle je seznam filenames
kde = false(size(names)); % alokace na identifikator jmena
for i=1:1:length(kde)
    jm = char(names(i));
    jm = jm(1:end-4); % bez koncovky (.wav)
    je = strfind(jm,etalon); % vybere cokoliv obsahuje v nazvu etalon
    kde(i) = numel(je)>0;
end

samo = names(kde); 
vystup = struct('jmeno', {}, 'frek', {},'response', {},'peaks',{},'koreny',{});

%% zadavani parametru

okno = 30; % [ms] d�lka okna v ms
prekryv = 5; % [ms] p�ekryv sousednich oken
p=12; %po�et predik�n�ch koeficient�
bodu = 2^12; % z kolika bodu kreslit spektrum
fs=10000; % p�evzorkov�n� na [Hz]  


% hammingovsk� okno
okno1 = round((okno/1000)*fs); % d�lka okna v samplech
prekryv1 = round((prekryv/1000)*fs); % d�lka p�ekryvu v samplech
wind = hamming(okno1); % hammingovsk� okno v [ms]

for j=1:length(samo)
samohlaska = ['data\' char(samo{j})]; % aktualni soubor
[x,fsold] = wavread(samohlaska);

%p�evzorkov�n�
x = resample(x,fs,fsold);
    
%preemfaze
z = [x; x(end)]; z(1)=[];
xx = z - 0.95*x;

pos = 1:prekryv1:(length(xx) - okno1); % zacatky useku
y = zeros(okno1,length(pos)); % alokace na jednotlive useky
    
%rozd�len� na segmenty
sloup = 0;
    for jj = pos
        sloup = sloup+1;
        kus = xx(jj: (jj+okno1-1));
        kus1 = kus.*wind;
        y(:,sloup) = kus1';
    end

h = zeros(bodu,size(y,2)); % alokace na spektra
a = zeros(p+1,size(y,2)); % alokace na koeficienty LPC

%LPC anal�za jednotliv�ch segment�    
for i=1:1:size(y,2)
   a(1:p+1,i) = lpc(y(:,i),p); % spo�te LPC kusu signalu
   [spec frek] = freqz(1,a(1:p+1,i),bodu,fs);  %LPC spektrum toho kusu
   h(:,i) = spec;
end

%logaritmick� LPC spektrum    
H=10*log10(abs(h));
H_mean = mean(H,2);
     
%formanty - peaky
[~, loc] = findpeaks(H_mean);
 
%formanty - koreny    
kk=1;
     for w=1:size(a,2)   
        r=roots(a(:,w));    
        r=r(imag(r)>0);
        F(kk,1:size(angle(r)))=fs/(2*pi)*angle(r); %p�evod na Hz
        kk=kk+1;
     end
     

%se�azen� + odstran�n� nulov�ch frekvnc� (pokud se vyskytuj�)     
Sort= sort(F');

    for qq=1:size(Sort,2)
        if Sort(1,qq)==0
            Sort(1,qq)=Sort(2,qq);
            Sort(2,qq)=Sort(3,qq);
        end
    end
 
 
%v�stup
    vystup(j).jmeno = char(samo(j));
    vystup(j).frek = frek; 
    vystup(j).response = H_mean;
    vystup(j).peaks=frek(loc(1:2));
    vystup(j).koreny = mean(Sort');
end

argout1 = vystup;


