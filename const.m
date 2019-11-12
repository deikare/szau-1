clear;
C1 = 0.65;
C2 = 0.85;
al1 = 13;
al2 = 16;

F1in = 78;
Fd0 = 15;
h1_0 = 0;
h2_0 = 33.7852;
V1_0 = V1(h1_0, C1); %warunki pocz¹tkowe objetosci
V2_0 = V2(h2_0, C2); %warunki pocztkowe objetosci

p = al1/nthroot(C1, 4); %jak uzaleznilem wszystkie wyp³ywy zamiast od h1, h2, to V1, V2, to tu licze wspolczynniki
q = al2/nthroot(C2, 6); %jak cos nthroot(C2, 3) to pierwiastek 3iego stopnia z C2
Ch1 = 1 / sqrt(C1); %a te to pomocnicze przy liczeniu wysokosci z objetosci
Ch2 = 1 / nthroot(C2, 3);

Top = 0;
Tsym = 300;
Tp = 2;

V1ust = ((F1in+Fd0)/p)^4; %w stanie ustalonym
V2ust = ((F1in+Fd0)/q)^6;

h1ust = Ch1 * sqrt(V1ust); %w stanie ustalonym
h2ust = Ch2 * nthroot(V2ust, 3);

n = Tsym/Tp;

y0 = [V1_0, V2_0];

disp(['h1ust = ', num2str(h1ust)]);
disp(['h2ust = ', num2str(h2ust)]);

