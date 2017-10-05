function argout = hodnoceni(argin1,argin2,argin3)
%hodnot� jak je samohl�ska hezk� pomoc� vzd�lenost�

%vstupn� struktura:
%argin1....data z�skan� pomoc� analyza_hlasky.m
%argin2....data o elips�ch z�skan�ch z elipsy.m
%argin3....zda chci d�lat elipsy pro formanty metodou ko�en� nebo peak�

%vystupni struktura:
% hod.....hodnocen�

%metodou ko�en� nebo peak�
if  strcmp(argin3, 'peaks')  == 1
    load elipsy_peaks_bez
    f1=argin1.peaks;
elseif  strcmp(argin3, 'koreny')  == 1
    load elipsy_koreny
    f1=argin1.koreny;
end

%p�evedn� prvn�ch dvou formant� na imagin�rn� ��slo
f=f1(1)+f1(2)*1i;
X=argin2;

%na�ten� ��seln�ch charakteristik
mx=X.mean1;
mxx=X.mean2;
vx=X.var1;
vxx=X.var2;

% sm�rodatnou odchylky n�sob�m 1.2,1.4,... dokud formanty nejsou v elipse
% jeden p�i�ten� 0.2 -> p�i�tu 0.05 do hodnocen�
k = 1;
hod = 1;
while (real(f)-mx)^2/(k*vx)^2+(imag(f)-mxx)^2/(k*vxx)^2>=1

%ex= mx+k*vx*sin(t)+1i*(mxx+k*vxx*cos(t));
k=k+0.2;
hod  = hod + 0.05;
    
end

argout = hod;

