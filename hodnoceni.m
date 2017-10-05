function argout = hodnoceni(argin1,argin2,argin3)
%hodnotí jak je samohláska hezká pomocí vzdáleností

%vstupní struktura:
%argin1....data získaná pomocí analyza_hlasky.m
%argin2....data o elipsách získaných z elipsy.m
%argin3....zda chci dìlat elipsy pro formanty metodou koøenù nebo peakù

%vystupni struktura:
% hod.....hodnocení

%metodou koøenù nebo peakù
if  strcmp(argin3, 'peaks')  == 1
    load elipsy_peaks_bez
    f1=argin1.peaks;
elseif  strcmp(argin3, 'koreny')  == 1
    load elipsy_koreny
    f1=argin1.koreny;
end

%pøevední prvních dvou formantù na imaginární èíslo
f=f1(1)+f1(2)*1i;
X=argin2;

%naètení èíselných charakteristik
mx=X.mean1;
mxx=X.mean2;
vx=X.var1;
vxx=X.var2;

% smìrodatnou odchylky násobím 1.2,1.4,... dokud formanty nejsou v elipse
% jeden pøiètení 0.2 -> pøiètu 0.05 do hodnocení
k = 1;
hod = 1;
while (real(f)-mx)^2/(k*vx)^2+(imag(f)-mxx)^2/(k*vxx)^2>=1

%ex= mx+k*vx*sin(t)+1i*(mxx+k*vxx*cos(t));
k=k+0.2;
hod  = hod + 0.05;
    
end

argout = hod;

