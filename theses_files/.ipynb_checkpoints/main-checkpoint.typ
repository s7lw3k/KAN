// UWAGI O SPOSOBIE PISANIA PRACY DYPLOMOWEJ   
//  Kierunek Informatyka 

// Praca może być napisana pod edytorem MS WORD.

// 1.	Całość pracy pisana czcionką Times New Roman.
// 2.	Strona tytułowa napisana jak we wzorze podanym na stronie wydziału.
// 3.	Nazwy rozdziałów pisane czcionką o rozmiarze 14 i pogrubione.
// 4.	Tekst właściwy pisany czcionką o rozmiarze 12. Wcięcia w akapicie 1,25 cm.
// 5.	Odstępy między wierszami (interlinia) 1,5 wiersza.
// 6.	Po każdym rozdziale odstępy - co najmniej 1 pusta linia. (default)
// 7.	Po tytule rozdziału bez odstępu - bez pustej linii. (default)
// 8.	W stopce na środku umieszczony numer strony.
// 9.	Konieczność umieszczenia Spisu treści na początku pracy zaraz po stronie tytułowej                 i Bibliografii na końcu pracy. 
// 10.	Odwołanie do pozycji Bibliografii (literatury) należy umieszczać w linii, której odwołanie dotyczy - w nawiasie kwadratowym numer pozycji Bibliografii. 
// 11.	Tekst należy drukować na pojedynczych stronach. (default)

#import "variables.typ" : *
#import "data.typ" : *

#show link: underline

#show heading.where(level:1): it => {
  counter(figure.where(kind: table)).update(0)
  it
}
#show heading.where(level:1): it => {
  counter(figure.where(kind: image)).update(0)
  it
}

#show heading: it => [ // [3]
  #set text(14pt, weight: "bold")
  #block(it, spacing: leading_size, )
]

#set figure(
  numbering: n => {
    numbering("1.1", counter(heading).get().first(), n)
  },
)

#show figure.caption: c => {text(size: 10pt, style: "italic", c)}

// Table Settings

#show figure.where(
  kind: table
): set figure.caption(position: top)

// Document Settings
#set text(lang: "pl", size: 12pt, font: "Times New Roman") // [1] [4]
#set page(margin: 2.5cm, numbering: none)
#set par(
  justify: true, 
  leading: 0.85em,
  first-line-indent: (amount: 1.25cm, all: true), // [4]
)
#set list(
  spacing: 1.2em,
)
#set heading(numbering: "1.")

#show figure.where(kind: image): set figure(supplement: "Rys.")
// Code
#show raw.where(block: true): set block(
  inset: (x: 4pt, y: 4pt),
  fill: luma(245),
  radius: 4pt,
)

#show raw.where(block: false): it => box(
  inset: (x: 2pt, y: 0pt),
  fill: luma(245),
  radius: 2pt,
)[#it]
// Title Page [2]
#align(center)[
  #grid(
    columns: (auto, 1fr, auto),
    image(pk_logo_path, width: 70pt),
    align(center)[
      #set text(size: 16pt)
      #uni_name
      #v(3pt)
      #faculty
    ],
    image(wit_logo_path, width: 70pt)
  )[
  ]

  #v(1fr)

  #text(size: 14pt, weight: "bold")[#author]
  
  #text(size: 12pt)[Numer albumu: #album]
  #v(24pt)
  #text(size: 18pt, weight: "bold")[#title]
  #v(6pt)
  #text(size: 18pt, weight: "bold")[#title_ang]

  #v(16pt)

  #text(size: 14pt, weight: "bold")[
    Praca #strike[licencjacka/inżynierska]/magisterska \
    na kierunku #field \
    specjalność #specialization
  ]

  #v(24pt) 

  #align(right)[
    Praca wykonana pod kierunkiem: \
    *#promotor* \
    *#opiekun*
  ]

  #v(1fr)

  #text(weight: "bold")[Kraków #year]
]

#pagebreak()
#set page(footer: context [
  #h(1fr)
  #text(size: 10pt)[#counter(page).display("1")]
  #h(1fr)
])// [8]
#set par(
  leading: 1.176em,
)
#outline(depth: 2) // [9] 

#set par(
  leading: leading_size,
)
#pagebreak()

= Zagadnienia kompresji z wykorzystaniem modeli neuronowych

Kompresja obrazów cyfrowych polega na zmianie reprezentacji obrazu do formy zajmującej mniej przestrzeni dyskowej, przy zachowaniu lub możliwie najmniejszej stracie na "jakości". Opracowano wiele algorytmów kompresji wykorzystujących własności statystyczne obrazu - zarówno bezstratnych, zachowujących pełnię informacji, jak i stratnych, które tracą część danych w zamian za wyższy stopień kompresji. W ostatnich latach coraz większą rolę odgrywają modele uczenia maszynowego, w szczególności sieci neuronowe, które potrafią uczyć się skutecznej kompresji danych na podstawie zbiorów treningowych. Autoenkodery (głębokie sieci neuronowe uczące się odwzorowania identycznościowego przez wąskie warstwy ukryte) są stosowane w tematyce kompresji obrazu - sieć uczy się kodować obraz wejściowy do wektora o niższym wymiarze, z którego następnie dekoder odtwarza obraz wyjściowy @AutoencodersInKeras.

Kompresja przy pomocy modeli neuronowych zyskały na popularności, ponieważ w wielu przypadkach zaczęły przewyższać klasyczne metody oparte na algorytmach. Prace naukowe wskazują, że współczesne modele kompresji obrazu oparte na głębokich sieciach (ang. neural image compression, NIC) potrafią uzyskać lepszą efektywność (stosunek jakości do stopnia kompresji) niż klasyczne kodeki takie jak JPEG czy JPEG2000 @NeuralImageCompression @ETEOptimizedImageCompression. Zaprezentowany w 2017 pierwszy autoenkoder kompresujący obrazy end-to-end, który dla niezależnego zestawu testowego uzyskał wyższą jakość od JPEG przy porównywalnym rozmiarze pliku @ETEOptimizedImageCompression. Od tamtej pory rozwinięto wiele usprawnień m.in. wariacyjne autoenkodery, sieci uwzględniające modelowanie entropii czy transformery - dzięki czemu obecnie sieci neuronowe stanowią obiecującą alternatywę dla tradycyjnych metod w kompresji obrazów @NeuralImageCompression.

Jednym z nowszych podejść w dziedzinie sieci neuronowych są modele typu KAN (ang. Kolmogorov-Arnold Networks), inspirowane twierdzeniem Kołmogorowa-Arnolda o superpozycji funkcji @superKAN. Niniejsza praca skupia się na zbadaniu, na ile modele KAN mogą zostać wykorzystane do efektywnej kompresji obrazów. W dalszych częściach przedstawione zostaną zarówno teoretyczne podstawy kompresji i modeli KAN, jak i wyniki eksperymentów porównujących autoenkodery oparte na KAN z klasycznym autoenkoderem konwolucyjnym (CNN).

== Wykorzystanie modelu KAN w praktyce

Model KAN jest zupełnie nowym podejściem, zaproponowanym w literaturze dopiero w 2024 roku @liu2024kan. Został zainspirowany twierdzeniem Kołmogorowa o reprezentacji każdej funkcji wielowymiarowej za pomocą funkcji jednowymiarowych (szczegóły w rozdziale 3). W modelu KAN zamiast standardowych wag neuronowych funkcje kształtu (ang. activation functions) zmienia się w czasie trwania treningu i to one odpowiadają za "ewolucje" modelu. W praktyce funkcje te są parametryzowane np. za pomocą splinów (funkcji sklejanych) o pewnym stopniu. Dzięki temu KAN może aproksymować złożone nieliniowe zależności z użyciem mniejszej liczby neuronów niż tradycyjna sieć wielowarstwowa MLP (ang. Multilayer Perceptron), w której nieliniowość jest narzucona z góry (np. funkcją simgoid, ReLU) i identyczna dla wszystkich neuronów. Stosunkowo niewielkie sieci KAN mogą osiągać dokładność porównywalną lub lepszą od znacznie większych klasycznych MLP. KAN swoje zastosowanie może znaleść również m.in. w zagadnieniach aproksymacji funkcji matematycznych i rozwiązywania równań różniczkowych np. jako narzędzie do odkrywania praw fizycznych na podstawie danych eksperymentalnych @liu2024kan.

Pomimo, że KAN jest architekturą stosunkowo nową, szybko zwrócono na nią uwagę. Opublikowano otwartoźródłową (ang. OpenSource) implementację o nazwie pyKAN, która w krótkim czasie zyskała dużą popularność @pykan (popularność oceniam na podstawie liczby gwiazdek na oficjalnej implementacji zamieszczonej na GitHub). Dostępność kodu ułatwia eksperymentowanie z KAN w różnych zadaniach. W praktyce KAN był już testowany m.in. w modelowaniu szeregów czasowych (powstały czasowe odmiany T-KAN @tkan), w sieciach grafowych (Graph KAN @gkan). Wszystko to wskazuje, że KAN ma potencjał do szerokiego wykorzystania. Niniejsza praca stanowi jedno z pierwszych badań użycia KAN do kompresji obrazów, dziedziny, w której dotąd dominowały klasyczne sieci konwolucyjne oraz transformatory.

#pagebreak()
== Cel i zakres pracy

Celem pracy jest zaprojektowanie, implementacja oraz ocena działania autoenkodera kompresującego obrazy z wykorzystaniem architektury KAN w tym:
#enum(numbering: "a)", spacing: 12pt, 
  "Napisanie własnej implementacji modelu KAN pozwalającą na zmianę rodzajów splinów.",

  "Opracowanie autoenkoder opartego o warstwy KAN zdolnego do kompresji obrazów.",

  "Przystosowanie autoenkoder dla implementacji FastKAN.",

  "Opracowanie autoenkodera opartego o CNN który zachowa identyczny stopień kompresji.",
  
  "Porównanie jego skuteczność z autoenkoderem konwolucyjnym (CNN) pod względem stopnia kompresji oraz jakości odtworzenia obrazów.",
)

Zakres pracy obejmuje przegląd literatury i podstaw teoretycznych związanych z kompresją obrazów i modelami KAN (rozdziały 2-3), opis zaproponowanych modeli autoenkoderów opartych na KAN (rozdział 4), szczegółowe omówienie środowiska implementacji i metodologii eksperymentów (rozdział 5) oraz prezentację wyników eksperymentalnych - porównanie KAN vs CNN w kompresji obrazów (rozdziały 6-7). Całość kończy podsumowanie uzyskanych wyników wraz z wnioskami praktycznymi i propozycjami dalszych kierunków badań (rozdział 8).

W eksperymentach wykorzystano zarówno autorską implementację pozwalającą na zmianę rodzaju funkcji bazowych (spline) na krawędziach modelu KAN, aby ocenić ich wpływ na dokładność i wydajność kompresji oraz implementację FastKAN zaproponowaną przez Ziyao Li, w której zamiast funkcji sklejanych zastosowano radialne funkcje bazowe Gaussa, co pozwala przyspieszyć propagację w przód względem oryginalnego KAN @li2024fastkan.

#pagebreak()

= Podstawy teoretyczne

== Reprezentacja obrazu cyfrowego

Obraz cyfrowy to dwuwymiarowa siatka pikseli którym przypisane są wartości numeryczne reprezentujące jasność (dla obrazów w skali szarości) lub kolor (dla obrazów barwnych). Obrazy barwne zazwyczaj zapisuje się za pomocą trzech składowych kolorów (np. model RGB - czerwony, zielony, niebieski), gdzie każdy piksel jest wektorem tych trzech wartości. Często stosuje się też przestrzenie barw pochodne, np. YCbCr używaną w kompresji JPEG, gdzie separuje się składową luminancji od chrominancji. Fundamentalnymi parametrami obrazu cyfrowego są rozdzielczość (liczba pikseli w poziomie i pionie) oraz głębią koloru określająca, ile bitów przypada na reprezentację jednego piksela. Przykładowo, obraz o rozdzielczości $1920 times 1080$ i 24-bitowej głębi koloru (po 8 bitów na każdą składową RGB) zawiera ponad 2 miliony pikseli, a każdy piksel może przyjmować $2^8=256$ odcieni na kanał (czyli ok. $16,7$ miliona kombinacji kolorów). Na podstawie tych danych można obliczyć, że taki nieskompresowany obraz zajmuje ok. 6,2 miliona bajtów (6 MB).

W praktyce obrazy często przechowuje się w formatach skompresowanych, aby zmniejszyć ich rozmiar. Niekompresowana reprezentacja jest wykorzystywana głównie w określonych zastosowaniach (np. profesjonalna fotogria, obrazy RTG). Najczęściej dokonuje się kompresji wykorzystując fakt, że piksele w obrazie nie są niezależne - występuje znaczna redundancja przestrzenna (sąsiednie piksele są zwykle podobne) oraz ludzki wzrok mniej czuły jest na pewne detale. Kompresja stara się usunąć te redundantne informacje lub przechowywać je w bardziej zwartej formie.

#pagebreak()
== Kompresja obrazu

Kompresja danych polega na zamianie oryginalnego strumienia bitów na inny, krótszy - tak aby wynikowy zbiór danych można było zdekodować do formy zbliżonej lub identycznej z oryginałem. Rozróżniamy dwa główne rodzaje kompresji danych: bezstratną i stratną.

Stopień kompresji określa się zazwyczaj poprzez współczynnik kompresji - stosunek liczby bitów danych oryginalnych do liczby bitów danych skompresowanych. Przykładowo, współczynnik 1:10 oznacza, że obraz po kompresji zajmuje 10 razy mniej miejsca niż przed kompresją. W kompresji bezstratnej współczynnik ten jest ograniczony redundancją danych, natomiast w stratnej można go zwiększać kosztem pogarszania jakości. W praktyce dąży się do znalezienia kompromisu między wysokim stopniem kompresji a akceptowalną jakością wyniku.

=== Kompresja bezstratna

Kompresja bezstratna opiera się na znalezieniu takiej reprezentacji danych, która usuwa nadmiarowość, ale pozwala dokładnie odtworzyć oryginał. Jedną ze znanych technik to kodowanie entropijne. Wykorzystuje fakt, że niektóre wartości pojawiają się częściej niż inne. Przykładem jest kodowanie Huffmana, przypisujące częstym symbolom krótkie kody bitowe, a rzadkim dłuższe. Inna metoda to kodowanie arytmetyczne, które osiąga bliską optymalnej długość kodu dla danego rozkładu symboli. Kodowanie entropijne stanowi często ostatni etap większości algorytmów kompresji (zarówno bezstratnych, jak i stratnych).

Inna forma kompresji bezstratnej to kodowanie słownikowe polega na zastępowaniu powtarzających się sekwencji znaków odniesieniami do ich pierwszego wystąpienia. Algorytmy z rodziny LZ (Lempel-Ziv), takie jak LZ77 i LZ78, tworzą słownik napotkanych ciągów danych i wstawiają odwołania (np. para offset, długość) do wcześniejszego wystąpienia zamiast powtarzać cały ciąg. Format ZIP, a także PNG, używają udoskonalonej odmiany LZ77, łączącej słownik LZ z kodowaniem Huffmana dla optymalizacji bitów @howPngWorks.

#pagebreak()
Przed zastosowaniem kodowania entropijnego można przekształcić dane, by zwiększyć ich „kompresowalność”. Przykładem jest wspomniane filtrowanie w PNG, gdzie każdy piksel zastępuje się różnicą względem pewnej kombinacji sąsiadów (np. różnica w stosunku do piksela z lewej, powyżej, czy średniej z nich). Po takim zabiegu dane zawierają wiele powtarzalnych wzorców (np. ciągi zer po odjęciu tła), które łatwiej zakodować. W obrazach często stosuje się też kodeki bezstratne wykorzystujące transformaty - np. tryb bezstratny JPEG2000 używa całkowitoliczbowej transformaty falkowej, którą można odwrócić bez błędu.

W kontekście obrazów, kompresja bezstratna znajduje zastosowanie tam, gdzie wymagana jest pełna wierność - np. w obrazowaniu medycznym, archiwizacji dzieł sztuki czy w surowych zdjęciach (RAW) wykorzystywanych do dalszej obróbki. Jednak ze względu na ograniczone możliwości zmniejszenia rozmiaru, formaty bezstratne nie sprawdzają się tam, gdzie priorytetem jest maksymalne zmniejszenie rozmiaru pliku (np. w transmisji wideo, stronach internetowych itp.). W takich przypadkach sięga się po kompresję stratną.

=== Kompresja stratna

Kompresja stratna usuwa część informacji oryginalnego sygnału, zazwyczaj tę najmniej zauważalną dla odbiorcy, aby drastycznie zmniejszyć ilość danych. Do popularnych technik należą:

Zamiast bezpośrednio kompresować wartości pikseli, dokonuje się transformacji do innej dziedziny, w której ujawnia się struktura sygnału. Przykładowo, JPEG dzieli obraz na bloki $8 times 8$ pikseli i stosuje dyskretną transformację cosinusową (DCT) na każdym bloku. Powstałe współczynniki DCT reprezentują sygnał w dziedzinie częstotliwości przestrzennych, pierwsze odpowiadają składowym niskoczęstotliwościowym (równe obszary), a kolejne, coraz wyższym częstotliwościom (drobnym szczegółom). Alternatywą jest transformata falkowa (JPEG2000 dzieli obraz na pasma częstotliwości na różnych skalach) lub transformaty Fourierowskie, Principal Component Analysis (PCA) itp.

#pagebreak()
Zaokrąglenie lub wyzerowanie części współczynników transformaty, redukując precyzję informacji  tzw. kwantyzacja. W JPEG stosuje się macierz kwantyzacji $8 times 8$: każdy z 64 współczynników DCT dzieli się przez odpowiadającą mu wartość kwantyzacji i zaokrągla (w praktyce, współczynniki wysokoczęstotliwościowe dzielone są przez większe liczby, przez co wiele z nich staje się zerem). Powoduje to utratę drobnych szczegółów, ale przynosi ogromne korzyści --- długie ciągi zer można potem zakodować bardzo efektywnie. Stopień kwantyzacji kontroluje jakość kompresji - im silniejsza kwantyzacja (większe dzielniki), tym mniejszy plik, ale więcej informacji ginie i obraz jest bardziej zniekształcony.

Na końcu wynik kwantyzacji poddaje się bezstratnemu upakowaniu bitów, tak jak opisano w sekcji 2.2.1. JPEG używa uproszczonego algorytmu Huffmana lub arytmetycznego do zakodowania długości serii zer i wartości niezerowych. Nowsze standardy (HEVC dla obrazów statycznych - H.265/HEIC) mogą wykorzystywać bardziej zaawansowane metody modelowania i kodowania entropijnego kontekstowo zależnego. @wallace1992jpeg

Istotnym elementem kompresji stratnej obrazów jest model barw i subsampling. To jak postrzegamy kolort cechuje wieksza rozdzielczość dla jasności niż dla barwy - dlatego formaty takie jak JPEG najpierw przekształcają RGB na YCbCr (jasność + dwie składowe różnicowe koloru), po czym zapisują sygnały w niższej rozdzielczości (np. $2 times 2$ bloki pikseli dzielą jedną wartość - tzw. subsampling 4:2:0). Na tym kroku tracimy część informacji, niew jest to jednak bardzo rzucające się w oczy, a pozwala zaoszczędzić miejsce na dysku.

Podsumowując, kompresja stratna jest efektywnym sposobem redukcji rozmiaru obrazów, lecz generuje artefakty kompresji, rozmycie detali, utrata ostrości czy pasmowanie jednolitych obszarów.

#pagebreak()
=== Metryki jakości

Ocena jakości skompresowanego obrazu jest istotnym wyzwaniem badawczym, które wymaga wykorzystania odpowiednich mierników do określenia, w jakim stopniu kompresja zmienia obraz w stosunku do oryginału. Stosuje się zarówno metryki obiektywne (matematyczne porównania piksel po pikselu), jak i subiektywne (badania z udziałem obserwatorów lub metryki starające to symulować). W niniejszej pracy do oceny wyników kompresji użyto głównie standardowych metryk pełnoreferencyjnych, porównujących obraz wynikowy z oryginalnym:

*MSE* (Mean Squared Error) - średni błąd kwadratowy. Definiowany jako średnia arytmetyczna kwadratów różnic jasności pikseli oryginalnych $X$ i zdekompresowanych $hat(X)$: 
$ "MSE" = frac(1, "NM") sum_(x=1)^N sum_(y=1)^M [X_(x,y) - hat(X)_(x,y)]^2, $ 
#par(first-line-indent: 0pt)[gdzie obraz ma rozmiar $N times M$. Im mniejsze MSE, tym mniejsza ogólna różnica między obrazami.]

*PSNR* (Peak Signal-to-Noise Ratio) - powszechnie stosowana metryka oparta na MSE, wyrażana w skali logarytmicznej. Definiowana jest jako: 
$ "PSNR" = 10 log_10 frac("MAX"^2, "MSE"), $ 
#par(first-line-indent: 0pt)[gdzie MAX to maksymalna możliwa wartość piksela (np. 255 dla obrazów 8-bitowych). PSNR określa stosunek mocy sygnału (idealnego obrazu) do mocy szumu (błędu). Wyższy PSNR oznacza lepszą jakość --- typowo dla kompresji stratnej obrazów 8-bitowych wartości PSNR mieszczą się w przedziale 30-50 dB (im bardziej skompresowany i zniekształcony obraz, tym niższy PSNR) @qualityInImageCompression. Na przykład akceptowalna jakość dla zdjęć to zwykle powyżej 30 dB, bardzo dobra powyżej 40 dB, jednak zależy to od zawartości obrazu i wrażliwości obserwatora.]

#pagebreak()
*SSIM* (Structural Similarity Index) - bardziej złożona metryka zaproponowana w 2004, która lepiej niż MSE/PSNR odzwierciedla to jak oceniamy jakość kompresji @SIMM. SSIM porównuje lokalne struktury jasności między obrazem oryginalnym a przetworzonym, biorąc pod uwagę także kontrast i luminancje. Wartość SSIM wynosi 1 dla obrazów identycznych i spada, gdy pojawiają się różnice strukturalne. SSIM oblicza się na małych oknach (np. $8 times 8$), porównując średnie, wariancje i kowariancje jasności między obrazami. Jeśli zdekompresowany obraz ma zachowaną strukturę (np. krawędzie, tekstury w tych samych miejscach) nawet przy drobnych różnicach pikseli, SSIM będzie wysoki, podczas gdy MSE/PSNR mogłyby znacząco spaść. Metryka SSIM szczególnie dobrze wychwytuje artefakty i rozmycie.

$
"SSIM"(x,y) = ((2 mu_x mu_y + C_1)x(2 sigma_(x y)+C_2))/((mu_x^2+mu_y^2+C_1)(sigma_x^2+sigma_y^2+C_2))
$
#par(first-line-indent: 0pt)[Gdzie $mu_x,mu_y$ to średnie (jasność) w lokalnym oknie dla obrazów $x$ oraz $y$, $sigma_x^2,sigma_y^2$ to wariancje (kontrast) w tym oknie. $sigma_(x y)$ kowariancja (podobieństwo struktury) między $x "oraz" y$ natomiast $C_1, C_2$ to stałe stabilizujące (zapobiegają dzieleniu przez małe liczby). $C_1=(K_1,L)^2$,$C_2=(K_2,L)^2$ typowo $K_1 = 0.01; K_2 = 0.03$ gdzie L to zakres dynamiki obrazu np. 255 dla obrazów 8 bitowych @qualityUrbaniak.]

== Wykorzystanie sieci neuronowych w kompresji obrazów

Sieci neuronowe od roku 2010 zrewolucjonizowały wiele dziedzin przetwarzania obrazu od klasyfikacji, przez segmentację, po generowanie obrazów. Również w kompresji znalazły swoje zastosowanie. Zasadnicza idea polega na tym, by pozwolić sieci nauczyć się optymalnej reprezentacji danych zamiast polegać wyłącznie na ręcznie zaprojektowanych algorytmach (jak DCT, kodowanie Huffmana).

Pierwsze prace nad uczeniem maszynowym w kompresji obrazów  skupiały się na autoenkoderach - sieci neuronowej z warstwą ukrytą o mniejszym wymiarze niż wejście, trenowanej do rekonstrukcji danych wejściowych na wyjściu. Taka sieć, jeśli uda się ją skutecznie wytrenować, automatycznie wyodrębnia w warstwie ukrytej skompresowaną postać danych (tzw. embedding lub kod). W latach 80. i 90. testowano płytkie autoenkodery liniowe i nieliniowe, jednak dopiero rozwój głębokiego uczenia (deep learning) i wzrost mocy obliczeniowej umożliwiły uzyskanie jakości przewyższającej klasyczne metody.

Współczesne podejścia do kompresji z użyciem sieci wykorzystują zazwyczaj głębokie autoenkodery konwolucyjne. Architektura typowego systemu kompresji opartego na uczeniu głębokim wygląda następująco:

#figure(
  image(width: 250pt,"images/bottleneck.png"),
  caption: [Prosty schemat kompresji obrazu dla autoenkodera (źródło własne).]
)

Obraz najpierw trafia do enkodera, sieć przetwarza obraz i produkuje zbiór kodów latentnych (wąskie gardło, bottleneck) - czyli ciąg liczb o znacznie mniejszym rozmiarze niż oryginalny obraz. Np. dla obrazu $256 times 256$, enkoder może wygenerować 64 mapy cech o rozdzielczości $32 times 32$, to już 4-krotna redukcja wymiarów w każdej osi czyli 16-krotna kompresja liczby pixeli. enkoder uczy się wyodrębniać z obrazu istotne cechy i odwzorowywać je w zagęszczonej formie.

W środku systemu, aby uzyskać rzeczywistą kompresję, ciąg wyjściowy enkodera musi zostać zakodowany jako ciąg bitów. Zwykle stosuje się tu operację kwantyzacji neuronowego kodu do skończonej liczby poziomów (np. zaokrąglenie wartości do ustalonej siatki). Ponieważ kwantyzacja jest niefunkcjonalna (nie ma gradientu), wiele prac stosuje surrogaty - np. dodawanie szumu podczas treningu lub metodę straight-through estimator, by móc trenować sieć w pełnym zakresie mimo obecności kwantyzacji. Po kwantyzacji powstają symbole, które poddaje się kodowaniu entropijnemu (np. metodą arytmetyczną) korzystając z modelu probabilistycznego dla tych symboli. Wytrenowane modele często potrafią lepiej dopasować rozkład prawdopodobieństwa niż klasyczne statyczne modele, co skutkuje mniejszą liczbą bitów. W tej pracy jednak skupiamy się na samych właściwościach autoenkodera - etap binarnego kodowania nie będzie zaimplementowany, a ocena skupi się na jakości rekonstrukcji i rozmiarze wewnętrznej reprezentacji @lossyImageConmpression.

Druga część sieci (dekoder), odwracająca działanie enkodera, ciagu liczb w bottleneck stara się odtworzyć oryginalny obraz. Dekoder zwykle ma strukturę „odwrotną” do enkodera (np. wykorzystuje warstwy transponowanej konwolucji deconv lub upsamplingu). Celem treningu jest minimalizacja różnicy między obrazem wyjściowym a wejściowym według pewnej funkcji kosztu (najczęściej MSE, percepcyjnej lub kombinacji). Po udanym treningu dekoder generuje obraz bardzo zbliżony do oryginalnego, korzystając wyłącznie z informacji zawartej w skompresowanym kodzie.

Trenowanie takiego systemu end-to-end odbywa się zazwyczaj metodą stochastycznego spadku gradientu (SGD) z algorytmami typu optymalizacyjnymi (przykładem takiego algorytmu jest Adam). Wymaga to dużej liczby przykładowych obrazów treningowych. Często korzysta się z publicznych zbiorów: np. Kodak PhotoCD (24 zdjęcia) do testów lub duży zbiór ImageNet do trenowania. Pojawiają się także dedykowane zbiory treningowe do kompresji (np. Workshop CLIC - Challenge on Learned Image Compression - udostępnia zestawy obrazów) @CLIC2020.

Kompresja oparata na sieciach neuronowych ma wiele zalet np. model może dostosować się do statystyk obrazów lepiej niż uniwersalny algorytm - np. może nauczyć się specyficznych wzorców (tekstur, krawędzi) występujących często w obrazach naturalnych. W rezultacie osiąga lepszy stosunek między jakością a rozmiarem niż stałe algorytmy (co potwierdzono m.in. w pracach, gdzie autoenkodery przewyższyły JPEG/JPEG2000 @ETEOptimizedImageCompression). Ponadto sieci mogą optymalizować dowolną wybraną metrykę (np. bezpośrednio maximować MS-SSIM zamiast minimalizować MSE). Inną zaletą jest możliwość uczenia kompresji kontekstowej - np. ważniejsze fragmenty obrazu (twarz, tekst) mogą być zakodowane dokładniej niż tło, jeśli taka zależność wynika z danych i funkcji kosztu.

#pagebreak()
Modele uczenia maszynowego nie zawsze jednak są najlepszy rozwiązaniem, wymagają sporej mocy obliczeniowej (zarówno do trenowania, jak i do enkodowania/dekodowania - co utrudnia ich użycie na urządzeniach mobilnych). Ważna jest generalizacja - model wytrenowany na pewnym zbiorze musi radzić sobie z obrazami spoza niego. Zauważono, że sieci mogą przeuczyć się do statystyk treningowych i tracić efektywność na innych obrazach, stąd pojawiły się badania nad poprawą uogólnienia i odporności na zmiany danych @NeuralImageCompression. Ponadto, w praktycznych zastosowaniach ważna jest kontrola nad stopniem kompresji, klasyczne kodeki pozwalają płynnie regulować jakość/bitrat, dla modeli uczonych jest to zagadnienie bardziej skomplikowane.

Mimo tych wyzwań, kierunek rozwoju jest obiecujący. W roku 2023 po raz pierwszy zaprezentowano prototypowe wdrożenia sieciowego kodeka (np. Google przedstawił algorytm kompresji o nazwie Lyra dla audio i podobne próby trwają dla obrazów).


Podsumowując, sieci neuronowe, a w szczególności autoenkodery, stały się ważną gałęzią badań nad kompresją obrazów. Celem pracy jest sprawdzenie, czy Kolmogorov-Arnold Networks, będące nowatorską architekturą sieci neuronowej, mogą konkurować z klasycznymi autoenkoderami konwolucyjnymi w zadaniu kompresji obrazu. Zanim jednak przejdziemy do samych modeli KAN i eksperymentów, omówimy koncepcję tych sieci oraz ich właściwości w kontekście znanych architektur neuronowych.

#pagebreak()
= Modele typu KAN (Kolmogorov-Arnold Networks)

== Idea modelu KAN

Idea modelu KAN wywodzi się z fundamentalnego rezultatu analizy matematycznej znanego jako twierdzenie Kołmogorowa-Arnolda o superpozycji. Twierdzenie to (udowodnione przez A.N. Kołmogorowa w 1957 r., rozwinięte przez jego ucznia V. Arnol'da) mówi nam, że każdą ciągłą funkcję wielu zmiennych można dokładnie przedstawić jako złożenie funkcji jednowymiarowych. Mówiąc ściślej, dla dowolnej ciągłej funkcji 
$f: [0,1]^n arrow RR,$
 istnieje reprezentacja postaci:
$ f(x_1, ..., x_n) = sum_(q=0)^(2n) Phi_q ( sum_(p=1)^n phi_((q,p))(x_p) ) $

#par(first-line-indent: 0pt)[gdzie $phi_(q,p):[0,1] arrow RR$ oraz $Phi_q:RR arrow RR$ są pewnymi ciągłymi funkcjami jednowymiarowymi. Innymi słowy, funkcję $n$-wymiarową da się złożyć z funkcji zależnych tylko od jednej zmiennej (oraz operacji dodawania tych składowych) @kanDocumentation. Oryginalna konstrukcja KAN nie była praktyczna obliczeniowo. Niemniej zainspirowała późniejsze prace nad sieciami neuronowymi. Można zauważyć, że powyższa formuła przypomina sieć dwuwarstwową: najpierw $n$ zmiennych $x_p$ jest przekształcanych przez funkcje $phi_(q,p)$ (warstwa wejściowa), potem sumowane (sumowanie to operacja na neuronach), a na koniec przekształcone przez funkcje $Phi_q$ otrzymujemy wynik i sumę końcową. Mamy tu ściśle dwie warstwy (ukrytą o rozmiarze $N=2n+1$ i wyjściową, sumującą wyniki). Warto zaznaczyć, że oryginalne twierdzenie wymaga $2n+1$ funkcji zewnętrznych $Phi_q$ - później Lorentz pokazał, że wystarczy nawet jedna funkcja $Phi$ sumująca odpowiednio zagnieżdżone $phi$ (kosztem zwiększenia złożoności wewnętrznej) @ujKAN, ale ogólna idea pozostaje: wielowymiarowość można “schować” poprzez dodawanie jednowymiarowych składowych.]

Model KAN wprowadza ten koncept na grunt sieci neuronowych. Bazuje on na zaobserwowaniu, że standardowa sieć MLP również jest pewną aproksymacją dowolnej funkcji, wg. klasycznego twierdzenia o uniwersalnej aproksymacji, sieć z jedną warstwą ukrytą o dostatecznej liczbie neuronów sigmoidalnych potrafi aproksymować dowolną ciągłą funkcję na kompaktowym zbiorze. Dlaczego więc potrzebujemy KAN? Otóż, choć MLP ma uniwersalną zdolność aproksymacyjną, narzucona architektura (liniowe kombinacje wejść + proste funkcje aktywacji) może wymagać bardzo wielu neuronów, by uzyskać skomplikowaną funkcję.

Model KAN zakłada architekturę, w której każda krawędź w sieci realizuje pewną funkcję jednowymiarową $phi(x)$ z parametrami uczonymi z danych, natomiast każdy neuron sumuje wyniki funkcji ze wszystkich krawędzi wchodzących. Innymi słowy, w KAN to, co w zwykłej sieci jest stałą wagą mnożoną przez wejście, zostaje zastąpione funkcją: zamiast $bold(w dot x)$ mamy $bold(phi(x))$, gdzie kształt funkcji $phi$ jest regulowany za pomocą punktów kontrolnych (parametrów). Zazwyczaj funkcje te na krawędziach są parametryzowane w sposób elastyczny, w oryginalnej pracy zaproponowano wykorzystanie do tego celu B-splinów stopnia 3 (cubic B-spline) @liu2024kan. #box[B-spline] to funkcja składana używana często w interpolacji, jej kształt wyznaczają węzły (punkty kontrolne), a pomiędzy nimi funkcja jest wielomianem określonego stopnia. Wybór B-splinów wynika z ich własności aproksymacyjnych - przez odpowiednie ustawienie węzłów można przybliżyć dowolną funkcję ciągłą z zadaną dokładnością, a jednocześnie mają one lokalny charakter (zmiana parametru wpływa tylko na ograniczony zakres argumentu, co ułatwia trenowanie). W implementacji KAN zakłada się pewną początkową siatkę punktów dla każdej funkcji krawędzi (np. 5 przedziałów równoodległych w zakresie wejściowym, co daje 6 węzłów do optymalizacji przy B-spline stopnia 3). Parametrami zmienijącymi się w trakcie uczenia stają się wartości funkcji w tych węzłach - czyli w praktyce wektor kilkunastu liczb na każdą krawędź zamiast pojedynczej wagi.

Podsumowując, KAN to sieć neuronowa, która uczy się kształtu funkcji aktywacji dla każdej wejściowej zmiennej do neuronu, zamiast uczyć się tylko ich liniowej kombinacji. Jest to istotne odejście od tradycyjnego modelu perceptronu, w którym wagi są liczbowe, a funkcja nieliniowości pozostaje niezmienna (np. ReLU, sigmoida). W KAN nieliniowość jest specyficzna dla każdego wejścia danego neuronu i zmienia się podczas treningu.

== Architektura i właściwości modeli KAN
#figure(
  image(width: 200pt,"images/simple_can.png"),
  caption: [Schemat architektury Kolmogorov-Arnold Network (KAN) na przykładzie prostej sieci (źródło własne).]
)

#box[W modelu KAN każdy neuron sumuje sygnały od wszystkich neuronów z warstwy poprzedniej. Sygnały te nie są mnożone przez stałe wagi, lecz najpierw przechodzą przez funkcje (białe bloki na rysunku) specyficzną dla każdej pary połączenia. Ilustracja pokazuje również warstwę wyjściową, gdzie sumowane są wszystkie sygnały z warstwy ukrytej po przejściu przez kolejne funkcje $Phi$. Formalnie, pojedyncza warstwa KAN przekształcająca wektor wejściowy $bold(x) = [x_1,dots,x_z]$ w wektor wyjściowy $bold(y) = [y_1,dots,y_(z')]$ działa według zależności:]

$ y_i=sum_(j=1)^z phi_(i,j)  (x_j ), "dla " i=1,…,z', $

#par(first-line-indent: 0pt)[gdzie $phi_(i,j)$ jest funkcją przypisaną do krawędzi z $j$-tego wejścia do $i$-tego neuronu wyjściowego. Wszystkie $phi_(i,j)$ są uczone podczas treningu przejmując role wag. Taka warstwa jest odpowiednikiem warstwy w pełni połączonej (dense layer) w klasycznej sieci, z tą różnicą, że w zwykłej warstwie mielibyśmy $y_i = sigma(sum_j w_(i,j) x_j + b_i)$ ze stałą funkcją aktywacji $sigma$ (np. ReLU).]

Architektura wielowarstwowa KAN powstaje poprzez złożenie kolejnych warstw. Uogólnienie pierwotnej konstrukcji na dowolną liczbę i szerokość warstw pozwala zwiększyć ekspresyjność modelu. Działanie sieci o $L$ warstwach można wówczas zapisać rekurencyjnie w następującej postaci:

$ h^(0)=x, $
$ h^((l+1) )=bold(Phi)_l (h^((l) ) ), l=0,1,…,L-1, $
#par(first-line-indent: 0pt)[gdzie $Phi_l$ oznacza przekształcenie przez $l$-tą warstwę KAN według powyższego wzoru ($Phi_l$ jest macierzą funkcji, rozmiaru $d_(l+1)times d_l$ jeśli $d_l$ to liczba wyjść warstwy $l-1$, a $d_(l+1)$ - liczba wyjść warstwy $l$) @kanDocumentation. Składanie takich warstw tworzy sieć głęboką. Dla porównania, standardowa głęboka sieć MLP z nieliniowością $sigma$ między warstwami miałaby:]

$ h^((l+1) )=sigma(W_l times h^((l) )+b_l ), $

#par(first-line-indent: 0pt)[gdzie $W_l$ to macierz wag, a $b_l$ to wektor biasów. W KAN nie ma macierzy wag $W_l$ - jej rolę spełnia „macierz funkcji” $Phi_l$.]

\
Kilka właściwości modelu KAN wynikających z tej architektury:

*Więcej parametrów na połączenie*: Podczas gdy w MLP pojedyncze połączenie #box[neuron-neuron] niesie 1 parametr (wagę), w KAN to połączenie niesie wiele parametrów opisujących funkcję $phi$. Przykładowo, jeśli używamy B-splinów stopnia 3 z $m$ odcinkami, to każda funkcja ma $m+3$ parametrów. Typowe ustawienia mogą mieć np. 5 segmentów, co daje 8 parametrów na krawędź. To oznacza, że sieć KAN może mieć znacznie więcej parametrów niż odpowiednik MLP o tej samej topologii.

*Lepsza ekspresyjność*: Funkcja krawędzi $phi(x)$ może realizować dowolne przekształcenie zmiennej, podczas gdy MLP ma tylko skalowanie $bold(w dot x)$. Na przykładzie: jeśli zależność między $x$ a wyjściem sieci jest silnie nieliniowa i różna w różnych zakresach $x$, to MLP musiałby kombinacją neuronów to uchwycić - KAN może nauczyć jedną krawędź $phi(x)$ tak, że już ta jedna funkcja odwzoruje np. $x$ na $x^3$ dla małych wartości i na $log x$ dla dużych (to oczywiście przykład hipotetyczny). Dzięki temu KAN może potencjalnie potrzebować mniej neuronów warstwy ukrytej do aproksymacji skomplikowanej funkcji. Znacznie mniejsze sieci KAN potrafiły osiągnąć porównywalną lub wyższą dokładność niż dużo większe MLP w zadaniach aproksymacji danych @liu2024kan.

#pagebreak()
*Interpretowalność*: Jednym z mocnych argumentów autorów KAN jest łatwość interpretacji wyuczonego modelu @liu2024kan. Każdą funkcję $phi_(i,j)(x)$ można po treningu wyrysować na wykresie, jest to zależność jednej zmiennej, zrozumiała dla człowieka (np. może okazać się, że funkcja ta przypomina pewną znaną zależność matematyczną). To duża zaleta w porównaniu z konwencjonalnymi sieciami, które działają jak „czarne skrzynki”. W KAN można dosłownie zajrzeć do wnętrza i zobaczyć, jakie transformacje nakładane są na poszczególne wejścia. Przykładowo, w zastosowaniu do odkrywania praw fizycznych KAN był w stanie nauczyć się funkcji krawędzi odpowiadających fundamentalnym zależnościom (jak np. prawo kwadratowe) i poprzez inspekcję tych funkcji można te prawidłowości odczytać @liu2024kan. Również w naszym kontekście kompresji obrazów pewna interpretowalność może się pojawić np. możemy zobaczyć, jak sieć transformuje poziomy jasności czy koloru przed kompresją. Ponadto, istnieją metody przycinania (pruning) dedykowane KAN, gdzie można usunąć krawędzie o znikomej wadze (tj. funkcje bliskie zerowej) aby uszczuplić model bez utraty jakości @kanDocumentation.

*Brak konwolucyjności i lokalności*: Warto zauważyć, że podstawowa architektura KAN jest z natury w pełni połączona i nie posiada mechanizmu splotu ani lokalnych receptorów tak jak CNN. To znaczy, że jeśli stosujemy KAN do obrazu, najprostsze podejście to potraktować cały obraz jako wektor wejściowy i łączyć każdy piksel z każdym neuronem ukrytym. W przypadku obrazów o dużej rozdzielczości byłoby to niewyobrażalnie dużo połączeń i parametrów - np. obraz $32 times 32$ (1024 piksele) i tylko 100 neuronów ukrytych dałby $1024 times 100 = 102400$ funkcji krawędzi do nauczenia (każda z kilkoma parametrami). Można podjąć próbę wprowadzenia lokalności: np. podzielić obraz na mniejsze bloki/patche i dla każdego stosować oddzielną sieć KAN, lub opracować konwolucyjną wersję KAN.

*Złożoność obliczeniowa*: Z punktu widzenia obliczeń, KAN jest bardziej wymagający od MLP. Każde połączenie wymaga obliczenia funkcji nieliniowej zamiast prostego mnożenia. W oryginalnrj pracy wskazano, że na CPU KAN też bywa wolniejszy od MLP przy tej samej liczbie neuronów, choć bywa dokładniejszy @kanEmpiricalStudies. Pojawiają się jednak optymalizacje, np. wspomniany wariant FastKAN zastępuje funkcje sklejane Gaussowskimi funkcjami bazowymi, które mogą być obliczane szybciej @li2024fastkan. Ponadto można zmniejszać liczbę parametrów np. poprzez ograniczenie stopnia spline lub używając aproksymacji ortogonalnych. Reasumując, klasyczne sieci CNN korzystają z gotowych bibliotek tensorycznych które są dobrze zoptymalizowane i przebadane, a sieciach KAN zoptymalizowane implementacje są na etapie eksperymentalnym.

== Porównanie z klasycznymi modelami neuronowymi

Zamiast dokładania warstw czy filtrów można zmienić sposób w jaki modele implementują nieliniowość. Ten rodział ma na celu porównać, jak ta strategia w KAN wypada względem MLP i CNN oraz innych popularnych implementacji MLP.

#set table(
  align: (x, y) => (
    if x == 0 { center }
    else { left }
  ),
)

#figure(
  table(
    columns: 2,
    [KAN a MLP],

    [W klasycznym MLP nieliniowość (np. ReLU) jest stała, a uczone są jedynie wagi liniowe, w KAN uczone są jednowymiarowe funkcje na krawędziach połączeń, które zastępują stałe wagi. KAN osiąga porównywalną dokładność przy mniejszej liczbie neuronów, kosztem większej liczby parametrów na połączenie i większego kosztu obliczeniowego @kanDocumentation @liu2024kan.], 
    [KAN a CNN],
    
    [KAN nie ma wrodzonej lokalności, przez co dla dużych obrazów może być mniej efektywny. Trwają jednak prace nad warstwami konwolucyjnymi z komponentami KAN oraz nad architekturami hybrydowymi (np. U-Net), które potrafią dorównywać lub przewyższać klasyczne CNN przy mniejszej liczbie parametrów. Wyniki empiryczne wskazują, że podejścia te są komplementarne i mogą być łączone @kanEmpiricalStudies.],

    [KAN a inne MLP],
    [KAN wpisuje się w szerszy nurt alternatywnych aktywacji/parametryzacji w MLP (np. SIREN z funkcjami sinusoidalnymi). Jego wyróżnikiem jest między innymi interpretowalność. Wyuczone funkcje $phi_(i,j)$ można analizować i wizualizować. Pojawiły się też warianty przyspieszone, m.in. FastKAN z radialnymi funkcjami bazowymi (RBF), które zachowują wysoką jakość przy znacznie krótszym czasie wnioskowania @liu2024kan  @li2024fastkan.],
  ),
  caption: [Prównanie teoretyczne KAN, MLP, CNN],
)

Podsumowując, KAN to alternatywna architektura sieci neuronowej, która w pewnych zadaniach może osiągać lepsze wyniki niż klasyczny MLP, oraz potencjalnie rywalizować z CNN. Jej moc tkwi w elastyczności funkcji aktywacji, a słabość w złożoności obliczeniowej.

== Zalety i ograniczenia w kontekście kompresji obrazów

W kontekście kompresji obrazów za pomocą autoenkoderów, można wymienić następujące zalety modeli KAN:

*Wysoka zdolność aproksymacyjna na ograniczonej liczbie neuronów*: dzięki uczonym funkcjom na wagach, KAN może potrzebować mniej neuronów warstwy ukrytej, do osiągnięcia wysokiej jakości rekonstrukcji, od autoenkodera MLP. To oznacza potencjalnie bardziej kompaktowy model kompresujący.

*Elastyczność funkcji aktywacji*: w autoenkoderze KAN zarówno enkoder, jak i dekoder mogą uczyć się nietypowych transformacji dostosowanych do danych. Przykładowo, może nauczyć się, że dla pewnego zakresu intensywności pikseli lepiej je skompresować (np. ciemne cienie potraktować nieliniowo inaczej niż jasne obszary). Tradycyjny autoenkoder z ReLU czy tanh nie ma takiej swobody - musiałby poprzez kombinację neuronów przybliżyć podobny efekt.

*Interpretowalność transformacji kompresującej*: W standardowych autoenkoderach trudno zrozumieć, co dokładnie robią kolejne warstwy. W autoenkoderze KAN możemy przeanalizować wyuczone funkcje $phi_(i,j)$. Może to dać pewien wgląd w to, co sieć uznaje za istotne informacje w obrazie, a co pomija. Przykładowo, jeśli któraś funkcja krawędzi jest niemal liniowa, to znaczy że dana cecha jest przetwarzana niemal liniowo. Jeśli inna jest silnie nieliniowa (np. wygasza małe wartości do zera), to może sygnalizować działanie podobne do progowania (thresholding).

#pagebreak()
*Uniezależnienie od konkretnej funkcji aktywacji*: W klasycznych sieciach neuronowych (np. CNN) wybór funkcji aktywacji (ReLU, Leaky ReLU, ELU itp.) istotnie wpływa na przebieg i efektywność uczenia. W modelach KAN ten problem nie występuje, ponieważ kształt funkcji aktywacyjnych dostosowuje się automatycznie w trakcie treningu. Projektant modelu nie musi ręcznie dobierać najlepszej aktywacji. Z drugiej jednak strony, sieć musi samodzielnie „nauczyć się” odpowiednich kształtów od zera, co bywa wyzwaniem przy niewielkiej liczbie danych. Dodatkowo, ponieważ początkowa postać funkcji jest losowa, uzyskiwane wyniki mogą się różnić pomiędzy poszczególnymi próbami uczenia.
\
\

Niemniej, modele KAN mają też istotne ograniczenia i wyzwania w zastosowaniu do kompresji obrazów. 

*Znacząco zwiększa liczba parametrów*: Kan posiada znacząco większą liczbe parametrów na połączenie. W autoenkoderze obrazów, gdzie już i tak liczba wag bywa duża, KAN może być trudny do trenowania. Stwierdzono, że podstawowy KAN ma spory narzut czasowy @kanEmpiricalStudies. FastKAN częściowo to adresuje poprzez użycie szybszych funkcji RBF kosztem minimalnej utraty dokładności.

*Problemy z optymalizacją i zbieżnością*: Większa elastyczność oznacza też większą szanse popadnięcia w minima lokalne czy przeuczenia. Funkcje spline mogą potencjalnie przybrać dziwny kształt, jeśli dane treningowe są niewystarczające, prowadząc do artefaktów w rekonstrukcji.

*Zużycie pamięci*: Więcej parametrów to też większe zapotrzebowanie pamięciowe zarówno do przechowania modelu, jak i w trakcie treningu. W literaturze wspomina się, że podstawowy KAN wymagał dużo pamięci i mocy obliczeniowej, co zainspirowało różne warianty redukujące parametry @lssSkan.

*Brak dotychczasowych zastosowań w kompresji*: To ograniczenie natury praktycznej. KAN jest tak nowym modelem, że nie ma wypracowanych „dobrych praktyk” jak go użyć do autoenkoderów. Dla CNN istnieje baza zastosowań.

Podsumowując, modele KAN oferują nowy stopień swobody w modelowaniu złożonych zależności, co potencjalnie czyni je potężnym narzędziem do uczenia reprezentacji obrazu. KAN może teoretycznie prowadzić do lepiej dopasowanej kompresji kosztem większej złożoności modelu. W następnych rozdziałach zobaczymy, w jakim stopniu te teoretyczne zalety przekładają się na rzeczywiste wyniki w porównaniu z klasyczną siecią konwolucyjną.

#pagebreak()

= Zastosowanie modeli KAN w kompresji obrazu

== Przegląd podejść autoenkoderowych

Kompresja obrazów za pomocą autoenkoderów polega na tym, że sieć neuronowa uczy się odwzorowania $f_theta: X arrow Z$ (enkoder), gdzie $X$ jest przestrzenią obrazów wejściowych, a $Z$ przestrzenią zakodowanych reprezentacji (o niższym wymiarze), oraz odwzorowania #box[$g_theta: Z arrow X$] (dekoder), które rekonstruuje obraz z kodu. Po treningu, obraz $x$ jest kompresowany do #box[$z = f_(theta)(x)$], następnie $z$ jest zapisywane (ew. kwantyzowane i zakodowane bitowo), a do odtworzenia obrazu stosuje się $hat(x) = g_(theta)(z)$.

Klasyczne autoenkodery do kompresji obrazów często wykorzystywały warstwy konwolucyjne ze względu na ich efektywność i zdolność do wykrywania lokalnych wzorców w obrazach. Trening takiego autoenkodera odbywa się poprzez minimalizację błędu rekonstrukcji, najczęściej sumy kwadratów błędów (MSE) między $x$ a $hat(x)=g(f(x))$, gdzie $x$ oznacza obraz oryginalny a $hat(x)$ obraz skompresowany.

Poza autoenkoderami deterministycznymi, we współczesnych podejściach pojawiają się takie modele jak VAE (wariacyjne autoenkodery). Zamiast jednego „sztywnego” kodu, VAE uczy się rozkładu możliwych kodów dla danego obrazu. $q(z|x)$ oznacza jakie kody $z$ dobrze reprezentują obraz $x$. Podczas kompresji losowany jest kod z tego rozkładu (w praktyce enkoder podaje średnią i „rozrzut”, pozostaje dobrać próbkę). Do uczenia dodaje się warunek, aby kody miały uporządkowany kształt. Temu służy prior $p(z)$, czyli reprezentacja kodów jak najbliższa naturalnej, zwykle prosta gaussowska chmura wokół zera @vae. 

Innym wartym wspomnienia podejściem jest kompresja progresywna (RNN). Model (np. LSTM) generuje kolejne porcje bitów, które stopniowo redukują błąd rekonstrukcji. Na początku przesyłany jest krótki kod dający prosty zarys obrazu, każda następna iteracja dosyła poprawki (residua). Dzięki temu można uzyskać zmienny bitrate - wcześniejsze przerwanie sekwencji daje mniejszy strumień i gorszą jakość, dalsze kroki zwiększają liczbę bitów i jakość. Taki mechanizm naturalnie adaptuje się do zawartości: proste obrazy potrzebują mniej kroków, złożone - więcej. Ceną jest złożoność treningu (stabilność uczenia długich sekwencji, akumulacja błędów, większy czas inferencji sekwencyjnej) oraz trudniejsze strojenie kompromisu między szybkością a jakością @rnn.

== Opis autoenkodera opartego na KAN

W ramach pracy zaimplementowano model autoenkodera KAN jako klasyczny schemat enkoder-dekoder. Architektura (rys. 4.1) składa się z: \
*Enkodera KAN*: pojedyncza warstwa KAN, która przekształca spłaszczony obraz $x$ wejściowy (wektor długości $N$) na wektor kodowy $z$ o wymiarze $K$ ($K<=N$).
\
*Dekodera KAN*: pojedyncza warstwa KAN, która mapuje wektor $z$ (bottleneck) na wektor $hat(x)$ o długości $N$. Następnie przekształca na obraz o wymiarach oryginału. Na końcu dekodera stosujemy funkcję sigmoidalną, aby ograniczyć wartości pikseli rekonstruowanego obrazu.
#figure(
  image(width: 250pt,"images/KAN_encoder_diagram.png"),
  caption: [Schemat architektury autoenkodera KAN (źródło własne).]
)

```py
class KANAutoenkoder(nn.Module):
    def __init__(...):
        ...
        self.input_dim = H * W
        self.enc = KANLayer(self.input_dim, latent_dim, num_grid=num_grid, spline_type=spline_type)
        self.dec = nn.Sequential(
            KANLayer(latent_dim, self.input_dim, num_grid=num_grid, spline_type=spline_type),
            nn.Sigmoid(),
        )
```

#pagebreak()
Pojedyńcza warstwa KAN oblicza wyjście wyłącznie na podstawie funkcji sklejanej, zgodnie z:
$ y_i=sum_(j=1)^N phi_(i,j)  (x_j ) $
#par(first-line-indent: 0pt)[
gdzie $phi_(i,j)$ to uczona funkcja neuronu na równomiernej siatce węzłów (_grid_ $subset [-5, 5]$), liczba węzłów (`num_grid`) wynosi 6. Typ splajnu wybierany jest parametrem `spline_type` (Dostępne opcje to: `linear`, `bezier`, `catmull_rom`, `bspline`). Dla każdego neuronu uczony jest wektor współczynników o długości `num_grid`.]
```py
class KANLayer(nn.Module):
    def forward(self, x: torch.Tensor) -> torch.Tensor:
        ...
        sp = spline_interpolate(x_e, self.grid, coeff_e, spline_type=self.spline_type)
        return sp.sum(dim=-1)
```
\
Taka architektura autoenkodera KAN jest zatem relatywnie płytka, zawiera po jednej warstwie KAN w enkoderze i dekoderze. Mimo to, pojedyncza warstwa KAN może odwzorowywać skomplikowane zalżności.

== Proces trenowania i rekonstruowania obrazów
Trenowanie autoenkodera KAN przebiega analogicznie jak klasycznego autoenkodera, z tą różnicą, że musieliśmy uwzględnić specyfikę warstw KAN. Przygotowanie danych polegało na normalizacji obrazów do zakresu [0,1]. Eksprymenty zostały przeprowadzone na obrazach w skali szarości, jeśli oryginały były kolorowe, konwertowane były do skali szarości przed podaniem do sieci.

Dane podzielono na zbiory treningowy i walidacyjny (testowy) w proporcji 2:8 (trening:walidacja). Model trenowano metodą uczenia nienadzorowanego (unsupervised), wejściem i oczekiwanym wyjściem były te same obrazy, a sieć uczyła się identycznościowego odwzorowania $x mapsto hat(x)$ poprzez bottleneck $z$. Walidacja polegała na sprawdzaniu średniego błędu rekonstrukcji na obrazach ze zbioru walidacyjnego.

Jako podstawową miarę błędu wykorzystaliśmy błąd średniokwadratowy (MSE) między obrazem oryginalnym $x$ a rekonstrukcją #box[$hat(x)=g_(theta)(f_(theta)(x))$]. Jako Optymalizator został wybrany algorytm Adam z początkowym współczynnikiem uczenia $alpha = 10^(-3)$.

Jedynymi parametrami w warstwie KAN są współczynniki funkcji sklejanych. Siatka węzłów `grid` jest deterministyczna ($[-5,5]$). Współczynniki splinów inicjalizujemy losowo zgodnie z:
$ "coeffs" ~ N(0, 0.05^2) $
#par(first-line-indent: 0pt)[
w kodzie: ```py torch.randn(n_out, n_in, num_grid) * 0.05```, czyli ze średnią 0 i odchyleniem standardowym 0.05. Taki start powoduje, że na początku $phi_(i, j)$ mają małą amplitudę, więc wyjście enkodera oraz wejście dekodera są bliskie zeru. W toku uczenia współczynniki odchylają się od zera, kształtując nieliniowe $phi_(i, j)$ i podnosząc zdolność aproksymacji.]

Sieć trenowaliśmy metodą stochastycznego spadku gradientu w porcjach danych (mini-batch). Rozmiar paczki to 64 obrazki. Trenowanie prowadzono przez 10 epok, już po kilku epokach błąd rekonstrukcji stabilizował się. W celu wybrania najlepszego modelu, po każdej epoce obliczano błąd na zbiorze walidacyjnym, zapisywano parametry modelu, jeśli błąd ten był najmniejszy dotychczas. Następnie do dalszego trenowania kontynuowano od bieżącego stanu, finalnie do oceny brano parametry z epoki o najniższym błędzie walidacyjnym.

Po zakończeniu treningu autoenkodera można wykorzystać go do kompresji i dekompresji obrazów. Kompresja polega na przepuszczeniu nowego obrazu $x$ (nieobecnego w zbiorze uczącym) przez enkoder $f_theta$ i uzyskaniu wektora kodowego $z = f_(theta)(x)$. W implementacji $z$ jest wektorem liczb zmiennoprzecinkowych o wymiarze $K$. Dekodowanie odbywa się przez podanie $z$ do dekodera $g_theta$, który generuje obraz $hat(x) = g_(theta)(z)$. Otrzymaną rekonstrukcję porównujemy z oryginałem. Do oceny jakości, poza MSE, używamy PSNR (Peak Signal-to-Noise Ratio) oraz SSIM (Structural Similarity Index), aby uwzględnić zarówno miarę fizyczną błędu jak i percepcyjną (SSIM). Obie te metryki liczymy dla zbiorów testowych po zakończeniu treningu.

#pagebreak()

= Środowisko i metodologia

== Opis zbiorów danych

Do treningu i testowania modeli wykorzystano zbiory obrazów oraz zestaw danych syntetycznych, aby sprawdzić zachowanie modeli w różnych warunkach:

CIFAR-10: popularny zbiór fotografii w niskiej rozdzielczości @cifar10. Oryginalna rozdzielczość CIFAR-10 to $32 times 32$ piksele. W naszych eksperymentach wykorzystaliśmy wersję przeskalowaną do $16 times 16$ pikseli w skali szarości. Przekształcenie do odcieni szarości zrealizowaliśmy za pomocą transformacji luminancji. Na ilustracjach pokazujemy obrazy wielokrotnie powiększone względem oryginału, aby były czytelne na stronie. Takie powiększenie powoduje widoczną pikselizację.
#figure(
  image(width: 400pt,"images/example-cifar.png"),
  caption: [Przykładowe obrazy ze zbioru CIFAR-10.],
)
MNIST: zbiór 70 000 ręcznie pisanych cyfr w odcieniach szarości, znormalizowanych do rozmiaru $28 times 28$ @minist. Użyty jako prostego przypadku testowego: obrazy MNIST mają bardzo niską złożoność (jednobarwne tło, biały odręczny symbol), co stanowi łatwe zadanie dla autoenkodera. Zbiór ten pozwolił zweryfikować, czy model KAN nie ma problemów z podstawowym dopasowaniem danych i dał punkt odniesienia dla minimalnego błędu, jaki można uzyskać przy danym $K$.
#figure(
  image(width: 400pt,"images/example-minist.png"),
  caption: [Przykładowe obrazy ze zbioru MINIST.],
)
#pagebreak()
Shapes: własny zbiór syntetyczny wygenerowany na potrzeby testów. Składa się on z prostych kształtów geometrycznych (kół, kwadratów, trójkątów, linii) rysowanych losowo na czarnym tle. Wygenerowano 1000 obrazków $32 times 32$ z losowo parametryzowanymi figurami (położenie, rozmiar, rotacja). Przykładowe obrazy z tego zbioru to białe figury na czarnym tle. Dane te służyły zbadaniu, czy KAN potrafi efektywnie kompresować obrazy z wyraźnymi strukturami.
#figure(
  image(width: 400pt,"images/example-shapes.png"),
  caption: [Przykładowe obrazy ze zbioru shapes.],
)
Large: aby ocenić modele na bardziej złożonych i zróżnicowanych obrazach, przygotowaliśmy zestaw większych obrazów fotograficznych, przeskalowanych do rozdzielczości $64 times 64$ pikseli w skali szarości. Wykorzystano tutaj zbiór STL-10 @stl10, zawierający 13 000 kolorowych obrazów $96 times 96$, które dla naszych potrzeb zaskalowano do $64 times 64$. Celem wykorzystania takiego zbioru było sprawdzenie, jak autoenkodery poradzą sobie z zawartością o wysokiej różnorodności (sceny naturalne, tekstury, twarze).
#figure(
  image(width: 400pt,"images/example-large.png"),
  caption: [Przykładowe obrazy ze zbioru large.],
)
Reasumując, do trenowania i porównania autoenkoderów używaliśmy głównie CIFAR-10 ($16 times 16$) i STL-10 ($64 times 64$) jako reprezentantów obrazów naturalnych, MNIST jako prostego przypadku obrazów upraszczonych, oraz zbioru shapes jako przypadku obrazów syntetycznych o ostrych krawędziach. Dzięki temu mogliśmy zaobserwować ewentualne różnice w zachowaniu modeli KAN i CNN w zależności od charakteru danych.

#pagebreak()
== Środowisko eksperymentalne i implementacja
Wszystkie eksperymenty zaimplementowano w języku Python z wykorzystaniem biblioteki PyTorch (wersja 1.13). Cały kod został uruchomiony na macbook pro z procesorem M2 Pro.

Implementację warstwy KAN oparto na idei klasy KolmogorovArnoldLayer z biblioteki pyKAN @kanDocumentation, jednak przygotowano własną wersję dostosowaną do potrzeb eksperymentu. Zaimplementowany moduł KANLayer, dziedziczący po `nn.Module`, podczas inicjalizacji tworzy komplet parametrów definiujących wszystkie funkcje $phi_(i.j)$ w danej warstwie. Parametry te są przechowywane w tensorze `coeffs`, który zawiera wartości funkcji $phi$ w węzłach siatki i jest inicjalizowany małymi, losowymi odchyleniami. Jednocześnie tworzona jest równomierna siatka węzłów `self.grid` w przedziale [-5,5], względem której realizowana jest interpolacja funkcji krawędziowych. Dzięki takiej konstrukcji każda para połączeń (wejście-neuron) ma własną, uczoną w trakcie treningu postać funkcji $phi_(i.j)$, a warstwa może elastycznie modelować nieliniowe zależności między sygnałami.

Warto wspomnieć o złożoności obliczeniowej i czasie treningu. Trening pojedynczej konfiguracji modelu (np. KAN oraz CNN na CIFAR-10 przy zadanym $K$) trwał od kilkunastu minut do kilku godzin, zależnie od modelu. Autoenkoder CNN, oraz Autoenkoder oparty o FastKAN, trenowały się znacznie szybciej. Użycie splotów i mniejsza liczba parametrów sprawiały, że 10 epok na zbiorze CIFAR-10 zajmowało ok. 45min. Własna implementacja autoenkoder KAN była znacznie wolniejszy. 10 epok na CIFAR-10 to ok. 3-4 godziny, głównie z powodu konieczności obliczania splinów składanych dla każdej iteracji.

#pagebreak()
== Parametryzacja i konfiguracja modelu

Aby zbadać wpływ stopnia kompresji, przeprowadzono eksperymenty dla kilku szerokości bottlenecku, $K in {256, 128, 64, 32, 16}$. Dla obrazów o rozmiarze $32 times 32$ piksele ($N=1024$) współczynnik kompresji, zdefiniowany jako $N/K$, wynosi od 4 (dla $K=256$) do 64 (dla $K=16$). Dla obrazów $64 times 64$ ($N=4096$) współczynnik ten przyjmuje wartości od 16 do 256. Każdą konfigurację $K$ trenowano i ewaluowano niezależnie, bez treningu wielozadaniowego.

Wszystkie modele trenowano w identycznych warunkach: 10 epok na każdym zbiorze danych; optymalizator Adam z krokiem uczenia $10^(-3)$ (bez harmonogramu zmian), funkcja kosztu to MSE między obrazem wejściowym a rekonstrukcją, wielkość partii (batch size) równa 64. Po zakończeniu treningu wybierano parametry z epoki o najniższym błędzie walidacyjnym.

Podsumowując, przygotowane środowisko eksperymentalne umożliwiło zbadanie szeregu konfiguracji modeli KAN oraz ich porównanie z klasycznym podejściem konwolucyjnym. W kolejnych rozdziałach przedstawiono wyniki tych porównań, obejmujące metryki ilościowe (MSE, PSNR, SSIM) oraz przykładowe rekonstrukcje obrazów dla wybranych przypadków.

#pagebreak()

= Wyniki eksperymentów
#import "@preview/xarrow:0.3.1": xarrow

Wyniki odnoszą się do trzech rodzin modeli: CNN, KAN (warianty: linear, bézier, catmull, bspline) oraz FastKAN. Dla każdego zbioru danych (dataset): MNIST $28 times 28$, CIFAR-10 $16 times 16$, Shapes $32 times 32$, Large $64 times 64$. Trenowano autoenkodery z pięcioma wariantami szerokości bottleneck: (16, 32, 64, 128, 256). Jakość oceniano metrykami MSE (niżej = lepiej), PSNR (wyżej = lepiej) i SSIM (wyżej = lepiej). Czas inferencji (czas potrzebny wytrenowanemu modelowi na wykonanie kompresji) raportowano jako Czas [ms]. „Najlepszy model” w danej kombinacji wybierano według priorytetu: #box[$"SSIM" xarrow(sym: ==>, "równość") "PSNR" xarrow(sym: ==>, "równość") "MSE"$], równość oznacza sytuację, w której dwie lub więcej konfiguracje osiągają identyczną wartość danej metryki. W takim przypadku wybór najlepszego modelu jest rozstrzygany kolejną metryką w hierarchii priorytetów. Tabelka przedstawia również rozmiar każdego z modeli za pośrednictwem liczby parametrów (l. param.) które model może dostosowywać w trakcie uczenia.

#show table.cell.where(y: 0): strong

#set table(
  align: (x, y) => (
    if y == 0 { center }
    else { left }
  ),
  stroke: (x, y) => if y == 0 {
    (bottom: 1.25pt + black)
  } else if calc.rem(y, 5) == 0 {
    (left: 1pt + black,
    right: 1pt + black,
    bottom: 1pt + black)
  } else {
    (left: 1pt + black,
    right: 1pt + black)
  },
  row-gutter: -0.2pt
)
#let best_results = csv("data/tabelka_najlepsze_modele.csv")
#figure(
  table(
    table.header(..best_results.first()),
    columns: best_results.first().len(),
    ..best_results
      .slice(1)
      .map(round_floats_in_row)
      .flatten(),
  ),
  caption: [Najlepiej dopasowane modele],
)

#par(first-line-indent: 0pt)[Wszystkie wyniki zostały zamieszczone w dodatku A zamieszczonym na końcu pracy.]
== Analiza ilościowa
#set table(
  stroke: 1pt + black,
)

Na zbiorze MNIST przy małym bottlenecku ($16-32$) przewagę uzyskuje CNN (SSIM 0.885 i 0.921). Po zwiększeniu pojemności reprezentacji wyraźnie wygrywa FastKAN — osiąga SSIM do 0.944 i PSNR do 28.05 dB, jednocześnie znacząco obniżając MSE względem CNN. Wraz ze wzrostem bottlenecku FastKAN efektywniej wykorzystuje dodatkową informację, co przekłada się na zauważalny skok jakości rekonstrukcji.

W całym badanym zakresie bottlenecku 16-256 dla CIFAR-10 najlepsze wyniki uzyskuje KAN (linear), dochodząc do SSIM 0.965 i PSNR 29.26 dB. Wynik ten sugeruje, że elastyczne funkcje jednowymiarowe w KAN szczególnie dobrze dopasowują się do statystyk małych, zróżnicowanych obrazków, co przekłada się na bardzo dokładne rekonstrukcje. 

We wszystkich konfiguracjach zbiou Shapes zwycięża FastKAN, a jakość systematycznie rośnie wraz z pojemnością (SSIM od 0.088 do 0.649). Model ten najlepiej zachowuje strukturę prostych figur i ostre krawędzie, podczas gdy CNN ma tendencję do rozmywania konturów, co widać w niskich wartościach SSIM nawet przy większym bottlenecku.

Na zbiorze "Large", dla bottlenecku 16-128 nieznaczną przewagę posiada CNN (SSIM $~0.25-0.27$), jednak przy 256 prym przejmuje FastKAN (SSIM 0.279; PSNR 17.49 dB; wyraźny spadek MSE). Oznacza to, że w przypadku większych i bardziej złożonych obrazów przewaga modeli KAN ujawnia się dopiero przy największej pojemności reprezentacji, podczas gdy dla mniejszych bottlenecków CNN zachowuje minimalnie wyższą zgodność strukturalną.

#import "@preview/lilaq:0.4.0" as lq

#figure(
  print_step_plots(
    (
      ep_mnist_256, 
      ep_mnist_64, 
      ep_mnist_16
    ), 
    lq,
    white_list: "fastkan, kan_linear, cnn",
    w: 450pt,
    h: 130pt
  ),
  kind: image,
  caption: [Ewolucja MSE, PSNR oraz SSIM w trakcie uczenia na zbiorze MNIST (źródło własne).],
)
#par(first-line-indent: 0pt)[Na wykresach przedstawiono jak zmieniały się metryki w trakcie uczenia modeli. Dla czytelności na wykresach widzimy 3 modele dla 3 rozmiarów bottleneck: 256(linia ciągła), 64(linia kropkowana), 16(linia przerywana). Widać na nich jak silnie stopień kompresji wpływa na jakoś kompresji prowadzonej przez modele oparte o KAN.]
== Analiza jakościowa

Przy bardzo silnej kompresji (bottleneck $16-32$), CNN lepiej zachowuje ogólny „zarys” treści szczególnie widoczne jest to na MNIST, gdzie SSIM pozostaje wysokie. Rekonstrukcje są jednak wyraźnie gładsze i bardziej rozmyte, co z jednej strony sprzyja czytelności konturów przy skrajnie małej pojemności, z drugiej zaś ogranicza dalszą poprawę metryk po zwiększeniu szerokości wąskiego gardła, model ma tendencję do „nasycania się” i nie odtwarza drobnych detali równie dobrze jak pozostałe porównywane modele. KAN (linear) daje natomiast rekonstrukcje ostrzejsze i bogatsze w szczegóły (co potwierdzają wysoki PSNR i niski MSE), ale przy bardzo małym bottlenecku bywa podatny na artefakty. Wraz ze wzrostem pojemności szybko nadrabia i ilościowo przewyższa CNN, lepiej zachowując strukturę i faktury.

#figure(
  image(width: 400pt,"images/compare-KANL-CNN.png"),
  caption: [Rekonstrukcja CIFAR-10 przed KAN linear oraz CNN dla bottleneck równego 32 (źródło własne).],
)


#par(first-line-indent: 0pt)[FastKAN łączy zalety obu podejść: utrzymuje wysoką wierność strukturalną bez typowych dla KAN (linear) artefaktów i bez rozmyć charakterystycznych dla CNN. Dzięki temu dominuje na zbiorach z ostrymi krawędziami (Shapes) oraz, przy większych bottleneckach, okazuje się najlepszy także na pozostałych zbiorach, oferując równocześnie dobre metryki i naturalny odbiór wizualny.]

#pagebreak()
== Złożoność i szybkość

Pod względem kosztu obliczeniowego FastKAN jest w większości przypadków najszybszy, na MNIST osiąga typowo $~0.016-0.031$ ms na obraz, a na Shapes $~0.014-0.109$ ms, co czyni go szczególnie atrakcyjnym w zastosowaniach czasu rzeczywistego. KAN (linear) na CIFAR-10 również pracował bardzo szybko ($~0.028-0.335$ ms), przy czym czas rośnie wraz z szerokością bottlenecku, pozostając jednak w przedziale opóźnień akceptowalnych dla aplikacji interaktywnych. CNN jest zauważalnie wolniejszy na zbiorze Large: $~2.61-2.65$ ms na obraz, podczas gdy FastKAN przy bottlenecku 256 potrzebuje jedynie $~0.137$ ms. Różnica o rząd wielkości na korzyść FastKAN przekłada się na realną przewagę wdrożeniową: niższe opóźnienia oraz większa responsywność systemów wykorzystujących autoenkodery do kompresji i rekonstrukcji obrazów. CNN jednak ma ogromną przewagę czasową nad modelami zaimplementowanymi od zera.

#pagebreak()
= Wnioski

Modele oparte na KAN (zwłaszcza FastKAN) osiągają wyższą jakość rekonstrukcji niż klasyczne CNN, o ile szerokość wąskiego gardła jest wystarczająca ($>= 64-128$). Potwierdzają to wartości SSIM i PSNR: na CIFAR-10 KAN linear dochodzi do SSIM = 0,965 i PSNR = 29,26 dB, a na MNIST FastKAN osiąga SSIM = 0,944 i PSNR = 28,05 dB. Dla bardzo małych bottlenecków ($16-32$) częściej lepszy bywa CNN, zwłaszcza na prostych danych, ponieważ lepiej zachowuje globalny zarys obiektu (wyższy SSIM). Po zwiększeniu rozmiaru bottleneck'a KAN szybciej podnosi jakość kompresji niż w CNN.

Istotna jest także specyfika danych. Dla obrazów z wyraźnymi krawędziami i prostymi strukturami (Shapes) FastKAN okazał się zdecydowanie najlepszy (przy bottleneck $"bottleneck"=256$ uzyskano SSIM = 0,649), co sugeruje, że elastyczne funkcje jednowymiarowe skutecznie zachowują ostrość konturów. Na bardzo małych obrazkach naturalnych (CIFAR-10) w całym zakresie bottlenecków dominował KAN linear, osiągając niemal bezbłędne rekonstrukcje. W przypadku większych i bardziej złożonych obrazów (Large) przewaga modeli KAN ujawniała się dopiero przy mniejszym stopniu kompresji, dla mniejszych bottlenecków różnice były niewielkie i często na korzyść CNN.

Z punktu widzenia praktycznego FastKAN łączy wysoką jakość z bardzo krótkimi czasami inferencji, często o rząd wielkości krótszymi niż w CNN, co czyni go najpraktyczniejszym wyborem w zastosowaniach autoenkoderowej kompresji. W zestawieniu globalnym FastKAN okazał się najlepszy 9/20 razy, CNN 6/20, a KAN linear 5/20. W konsekwencji, gdy liczą się jednocześnie jakość i szybkość, najlepszą opcją jest FastKAN. Dla bardzo małych, zróżnicowanych obrazów przewagę potrafi mieć KAN linear, przy ekstremalnej kompresji lub bardzo prostych scenariuszach najlepsze wynik zapewniał CNN.

Warianty KAN z bardziej złożonymi krzywymi bazowymi (bézier/catmull/bspline) w takich warunkach jak podczas prowadzonych badań nie przewyższyły KAN linear ani FastKAN i nie zdobyły przewagi w żadnej kombinacji. Najprawdopodobniej wymagają one dłuższego treningu, silniejszej regularyzacji (np. ograniczeń krzywizny/oscylacji, gładkości) lub lepszej inicjalizacji, by wykorzystać swój potencjał i ustabilizować zbieżność.

Należy pamiętać o ograniczeniach. Badane autoenkodery były płytkie i trenowane krótko (10 epok), co może sprzyjać prostszym wariantom (KAN linear) względem bardziej skomplikowanych splinów. Ponadto nie modelowano kwantyzacji ani entropii, więc ocenialiśmy „czystą” rekonstrukcję, a nie rzeczywisty bitrate. Jest to ważny krok w stronę pełnego kodeka opartego na modelach uczenia maszynowego, lecz nie jego pełny substytut.

Ponadto obserwacje odpowiadają wynikom z pracy "Kolmogorov-Arnold Network Autoenkoders", gdzie porównano autoenkodery KAN z konwolucyjnymi autoenkoderami na MNIST, SVHN i CIFAR-10 i wykazano co najmniej konkurencyjną jakość rekonstrukcji. Zastosowano tam jednak bogatszą niż u nas konstrukcję (warstwa KAN + ReLU + warstwa gęsta w enkoderze i decoderze), zestawiając ją z konwolucyjnym autoenkoderami jako punktem odniesienia. Co więcej, wyniki dotyczące FastKAN pokazują, że zastąpienie B-splinów funkcjami radialnymi znacząco przyspiesza obliczenia bez spadku dokładności @autoenkoderKAN.

== Możliwości dalszego rozwoju

Obiecującym kierunkiem jest rozwój architektury są głębsze autoenkodery KAN, warianty z warstwami konwolucyjnymi lub bloki hybrydowe CNN-KAN, a przy wyższych rozdzielczościach integracja z transformatorami. Taka kombinacja może lepiej wydobywać struktury lokalne, utrzymując wysoką elastyczność funkcji jednowymiarowych KAN.

Istotnym aspektem jest efektywność. Przycinanie połączeń (pruning) w KAN, regularizacja gładkości funkcji krawędziowych, kwantyzacja i destylacja do lżejszych modeli. Te zabiegi, sprzyjają wdrożeniom brzegowym i scenariuszom czasu rzeczywistego.

#pagebreak()

#bibliography(style: "ieee", "refs.bib") // [10]

#pagebreak()
#set heading(numbering: none)

= Spis obrazów
#outline(target: figure.where(kind: image), title: "")

#pagebreak()

= Spis tabel
#outline(target: figure.where(kind: table), title: "")

#pagebreak()
= Summary
This work explores whether Kolmogorov-Arnold Networks (KAN), neural architecture proposed in 2024 that replaces scalar weights with learned one-dimensional functions can serve as an effective backbone for image compression via autoenkoders, and how they compare to a conventional convolutional autoenkoder (CNN). After outlining the essentials of image compression and the evaluation metrics used (MSE, PSNR, SSIM), the thesis focuses on end-to-end reconstruction quality at fixed latent sizes as a proxy for bitrate. Unlike full neural codecs, explicit quantization and entropy modeling are not included, so results isolate how well different enkoders learn compact, reconstructive representations.

Two families of models were implemented in PyTorch: (I) shallow KAN autoenkoders whose enkoder and decoder are single KAN layers that sum learned per-edge functions $phi(x)$ parameterized on a fixed grid (variants: linear, Bézier, Catmull-Rom, B-spline), and (II) a baseline CNN autoenkoder tuned to match the same bottleneck dimensionality $K$. An additional accelerated variant, FastKAN, substitutes Gaussian radial basis functions for splines to reduce inference cost. All experiments used grayscale inputs and identical training conditions: Adam (1e-3), batch size 64, 10 epochs, with model selection by lowest validation loss on a 20/80 train/validation split. Datasets covered a spectrum of complexity and scale: MNIST ($28 times 28$ digits), CIFAR-10 downscaled to $16 times 16$ (small natural images), a synthetic Shapes set ($32 times 32$ geometric figures with sharp edges), and a “Large” set ($64 times 64$ grayscale from STL-10). Each model was trained independently at $K in {16,32,64,128,256}$ to probe extreme through moderate compression.

Results show that KAN-based models, especially FastKAN, match or surpass CNNs once the bottleneck is moderately large (typically $K >= 64-128$), whereas CNNs tend to hold a slight advantage at the most severe compression levels ($K in {16, 32}$), where preserving global structure dominates. On MNIST, CNN leads at very small $K$, but FastKAN becomes best as capacity grows, reaching SSIM 0.944 and PSNR 28.05 dB with lower MSE. On tiny natural images (CIFAR-10 at $16 times 16$), KAN with linear splines is best across all $K$, up to SSIM 0.965 and PSNR 29.26 dB, suggesting that learned per-edge transforms exploit small-image statistics effectively. On Shapes, FastKAN dominates at every $K$, improving monotonically with capacity and attaining SSIM 0.649 at $K=256$, reflecting superior edge preservation compared with CNN's tendency to blur contours. For the Large set ($64 times 64$), CNN is marginally better at $K in {16, 32, 64, 128}$, but FastKAN overtakes at $K=256$ (SSIM 0.279, PSNR 17.49 dB), indicating that KAN's flexibility becomes beneficial given sufficient latent bandwidth.

Efficiency measurements highlight FastKAN's practicality: it achieves the lowest inference latencies (e.g., $~0.016-0.031$ ms per MNIST image and $~0.014-0.109$ ms on Shapes), and on the Large set at $K=256$ it is about an order of magnitude faster than CNN ($~0.137$ ms vs. $~2.6$ ms per image), despite the KAN family's higher per-connection expressivity. Training, however, is heaviest for the custom spline-based KAN (e.g., $~3-4$ h for 10 epochs on CIFAR-10) versus $~45$ min for CNN and FastKAN under identical settings. Counting per-setting wins across datasets and $K$, FastKAN leads (9/20), followed by CNN (6/20) and KAN-linear (5/20). More complex spline variants (Bézier, Catmull-Rom, B-spline) did not outperform KAN-linear or FastKAN within this training budget, likely needing stronger regularization or longer training to realize their potential.

In sum, KAN-based autoenkoders are a credible, often superior alternative to CNNs for learned image compression when the code is not extremely constrained. FastKAN, in particular, offers a compelling quality-latency trade-off for deployment, while KAN-linear shines on very small natural images. Limitations include shallow architectures, short training runs, and the absence of a rate model, so conclusions pertain to reconstruction at fixed latent sizes rather than true rate-distortion. Future work should explore deeper or hybrid CNN-KAN designs (and transformers at higher resolutions), curvature/growth regularization for spline stability, pruning and quantization for compact models, and full rate-distortion training with learned entropy models to turn KAN autoenkoders into end-to-end neural codecs.
#pagebreak()

#show heading.where(level:1): it => {
  counter(figure.where(kind: table)).update(0)
  it
}
#show heading.where(level:1): it => {
  counter(figure.where(kind: image)).update(0)
  it
}

#show heading: it => [ // [3]
  #set text(14pt, weight: "bold")
  #block(it, spacing: leading_size, )
]

#set figure(
  numbering: none,
)

#let results_256 = csv("data/results_256.csv")

#show table.cell.where(y: 0): strong

#set table(
  stroke: (x, y) => if y == 0 {
    (bottom: 1.25pt + black)
  } else if calc.rem(y, 6) == 0 {
    (left: 1pt + black,
    right: 1pt + black,
    bottom: 1pt + black)
  } else {
    (left: 1pt + black,
    right: 1pt + black)
  },
  row-gutter: 0pt
)


#show table.cell: set text(size: 10pt)

#show table.cell.where(y: 0): (it) => text(it, weight: 200)
= Dodatek A
#figure(
  table(
    table.header(..results_256.first()),
    columns: results_256.first().len(),
    ..results_256
      .slice(1)
      .map(round_floats_in_row)
      .flatten(),
  ),
  caption: [Wyniki (bottleneck = 256)],
)
#let results_128 = csv("data/results_128.csv")
#figure(
  table(
    table.header(..results_128.first()),
    columns: results_128.first().len(),
    ..results_128
      .slice(1)
      .map(round_floats_in_row)
      .flatten(),
  ),
  caption: [Wyniki (bottleneck = 128)],
)
#let results_64 = csv("data/results_64.csv")
#figure(
  table(
    table.header(..results_64.first()),
    columns: results_64.first().len(),
    ..results_64
      .slice(1)
      .map(round_floats_in_row)
      .flatten(),
  ),
  caption: [Wyniki (bottleneck = 64)],
)
#let results_32 = csv("data/results_32.csv")
#figure(
  table(
    table.header(..results_32.first()),
    columns: results_32.first().len(),
    ..results_32
      .slice(1)
      .map(round_floats_in_row)
      .flatten(),
  ),
  caption: [Wyniki (bottleneck = 32)],
)
#let results_16 = csv("data/results_16.csv")
#figure(
  table(
    table.header(..results_16.first()),
    columns: results_16.first().len(),
    ..results_16
      .slice(1)
      .map(round_floats_in_row)
      .flatten(),
  ),
  caption: [Wyniki (bottleneck = 16)],
)

// = Dodatek B
// #figure(
//   image(width: 400pt,"images/results/MINIST_256.png"),
//   caption: [Rekonstrikcja MINIST (bottleneck = 256)],
// )
// #figure(
//   image(width: 400pt,"images/results/CIFAR_256.png"),
//   caption: [Rekonstrikcja CIFAR (bottleneck = 256)],
// )
// #figure(
//   image(width: 400pt,"images/results/large_256.png"),
//   caption: [Rekonstrikcja large (bottleneck = 256)],
// )
// #figure(
//   image(width: 400pt,"images/results/shapes_256.png"),
//   caption: [Rekonstrikcja shapes (bottleneck = 256)],
// )



// #figure(
//   image(width: 400pt,"images/results/MINIST_128.png"),
//   caption: [Rekonstrikcja MINIST (bottleneck = 128)],
// )
// #figure(
//   image(width: 400pt,"images/results/CIFAR_128.png"),
//   caption: [Rekonstrikcja CIFAR (bottleneck = 128)],
// )
// #figure(
//   image(width: 400pt,"images/results/large_128.png"),
//   caption: [Rekonstrikcja large (bottleneck = 128)],
// )
// #figure(
//   image(width: 400pt,"images/results/shapes_128.png"),
//   caption: [Rekonstrikcja shapes (bottleneck = 128)],
// )



// #figure(
//   image(width: 400pt,"images/results/MINIST_64.png"),
//   caption: [Rekonstrikcja MINIST (bottleneck = 64)],
// )
// #figure(
//   image(width: 400pt,"images/results/CIFAR_64.png"),
//   caption: [Rekonstrikcja CIFAR (bottleneck = 64)],
// )
// #figure(
//   image(width: 400pt,"images/results/large_64.png"),
//   caption: [Rekonstrikcja large (bottleneck = 64)],
// )
// #figure(
//   image(width: 400pt,"images/results/shapes_64.png"),
//   caption: [Rekonstrikcja shapes (bottleneck = 64)],
// )


// #figure(
//   image(width: 400pt,"images/results/MINIST_32.png"),
//   caption: [Rekonstrikcja MINIST (bottleneck = 32)],
// )
// #figure(
//   image(width: 400pt,"images/results/CIFAR_32.png"),
//   caption: [Rekonstrikcja CIFAR (bottleneck = 32)],
// )
// #figure(
//   image(width: 400pt,"images/results/large_32.png"),
//   caption: [Rekonstrikcja large (bottleneck = 32)],
// )
// #figure(
//   image(width: 400pt,"images/results/shapes_32.png"),
//   caption: [Rekonstrikcja shapes (bottleneck = 32)],
// )



// #figure(
//   image(width: 400pt,"images/results/MINIST_16.png"),
//   caption: [Rekonstrikcja MINIST (bottleneck = 16)],
// )
// #figure(
//   image(width: 400pt,"images/results/CIFAR_16.png"),
//   caption: [Rekonstrikcja CIFAR (bottleneck = 16)],
// )
// #figure(
//   image(width: 400pt,"images/results/large_16.png"),
//   caption: [Rekonstrikcja large (bottleneck = 16)],
// )
// #figure(
//   image(width: 400pt,"images/results/shapes_16.png"),
//   caption: [Rekonstrikcja shapes (bottleneck = 16)],
// )
