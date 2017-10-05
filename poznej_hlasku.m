%HLAVNÍ SOUBOR

%používá metody popsané v práci
%Po spuštìní vás soubor vyzve k nahrání hlásky.
%Je tøeba mít pøipravený mikrofon a mluvit již pøi 
%stisknutí klávesy. Zvuk je nahráván po dobu 200 ms.

close all
clc

fs=44100;
disp('Po stisknuti klavesy zacnete nahravat')
pause

%nahrání vzuku
x = wavrecord(fs/5,fs);
mez = floor(fs/100);

%odstøihnutí zaèátkù, koncù
y = x(mez:end-mez);
wavwrite(y,fs,'hlaska.wav');
disp('Writing "hlaska.wav"')

mat = analyza_hlasky('hlaska.wav'); 

% naète zpracovanou databázi
load all

%% Metoda 6 - Srovnání derivací
%odchylky, diference minimum

odchdA = odchylky_der(mat,A); 
odchdE = odchylky_der(mat,E); 
odchdI = odchylky_der(mat,I); 
odchdO = odchylky_der(mat,O); 
odchdU = odchylky_der(mat,U); 

disp('*********************************************************')
disp('Metoda 6 - Srovnani derivaci: Minimalni vzdalenost od A E I O U je')
disp([min(odchdA) min(odchdE) min(odchdI) min(odchdO) min(odchdU)])
disp('*********************************************************')

 
%% Metoda 4 - Nejbližší shoda se spektrem
%odchylky minima

[odchA odch_cA] = odchylky(mat,A); 
[odchE odch_cE] = odchylky(mat,E); 
[odchI odch_cI] = odchylky(mat,I); 
[odchO odch_cO] = odchylky(mat,O); 
[odchU odch_cU] = odchylky(mat,U); 

disp('Metoda 4 - Nejblizsi shoda se spektrem: Minimalni vzdalenost od A E I O U je')
disp([min(odchA) min(odchE) min(odchI) min(odchO) min(odchU)])
disp('*********************************************************')

%% Metoda 5 - Porovnání se všemi spektry z databáze
%odchylky celkem

disp('Metoda 5 - Porovnáni se vsemi spektry z databáze: Minimalni vzdalenost od A E I O U je')
disp([odch_cA odch_cE odch_cI odch_cO odch_cU])
disp('*********************************************************')

%% Metoda 1 - Formanty pomocí peakù


load elipsy_peaks_bez
vzdalenostiA=elipsy_vzdalenosti(mat,elipsa_A,'peaks');
vzdalenostiE=elipsy_vzdalenosti(mat,elipsa_E,'peaks');
vzdalenostiI=elipsy_vzdalenosti(mat,elipsa_I,'peaks');
vzdalenostiO=elipsy_vzdalenosti(mat,elipsa_O,'peaks');
vzdalenostiU=elipsy_vzdalenosti(mat,elipsa_U,'peaks');

disp('Metoda 1 - Formanty pomocí peakù: Minimalni vzdalenost od A E I O U je')
disp([vzdalenostiA vzdalenostiE vzdalenostiI vzdalenostiO vzdalenostiU])
disp('*********************************************************')

%% Metoda 2 - Formanty pomocí koøenù
%formantové elipsy koøenù

load elipsy_koreny
vzdalenostikA=elipsy_vzdalenosti(mat,elipsa_A,'koreny');
vzdalenostikE=elipsy_vzdalenosti(mat,elipsa_E,'koreny');
vzdalenostikI=elipsy_vzdalenosti(mat,elipsa_I,'koreny');
vzdalenostikO=elipsy_vzdalenosti(mat,elipsa_O,'koreny');
vzdalenostikU=elipsy_vzdalenosti(mat,elipsa_U,'koreny');

disp('Metoda 2 - Formanty pomoci korenu: Minimalni vzdalenost od A E I O U je')
disp([vzdalenostikA vzdalenostikE vzdalenostikI vzdalenostikO vzdalenostikU])
disp('*********************************************************')


%% souèet vzdáleností metody 1, 2
disp('Soucet metody 1, 2: Minimalni vzdalenost od A E I O U je')
disp([vzdalenostikA+vzdalenostiA vzdalenostikE+vzdalenostiE vzdalenostikI+vzdalenostiI vzdalenostikO+vzdalenostiO vzdalenostikU+vzdalenostiU])

plot(mat.frek,mat.response)
disp('*********************************************************')

%% Hodnoceni koøeny
%hodnocení kvality rozšiøováním elips
load elipsy_koreny
hodkA=hodnoceni(mat,elipsa_A,'koreny');
hodkE=hodnoceni(mat,elipsa_E,'koreny');
hodkI=hodnoceni(mat,elipsa_I,'koreny');
hodkO=hodnoceni(mat,elipsa_O,'koreny');
hodkU=hodnoceni(mat,elipsa_U,'koreny');

disp('Hodnocení koreny:')
disp([hodkA hodkE hodkI hodkO hodkU])
disp('*********************************************************')

%% Hodnoceni peaky
%hodnocení kvality rozšiøováním elips
load elipsy_peaks_bez
hodA=hodnoceni(mat,elipsa_A,'peaks');
hodE=hodnoceni(mat,elipsa_E,'peaks');
hodI=hodnoceni(mat,elipsa_I,'peaks');
hodO=hodnoceni(mat,elipsa_O,'peaks');
hodU=hodnoceni(mat,elipsa_U,'peaks');
disp('Hodnocení peaky:')
disp([hodA hodE hodI hodO hodU])

%% Vykreslení

X=[min(odchdA) min(odchdE) min(odchdI) min(odchdO) min(odchdU); min(odchA) min(odchE) min(odchI) min(odchO) min(odchU); 
    vzdalenostiA vzdalenostiE vzdalenostiI vzdalenostiO vzdalenostiU;vzdalenostikA vzdalenostikE vzdalenostikI vzdalenostikO vzdalenostikU];

%pokud je vzdálenost 0 (nejlepší) vzdálenost zvolíme jako 0.5
for k=1:size(X,1)
    for l=1:size(X,2)
        if X(k,l)==0
            X(k,l)=0.5;
        end
    end
end

%normování
X=1./X;
XX=zeros(k,l);
for k=1:size(X,1)
    for l=1:size(X,2)
    s=sum(X(k,:));
    XX(k,l)=X(k,l)/s;
    end
end 



%vykreslení
subplot(2,2,1);
bar(XX(1,:))
title('Odchylky derivace')
set(gca,'XTickLabel',{'A','E','I','O','U'})
subplot(2,2,2);
bar(XX(2,:))
title('Odchylky')
set(gca,'XTickLabel',{'A','E','I','O','U'})
subplot(2,2,3);
bar(XX(3,:))
title('Elipsy peaky')
set(gca,'XTickLabel',{'A','E','I','O','U'})
subplot(2,2,4);
bar(XX(4,:))
title('Elipsy koreny')
set(gca,'XTickLabel',{'A','E','I','O','U'})



% %vykreslení hlásky v èasové oblasti + spektrum
% t=mez/fs:1/fs:(fs/5-mez)/fs;
% 
% figure;
% subplot(2,1,1);
% plot(t,y)
% title('Nahrávka: prùbìh tlaku vzduchu')
% xlabel('èas [s]')
% ylabel('Relativní tlak vzduchu')
% subplot(2,1,2);
% plot(mat.frek,mat.response) 
% title('Spektrum nahrané hlásky')
% xlabel('Frekvence [Hz]')
% ylabel('elergie [dB]')
