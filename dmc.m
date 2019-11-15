const;

tspan = 0 : Tp : Tsym;

F1 = F1out(F1in, F1in+20, Top, n, Tp);
Fd = Fdout(Fd0, n);
[t, V_lin] = model_lin(tspan, y0, F1, Fd, a1, a2, a3, b1, b2, Tp, Tsym);
figure;
stairs(t, V_lin(:, 1));
hold on;
stairs(t, V_lin(:, 2));
hold off;

h1_lin = (H1zlin(V_lin(:, 1), Ch1, V1_lin) - h1_0) / 20 + h1_0; %podzielic przez wielkosc skoku
h2_lin = (H2zlin(V_lin(:, 2), Ch2, V2_lin)  - h2_0) / 20 + h2_0;

% figure;
% % stairs(t, h1_lin);
% % hold on;
% stairs(t, h2_lin);
% % hold off;


D = round(440/Tp);
% D = 5;
s = h2_lin(1:D);
Nu = 5;
N = 5;
fi = 5;
lam = 0.3;
yzad = 25;
Fi = diag(zeros(1, N) + fi);
Lambda = diag(zeros(1, Nu) + lam);

deltaUmax = 30;
umax = 120;
umin = 30;

disp(Fi);
disp(Lambda);
M = zeros(N, Nu);
k = 1;
Yzad = zeros(n+1, 1) + yzad;

h1_dmc = zeros(n+1, 1);
h2_dmc = zeros(n+1, 1);
V1_dmc = zeros(n+1, 1);
V2_dmc = zeros(n+1, 1);
F2_dmc = zeros(n+1, 1);
F3_dmc = zeros(n+1, 1);


deltaU_op = zeros(n + 1, 1); %%%bufor na opoznione sygnaly deltaU z dmc
for j = 1 : Nu
    M(k:N, j) = s(1 : N - k + 1);
    k = k+1;
end

deltaU_p = zeros(D - 1, 1);
U = zeros(n+1, 1); %wektor sterowan == F1

Mp = zeros(N, D-1);
s_zas = zeros(N+D-1, 1); %rozszerzony wektor s o dodatkowe probki rowne wzmocnieniu, aby dalo sie dostac postac Mp
s_zas(1:D, 1) = s(:, 1);
s_zas(D+1:N+D-1, 1) = s(D, 1);
for j = 1 : D-1
   k = j+1; %indeks pierwszego odjecia
   for i = 1 : N
      Mp(i, j) = s_zas(k) - s_zas(j); %
      k = k+1;
   end
end

shift = round(Top / Tp); %o ile probek przesuniety ma byc sygnal sterujacy

K = ((M') * Fi * M + Lambda) \ ((M') * Fi);
ke = 0;
for i = 1 : N
    ke = ke + K(1, i);
end
ku = K(1, :) * Mp;
for k = 1:n+1 %%TODO - uzyskac y_akt i wygenerowac w kazdej iteracji wektor sterowan F1
    %%liczenie dla aktualnej chwili k parametrow obiektu
    [t, V] = model_lin(tspan, y0, U, Fd, a1, a2, a3, b1, b2, Tp, Tsym); %%TODO - dodac dla aktualnej chwili k, a nie calej tspan
    V1_dmc(k, 1) = V(k, 1);
    V2_dmc(k, 1) = V(k, 2);
    h1_dmc(k, 1) = H1zlin(V1_dmc(k, 1),Ch1, V1_lin);
    h2_dmc(k, 1) = H2zlin(V2_dmc(k, 1), Ch2, V2_lin);
    F2_dmc(k, 1) = F2out(al1, h1_dmc(k, 1)); %%trzeba dodac funkcje linearyzacyjna F2out
    F3_dmc(k, 1) = F3out(al2, h2_dmc(k, 1));
    
    y_akt = h2_dmc(k, 1);
    suma = 0;
    for i = 1: (D-1)
       suma = suma + ku(1, i) * deltaU_p(i, 1);
    end
    delta_u = ke * (Yzad(k) - y_akt) + suma; %wartosc wyliczona, ale potrzebujaca przesuniecia w czasie o shift probek
    
    if (delta_u < -deltaUmax) %%ograniczenie na zmiane sygnalu sterujacego
        delta_u = -deltaUmax;
    elseif (delta_u > deltaUmax)
        delta_u = deltaUmax;
    end
    
    
    if (k + shift < n + 1)
        deltaU_op(k + shift, 1) = delta_u;
        %%bez sensu
%     else %jezeli wychodzimy z opoznieniem poza zakres, to zmodyfikuj
%     ostatni
%         deltaU_op(n + 1, 1) = delta_u;
    end
    
    delta_u_akt = deltaU_op(k, 1); %%aktualna wartosc sterowania, ustawiona <shift> chwil wczesniej
    if (k == 1)
        upop = 0;
    else
        upop = U(k-1,1); %wartosc sterowania w chwili poprzedniej
    end
    
    if (delta_u_akt + upop < umin) %rzutowanie ograniczen na wartosc sterowania
        delta_u_akt = umin - upop;
    elseif (delta_u_akt + upop > umax)
        delta_u_akt = umax - upop;
    end
    
    U(k,1) = upop + delta_u_akt; %wartosc sterowania w chwili aktualnej - jednoczesnie jest to F1 - juz przesuniete w czasie
    deltaU_p = circshift(deltaU_p, 1); %przesuwam wartosc poprzednich sterowan, na pierwsza wspolrzedna...
    deltaU_p(1,1) = delta_u_akt;       %wstawiam aktualny wzrost sterowania
    disp(k);
    disp(y_akt);
    disp(U(k, 1));
end

figure;
stairs(tspan, h2_dmc);
figure;
stairs(tspan,U);
