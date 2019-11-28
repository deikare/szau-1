const;

tspan = 0 : Tp : Tsym;

% F1 = F1out(F1in, F1in+20, Top, n, Tp);
F1 = F1out(F1in, F1in+1, Top, n, Tp);
Fd = Fdout(Fd0, n);

h2lin_w = [10 16 35 40 63];
V2lin_w = V2(h2lin_w, C2);


% y0 = [V1zlin(h1_lin, C1, h1_lin), V2_0];
[t, V_lin] = model_lin(tspan, y0, F1, Fd, a1, a2, a3, b1, b2, Tp, Tsym);
L = 5; %liczba modeli lokalnych
% figure;
% stairs(t, V_lin(:, 1));
% hold on;
% stairs(t, V_lin(:, 2));
% hold off;

% h1_lin = (H1zlin(V_lin(:, 1), Ch1, V1_lin) - h1_0) / 20 + h1_0; %podzielic przez wielkosc skoku
%h2_lin = (H2zlin(V_lin(:, 2), Ch2, V2_lin)  - h2_0) / 20 + h2_0;
% h2_lin = (H2zlin(V_lin(:, 2), Ch2, V2_lin)  - h2_0) / 20;
h2_lin = H2zlin(V_lin(:, 2), Ch2, V2_lin);
% stairs(t, h2_lin);
% pause(0.01);
% figure;
% % stairs(t, h1_lin);
% % hold on;
% stairs(t, h2_lin);
% hold off;


% D = round(595/Tp);
D = getD(h2_lin, 0.0001);
% D = round(410/Tp);
% D = 5;
% s = h2_lin_w(1:D);
s = h2_lin(1:D);
Nu = 10;
N = D;
fi = 1;
lam = 0.05;
% hzad = 50;
yzad = 50;
yzad_pmax = yzad * 1.05; %%koordynaty do narysowania strefy +- 5% yzad
yzad_pmin = yzad * 0.95;
h = yzad * 0.1;  %wysokosc strefy
% yzad = V2zlin(hzad, C2, h2_lin);
disp(['korytarz +-5% yzad = ', num2str(yzad * 1.05), ' ', num2str(yzad * 0.95)]); 
Fi = diag(zeros(1, N) + fi);
Lambda = diag(zeros(1, Nu) + lam);

deltaUmax = 5;
umax = 2*F1in;
umin = 0;

% disp(Fi);
% disp(Lambda);
M = zeros(N, Nu);
k = 1;
% Hzad = zeros(n+1, 1) + hzad;
Yzad = zeros(n+1, 1) + yzad;
Yzad_pmax = Yzad * 1.05;
Yzad_pmin = Yzad * 0.95;

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

fh1 = figure;
fh1.WindowState = 'maximized';
hold on;
tiledlayout(2, 1);
h2tile = nexttile;
Vtile = nexttile;

fh2 = figure;
fh2.WindowState = 'maximized';
hold on;
tiledlayout(2, 1);
utile = nexttile;
F2F3tile = nexttile;
for k = 1:n+1 %%TODO - uzyskac y_akt i wygenerowac w kazdej iteracji wektor sterowan F1
    if (k == 1)
        V = [V1_0 V2_0];
    else    
        [t, V] = model(tspan(1:k), y0, U(1:k, 1), Fd(1:k, 1), p, q, Tp, tspan(k));
    end
    h1_dmc(k, 1) = H1(V(k, 1), Ch1);
    h2_dmc(k, 1) = H2(V(k, 2), Ch2);
    y_akt = h2_dmc(k, 1);
    suma = 0;
    for i = 1: (D-1)
       suma = suma + ku(1, i) * deltaU_p(i, 1);
    end
    delta_u = ke * (Yzad(k) - y_akt) - suma; %wartosc wyliczona, ale potrzebujaca przesuniecia w czasie o shift probek
    
%     if (delta_u < -deltaUmax) %%ograniczenie na zmiane sygnalu sterujacego
%         delta_u = -deltaUmax;
%     elseif (delta_u > deltaUmax)
%         delta_u = deltaUmax;
%     end
    
    
    if (k + shift < n + 1)
        deltaU_op(k + shift, 1) = delta_u;
    end
    
    delta_u_akt = deltaU_op(k, 1); %%aktualna wartosc sterowania, ustawiona <shift> chwil wczesniej
    if (k == 1)
        upop = 0;
    else
        upop = U(k-1,1); %wartosc sterowania w chwili poprzedniej
    end
    
%     if (delta_u_akt + upop < umin) %rzutowanie ograniczen na wartosc sterowania
%         delta_u_akt = umin - upop;
%     elseif (delta_u_akt + upop > umax)
%         delta_u_akt = umax - upop;
%     end

    if (delta_u_akt + upop < umin)
        delta_u_akt = umin - upop;
    end
    
    U(k,1) = upop + delta_u_akt; %wartosc sterowania w chwili aktualnej - jednoczesnie jest to F1 - juz przesuniete w czasie
    deltaU_p = circshift(deltaU_p, 1); %cofam o jedna chwile wartosc poprzednich sterowan, a na pierwsza wspolrzedna ...
    deltaU_p(1,1) = delta_u_akt;       %... wstawiam aktualny wzrost sterowania

    disp(k);
    disp(y_akt);
    disp(delta_u_akt);
end
hold off;

V1_dmc = V1(h1_dmc, C1);
V2_dmc = V2(h2_dmc, C2);

F2_dmc = F2out(al1, h1_dmc);
F3_dmc = F3out(al2, h2_dmc);

fh = figure;
hold on;
fh.WindowState = 'maximized';
tiledlayout(2, 1);
figure(fh);
       nexttile(1);
       rectangle('Position', [0 yzad_pmin Tsym h], 'FaceColor', '#F5F0D7', 'EdgeColor', '#EDB120', 'LineStyle', '--');
       hold on;
       stairs(tspan, h1_dmc, 'Color', '#0072BD');
       
       stairs(tspan, h2_dmc, 'Color', '#D95319');
       
       plot(tspan, Yzad, '--', 'Color', '#EDB120');
%        plot(tspan, Yzad_pmax, '
       axis([0 Tsym 0 inf]);
       title('h');
       legend({'h1', 'h2'}, 'Location' , 'southeast');
       hold off;
       
       nexttile(2);
       stairs(tspan, V1_dmc);
       hold on;
       stairs(tspan, V2_dmc);
       axis([0 Tsym 0 inf]);
%        plot(tspan, Yzad, '--');
       title('V');
       legend({'V1', 'V2'}, 'Location' , 'southeast');
       hold off;
hold off;

fh = figure;
hold on;
fh.WindowState = 'maximized';
tiledlayout(2, 1);

nexttile(1);
stairs(tspan, U);
       hold on;
       stairs(tspan, Fd);
       axis([0 Tsym umin inf]);
       title('doplywy');
       legend({'F1(U)', 'Fd'}, 'Location' , 'southeast');
       hold off;
       

nexttile(2);
       stairs(tspan, F2_dmc);
       hold on;
       stairs(tspan, F3_dmc);
       axis([0 Tsym 0 inf]);
       title('odplywy');
       legend({'F2', 'F3'}, 'Location' , 'southeast');
       hold off;
hold off;

% fh = figure;
% hold on;
% tiledlayout(2, 1);
% nexttile;
% stairs(tspan, h2_dmc);
% title('H2');
% % fh.WindowState = 'maximized';
% % fh = figure;
% nexttile;
% stairs(tspan,U);
% title('U');
% fh.WindowState = 'maximized';
% hold off;