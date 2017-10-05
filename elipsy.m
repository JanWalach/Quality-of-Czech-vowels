function argout = elipsy(argin1,argin2)

%zjisti data k elipsa a elipsa, poøeba mít otevøenou all
%vstupní struktura:
%argin1....formanty (data získaná pomocí analyza_databaze.m)
%argin2....zda chci dìlat elipsy pro formanty metodou koøenù nebo peakù

%vystupni struktura:
% vystup.mean1 .....prùmìr prvních formantù
% vystup.mean2 .....prùmìr druhých formantù
% vystup.var1.......smìrodatní odchylka prvních formantù
% vystup.var2 ......smìrodatní odchylka druhých formantù
% vystup.elipsa.....body elipsy
% vystup.formanty...formanty

%alokace
vystup = struct('mean1', {},'mean2', {},'var1', {},'var2', {}, 'elipsa', {},'formanty',{});
load all

X=argin1; 

%chci dìlat elipsy pro formanty metodou koøenù nebo peakù
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

%pouze první a druhé formanty
kX=kX(:,1:2);
%poèet bodù elipsy
t=0:0.01:2*pi;

%èíselné charakteristiky
mx=mean(kX(:,1));
mxx=mean(kX(:,2));
vx=sqrt(var(kX(:,1)));
vxx=sqrt(var(kX(:,2)));
ex=mx+vx*sin(t)+i*(mxx+vxx*cos(t));

%výstup
vystup(1).mean1 = mx;
vystup(1).mean2 = mxx;
vystup(1).var1 = vx;
vystup(1).var2 = vxx;
vystup(1).elipsa = ex;
vystup(1).formanty = kX(:,1:2);

argout=vystup;