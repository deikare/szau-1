clear;
C1 = 0.65;
C2 = 0.85;
al1 = 13;
al2 = 16;

F1in = 78;
Fd0 = 15;
h2 = 33.7852;

p = al1/sqrt(C1); %jak uzaleznilem wszystkie wyp³ywy zamiast od h1, h2, to V1, V2, to tu licze wspolczynniki
q = al2/nthroot(C2, 3); %jak cos nthroot(C2, 3) to pierwiastek 3iego stopnia z C2
Ch1 = 1 / sqrt(C1); %a te to pomocnicze przy liczeniu wysokosci z objetosci
Ch2 = 1 / nthroot(C2, 3);

Top = 90;
Tsym = 200;
Tp = 2;

n = Tsym/Tp;

y0 = [0, V2(h2, C2)];

