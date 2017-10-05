function argout1 = analyza_hlasky(argin)

% argin je filename (nap�. 'hlaska.wav')
% je to identicke k analyza_databaze


% vystupni struktura je 'vystup'
% vystup.jmeno ......jmeno souboru
% vystup.frek .......frekvencni osa (pro vsechny stejna)
% vystup.response....je pr�m�rn� LPC logaritnick� spektrum na tomto souboru
% vystup.peaks ......formanty jako lok�ln� maxima
% vystup.koreny......formanty pomoc� metody ko�en�


samo = argin; % soubor k analzye
vystup = struct('jmeno', {}, 'frek', {},'response', {}, 'peaks',{},'koreny',{});

%% zadavani parametru


okno = 30; % [ms] d�lka okna v ms
prekryv = 5; % [ms] p�ekryv sousednich oken
p=12; %po�et predik�n�ch koeficient�
bodu = 2^12; % z kolika bodu kreslit spektrum
fs=10000; % p�evzorkov�n� na [Hz]  

%hammingovsk� okno
okno1 = round((okno/1000)*fs); % d�lka okna v samplech
prekryv1 = round((prekryv/1000)*fs); % d�lka p�ekryvu v samplech
wind = hamming(okno1); %  hammingovsk� okno v [ms]

samohlaska = samo;
[x,fsold] = wavread(samohlaska);
x = resample(x,fs,fsold); %p�evzorkov�n�

%preemf�ze
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
    a(1:p+1,i) = lpc(y(:,i),p); 
    [spec frek] = freqz(1,a(1:p+1,i),bodu,fs);  %LPC spektrum toho kusu
    h(:,i) = spec; 
end

%logaritmick� LPC spektrum 
H=10*log10(abs(h)); 
H_mean = mean(H,2);

%formanty - peaky
[~, loc] = findpeaks(H_mean);
peaks=frek(loc(1:2));

%formanty - ko�eny
kk=1;
    for w=1:size(a,2)   
        r=roots(a(:,w));   
        r=r(imag(r)>0);
        F(kk,1:size(angle(r)))=fs/(2*pi)*angle(r);
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
 
  
  
FF(1,:)=mean(Sort');
FF=FF(1,1:2);

%v�stup    
    vystup(1).jmeno = char(samo(1)); 
    vystup(1).frek = frek; 
    vystup(1).response = H_mean;
    vystup(1).peaks = peaks;
    vystup(1).koreny =FF;
    
argout1 = vystup;




