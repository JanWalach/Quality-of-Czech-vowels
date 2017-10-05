function argout = elipsy_vzdalenosti(argin1,argin2,argin3)

%po��t� vzd�lenosti k elips�m

%vstupn� struktura:
%argin1....data z�skan� pomoc� analyza_hlasky.m
%argin2....data o elips�ch z�skan�ch z elipsy.m
%argin3....zda chci d�lat elipsy pro formanty metodou ko�en� nebo peak�

%vystupni struktura:
% vzx.....vzd�lenost k elips�m

%metodou ko�en� nebo peak�
if  strcmp(argin3, 'koreny')  == 1
 load elipsy_koreny
 f1=argin1.koreny;
 f=f1(1)+f1(2)*1i;
elseif  strcmp(argin3, 'peaks')  == 1
 load elipsy_peaks_bez   
 f1=argin1(1).peaks;
 f=f1(1)+f1(2)*1i;
end
   
%na�ten� charakteristik 
 mx = argin2.mean1;
 mxx = argin2.mean2;
 vx = argin2.var1;
 vxx = argin2.var2;
 ex = argin2.elipsa;
 
%pokud jsou v elipse vzd�lenost je 0
if (real(f)-mx)^2/vx^2+(imag(f)-mxx)^2/vxx^2<=1
    vzx=0;
else vzx=abs(min(ex-f));
end
   
argout=vzx;
