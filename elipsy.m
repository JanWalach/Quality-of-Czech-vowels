function argout = elipsy(argin1,argin2)

%zjisti data k elipsa a elipsa, po�eba m�t otev�enou all
%vstupn� struktura:
%argin1....formanty (data z�skan� pomoc� analyza_databaze.m)
%argin2....zda chci d�lat elipsy pro formanty metodou ko�en� nebo peak�

%vystupni struktura:
% vystup.mean1 .....pr�m�r prvn�ch formant�
% vystup.mean2 .....pr�m�r druh�ch formant�
% vystup.var1.......sm�rodatn� odchylka prvn�ch formant�
% vystup.var2 ......sm�rodatn� odchylka druh�ch formant�
% vystup.elipsa.....body elipsy
% vystup.formanty...formanty

%alokace
vystup = struct('mean1', {},'mean2', {},'var1', {},'var2', {}, 'elipsa', {},'formanty',{});
load all

X=argin1; 

%chci d�lat elipsy pro formanty metodou ko�en� nebo peak�
if  strcmp(argin2, 'koreny')  == 1
    for j=1:length(X)
x = X(j).koreny;
kX(j,:)=x;
    end
elseif strcmp(argin2, 'peaks')  == 1
    for j=1:length(X)
x = X(j).peaks;
kX(j,:)=x;
    end
end

%pouze prvn� a druh� formanty
kX=kX(:,1:2);
%po�et bod� elipsy
t=0:0.01:2*pi;

%��seln� charakteristiky
mx=mean(kX(:,1));
mxx=mean(kX(:,2));
vx=sqrt(var(kX(:,1)));
vxx=sqrt(var(kX(:,2)));
ex=mx+vx*sin(t)+i*(mxx+vxx*cos(t));

%v�stup
vystup(1).mean1 = mx;
vystup(1).mean2 = mxx;
vystup(1).var1 = vx;
vystup(1).var2 = vxx;
vystup(1).elipsa = ex;
vystup(1).formanty = kX(:,1:2);

argout=vystup;