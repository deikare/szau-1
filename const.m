clear;
C1 = 0.65;
C2 = 0.85;
al1 = 13;
al2 = 16;

F1in = 78;
Fd0 = 15;
h1_0 = 51.1775;
% h1_0 = 0;
h2_0 = 33.7852;
% h2_0 = 0;
V1_0 = V1(h1_0, C1); %warunki pocz¹tkowe objetosci
V2_0 = V2(h2_0, C2); %warunki pocztkowe objetosci

p = al1/nthroot(C1, 4); %jak uzaleznilem wszystkie wyp³ywy zamiast od h1, h2, to V1, V2, to tu licze wspolczynniki
q = al2/nthroot(C2, 4); %jak cos nthroot(C2, 3) to pierwiastek 3iego stopnia z C2
Ch1 = 1 / sqrt(C1); %a te to pomocnicze przy liczeniu wysokosci z objetosci
Ch2 = 1 / sqrt(C2);

Top = 90;
Tsym = 1000;
Tp = 5;

V1ust = ((F1in+Fd0)/p)^4; %w stanie ustalonym
V2ust = ((F1in+Fd0)/q)^4;

h1ust = Ch1 * sqrt(V1ust); %w stanie ustalonym
h2ust = Ch2 * sqrt(V2ust);

n = Tsym/Tp;

y0 = [V1_0, V2_0];

disp(['h1ust = ', num2str(h1ust)]);
disp(['h2ust = ', num2str(h2ust)]);

%pkty linearyzacji
h1_lin = 35;
h2_lin = 33.7852;
% h2_lin = 32;

V1_lin = V1(h1_lin, C1);
V2_lin = V2(h2_lin, C2);

%wspolczynniki do modelu liniowego
a1 = -p * ((nthroot(V1_lin, 4)).^(-3)) / 4;
a2 = -q * ((nthroot(V2_lin, 4)).^(-3)) / 4;
a3 = -a1;
b1 = -3*p * (nthroot(V1_lin, 4)) / 4;
b2 = -b1 - 3 * q * (nthroot(V2_lin, 4)) / 4;

%w stanie ustalonym w linearyzacji
V1ust_lin = (-F1in-Fd0-b1)/a1;
V2ust_lin = (-a3 * V1ust_lin - b2) / a2;

h1ust_lin = Ch1 * sqrt(V1ust_lin);
h2ust_lin = Ch2 * nthroot(V2ust, 3);

disp(['h1ust_lin = ', num2str(h1ust_lin)]);
disp(['h2ust_lin = ', num2str(h2ust_lin)]);
