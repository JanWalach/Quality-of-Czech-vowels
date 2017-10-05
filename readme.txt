ENGLISH:
(Czech version below)

Main file: poznej_hlasku.m

poznej_hlasku.m uses functions:
analyza_hlasky.m
odchylky_der.m
odchylky.m
elipsy_vzdalenosti.m
hodnoceni.m

After running the file will aks you to record a vowel.
You need to have a microfone ready and talk already during pressing the button.
Sound is recorded for 200 ms.



dataset all:

data gained by running m-file analyza_databaze.m

Content:
A
E
I
O
U

Then:

.jmeno......name of file
.frek.......frequencies (same in every file)
.response...LPC logaritmic spectrum
.peaks......formants by peaks method
.koreny.....formants by roots method


dataset elipsy_kořeny:

gained by m-file elipy.m
argin2 = koreny

Content:
elipsa_A
elipsa_E
elipsa_I
elipsa_O
elipsa_U

Then
.mean1 .....average of firsts formants
.mean2 .....average of seconds formants
.var1.......standard deviation of firsts formants
.var2 ......standard deviation of secondsformants
.elipsa.....elipsies
.formanty...formants


dataset elipsy_peaks:

Gained by m-filu elipy-m
argin2 = peaks

obsahuje:
elipsa_A
elipsa_E
elipsa_I
elipsa_O
elipsa_U

dále se dělí na
.mean1 .....average of firsts formants
.mean2 .....average of seconds formants
.var1.......standard deviation of firsts formants
.var2 ......standard deviation of secondsformants
.elipsa.....elipsies
.formanty...formants


dataset elipsy_peaks_bez:
Similar as elipsy_peaks, with the difference that some formants are excluded because of bug distance from other formants


This datasets are used for evaluation of vowels.



CZECH:
Hlavní soubor: poznej_hlasku.m

poznej_hlasku.m používá funkce:
analyza_hlasky.m
odchylky_der.m
odchylky.m
elipsy_vzdalenosti.m
hodnoceni.m

Po spuštění vás soubor vyzve k nahrání hlásky.
Je třeba mít připravený mikrofon a mluvit již při 
stisknutí klávesy. Zvuk je nahráván po dobu 200 ms.





databáze all:

získaná pomocí m-filu analyza_databaze.m

obsahuje:
A
E
I
O
U

dále se dělí na:

.jmeno......jmeno souboru
.frek.......frekvence (všude stejné)
.response...LPC logaritmické spektrum
.peaks......formanty metodou peaků
.koreny.....formanty metodou kořenů


databáze elipsy_kořeny:

získaná pomocí m-filu elipy-m
argin2 = koreny

obsahuje:
elipsa_A
elipsa_E
elipsa_I
elipsa_O
elipsa_U

dále se dělí na
.mean1 .....průměr prvních formantů
.mean2 .....průměr druhých formantů
.var1.......směrodatní odchylka prvních formantů
.var2 ......směrodatní odchylka druhých formantů
.elipsa.....body elipsy
.formanty...formanty


databáze elipsy_peaks:

získaná pomocí m-filu elipy-m
argin2 = peaks

obsahuje:
elipsa_A
elipsa_E
elipsa_I
elipsa_O
elipsa_U

dále se dělí na
.mean1 .....průměr prvních formantů
.mean2 .....průměr druhých formantů
.var1.......směrodatní odchylka prvních formantů
.var2 ......směrodatní odchylka druhých formantů
.elipsa.....body elipsy
.formanty...formanty


databáze elipsy_peaks_bez:
podobné jako elipsy_peaks, s tím, že některé formanty
jsou vynechány kvůli jejich velké vzdálenosti od ostatních
formantů

tato databáze je použita pro hodnocení pomocí peaků

