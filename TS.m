const;


tspan = 0:Tp:Tsym;
F1 = F1out(F1in, F1in, Top, n, Tp);
Fd = Fdout(Fd0, n);
ymin = 0;
ymax = 120;
zbocze = 10;
l = 5; %%liczba modeli
graniczne = zbioryrozmyte(ymin, ymax, l, zbocze); %%krance przedzialow zmiennych rozmytych

[t, V] = model(tspan, y0, F1, Fd, p, q, Tp, Tsym);
[t, V_lin] = model_lin(tspan, y0, F1, Fd, a1, a2, a3, b1, b2, Tp, Tsym);

h2lin_w = getH2linW(ymin, ymax, zbocze, l);
V2lin_w = V2(h2lin_w, C2);

a2_w = -q * ((nthroot(V2lin_w, 4)).^(-3)) / 4;  %%potrzebne, poniewa¿ przy zmianie punktu linearyzacji zmieniaja sie takze wspolczynniki a2, b2...
b2_w = -b1 - 3 * q * (nthroot(V2lin_w, 4)) / 4; %%...gdyz skaczemy miedzy punktami linearyzacji dla roznych modeli lokalnych
h2_w_akt = zeros(1, l); %%wektor na aktualne wyjscia modeli lokalnych
sila_odpalenia_w_akt = zeros(1, l); %%wektor na aktualne sily odpalen regul
h2_TS = zeros(n+1, 1);
h2_TS(1,1) = H2zlin(V2_0, Ch2, V2_lin);
h2_TS_pop = h2_TS(1,1);
% h2_w_pop = zeros(1, l); %%wektor na poprzednie wyjscia modeli lokalnych
h2_grupa = zeros(n+1, l); %%grupowo zebrane wszystkie odpowiedzi skokowe modeli lokalnych
for i = 1 : l
    [t, V_lok] = model_lin(tspan, y0, F1, Fd, a1, a2_w(1, i), a3, b1, b2_w(1,i), Tp, Tsym);
    h2_grupa(:, i) = H2zlin(V_lok(:, 2), Ch2, V2lin_w(1, i));
end


for k = 2: n+1
    h2_w_akt = 0 * h2_w_akt;
    sila_odpalenia_w_akt = 0 * sila_odpalenia_w_akt;
    y = 0;
    
    for i = 1 : l
        if h2_TS_pop >= graniczne(i, 1) && h2_TS_pop <= graniczne(i, 2) %%je¿eli poprzednie h2 pasuje do regu³y...
            h2_w_akt(1, i) = h2_grupa(k, i); %%... to zastosuj regu³ê
            sila_odpalenia_w_akt(1, i) = funprzyn(h2_TS_pop, l, ymin, ymax, zbocze, i); 
            y = y + sila_odpalenia_w_akt(1, i) * h2_w_akt(1, i);
        end
    end
    suma_sil = sum(sila_odpalenia_w_akt);
    y = y / suma_sil; %%normalizacja
    
    h2_TS(k, 1) = y;
    h2_TS_pop = y;
%     disp(k);
%     disp(h2_w_akt);
%     disp(sila_odpalenia_w_akt);
    if sum(sila_odpalenia_w_akt) ~= 1
        disp('error');
    end
%     pause(0.05);
end
    
h2 = H2(V(:, 2), Ch2);
h2_lin = H2zlin(V_lin(:, 2), Ch2, V2_lin);

fh = figure;
fh.WindowState = 'maximized';
stairs(tspan, h2);
hold on;
stairs(tspan, h2_lin);
stairs(tspan, h2_TS);
legend({'nieliniowy', 'liniowy', 'TS'}, 'Location', 'southeast');
hold off;