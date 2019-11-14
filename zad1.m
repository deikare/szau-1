const;
tspan = 0:Tp:Tsym;

FdK_w = [Fd0-20 Fd0-10 Fd0 Fd0+10 Fd0+20]; %wektory kolejnych wartosci aktualnych punktow pracy modelu
F1inK_w = [F1in-20 F1in-10 F1in F1in+10 F1in+20];
% F1inK_w = 76;
% tau_w = 0.5 * Top: 0.25*Top : 1.5*Top;
% h1_0_w = 0 : 0.35 * h1_0 : 1.5 * h1_0;
% h2_0_w = 0.5 * h2_0 : 0.25 * h2_0 : 1.5 * h2_0;
% tau_w = Top;
% h1_0_w = h1_0;
% h2_0_w = h2_0;
length_FdK_w = length(FdK_w); %licze dlugosci wektorow, bo ptorzebne sa do automatyzacji testow modeli
length_F1inK_w = length(F1inK_w);
% length_tau_w = length(tau_w);
% length_h1_0_w = length(h1_0_w);
% length_h2_0_w = length(h2_0_w);


% %%%wersja dla jednego testu modelu
% Fd = Fdout(15, n);
% F1 = F1out(F1in, 76, Top, n, Tp); 
% [t, V] = model(tspan, y0, F1, Fd, p, q, Tp, Tsym); %tutaj powinno isc wyjscie F1out w miejsce F1in, ale to jeszcze TODO
% % [t1, V1] = modeltol(tspan, y0, F1, Fd, p, q, Tp, Tsym);
% h1 = H1(V(:, 1), Ch1);
% h2 = H2(V(:, 2), Ch2);
% 
% [t_lin, V_lin] = model_lin(tspan, y0, F1, Fd, a1, a2, a3, b1, b2, Tp, Tsym);
% 
% h1_lin = H1(V_lin(:, 1), Ch1);
% h2_lin = H2(V_lin(:, 2), Ch2);
% 
% F2 = al1 * sqrt(h1);
% F3 = al2 * sqrt(h2);
% 
% figure;
% plot(t, h1);
% figure;
% plot(t,h2);
% figure;
% plot(t, F2);
% figure;
% plot(t, F3);
% % figure;
% % hold on;
% % modelPlotter(V, V_lin, h1, h1_lin, h2, h2_lin, t, t_lin);
% % hold off;

j = 1;
FdK_akt = 0;
F1inK_akt = 0;
tau_akt = 0;
h1_0_akt = 0;
h2_0_akt = 0;

for i = 1 : length_FdK_w + length_F1inK_w %+ length_tau_w + length_h1_0_w + length_h2_0_w
    if (i <= length_FdK_w) %testujemy po zmienionym FdK
        if j > length_FdK_w
           j = 1; 
        end
        
        FdK_akt = FdK_w(j);
        F1inK_akt = F1in;
        tau_akt = Top;
        h1_0_akt = h1_0;
        h2_0_akt = h2_0;
        
    elseif (i - length_FdK_w <= length_F1inK_w) %testujemy po zmienionym F1inK
        if j > length_F1inK_w
           j = 1; 
        end
        
        FdK_akt = Fd0;
        F1inK_akt = F1inK_w(j);
        tau_akt = Top;
        h1_0_akt = h1_0;
        h2_0_akt = h2_0;
        
%     elseif (i - length_FdK_w - length_F1inK_w <= length_tau_w) %testujemy po zmienionym tau
%         if j > length_tau_w
%            j = 1; 
%         end
%         
%         FdK_akt = Fd0;
%         F1inK_akt = F1in;
%         tau_akt = tau_w(j);
%         h1_0_akt = h1_0;
%         h2_0_akt = h2_0;
        
        
%     elseif i - length_FdK_w - length_F1inK_w - length_tau_w <= length_h1_0_w %testujemy po zmienionym h1_0
%         if j > length_h1_0_w
%            j = 1; 
%         end
%         
%         FdK_akt = Fd0;
%         F1inK_akt = F1in;
%         tau_akt = Top;
%         h1_0_akt = h1_0_w(j);
%         h2_0_akt = h2_0;
        
%     elseif (i - length_FdK_w - length_F1inK_w - length_tau_w - length_h1_0_w <= length_h2_0_w) %testujemy po zmienionym h2_0
%         if j > length_h2_0_w
%            j = 1; 
%         end
%         
%         FdK_akt = Fd0;
%         F1inK_akt = F1in;
%         tau_akt = Top;
%         h1_0_akt = h1_0;
%         h2_0_akt = h2_0_w(j);
    end
    
    j = j + 1;
    
    Fd = Fdout(FdK_akt, n); %przygotowanie wektorow probek zaklocen, F1 opoznione i V0
    F1 = F1out(F1in, F1inK_akt, tau_akt, n, Tp);
    y0 = [V1(h1_0_akt, C1), V2(h2_0_akt, C2)];
    
    [t, V] = model(tspan, y0, F1, Fd, p, q, Tp, Tsym); %wyliczenie modelu nieliniowego
    h1 = H1(V(:, 1), Ch1);
    h2 = H2(V(:, 2), Ch2);
    
    F2w = F2out(al1, h1);
    
    F3w = F3out(al2, h2);
%     plot(t, F2w);
    
    [t_lin, V_lin] = model_lin(tspan, y0, F1, Fd, a1, a2, a3, b1, b2, Tp, Tsym); %wyliczenie modelu zlinearyzowanego
    h1_lin = H1(V_lin(:, 1), Ch1);
    h2_lin = H2(V_lin(:, 2), Ch2);
    
%     fh = figure('NumberTitle', 'off', 'Name', ['F1in=', num2str(F1in_akt), ', Fd=', num2str(Fd0_akt), ', tau=', num2str(tau_akt), ', h1z=', num2str(h1_0_akt), ', h2z=', num2str(h2_0_akt)]); 
    fh = figure('Name', ['F1inK=', num2str(F1inK_akt), ', FdK=', num2str(FdK_akt), ', tau=', num2str(tau_akt), ', h1z=', num2str(h1_0_akt), ', h2z=', num2str(h2_0_akt)]); 
    fh.WindowState = 'maximized';
    hold on;
    modelPlotter(V, V_lin, h1, h1_lin, h2, h2_lin, t, t_lin, F1, Fd, F2w, F3w, ['F1inK=', num2str(F1inK_akt), ', FdK=', num2str(FdK_akt)]);
    hold off;
    
end


h1_w = zeros(n+1, length_FdK_w); %wektory do przechowywania kolejnych wynikow linearyzacji
h2_w = zeros(n+1, length_FdK_w);
V1_w = zeros(n+1, length_FdK_w);
V2_w = zeros(n+1, length_FdK_w);
Fd_w = zeros(n+1, length_FdK_w);
F1_w = zeros(n+1, length_FdK_w);
j = 1;

for FdK_akt = FdK_w %zestawienie wynikow linearyzacji dla zmian skokow Fd
    Fd = Fdout(FdK_akt, n); %przygotowanie wektorow probek zaklocen, F1 opoznione i V0
    F1 = F1out(F1in, F1in, Top, n, Tp);
    y0 = [V1(h1_0, C1), V2(h2_0, C2)];
    
    [t_lin, V_lin] = model_lin(tspan, y0, F1, Fd, a1, a2, a3, b1, b2, Tp, Tsym); %wyliczenie modelu zlinearyzowanego
    h1_lin = H1(V_lin(:, 1), Ch1);
    h2_lin = H2(V_lin(:, 2), Ch2);
    
    F2w_lin = F2out(al1, h1_lin);
    
    F3w_lin = F3out(al2, h2_lin);
    
    h1_w(:, j) = h1_lin;
    h2_w(:, j) = h2_lin;
    V1_w(:, j) = V_lin(:, 1);
    V2_w(:, j) = V_lin(:, 2);
    Fd_w(:, j) = Fd;
    F1_w(:, j) = F1;
    j=j+1;
end

% figure;
fh = figure();
fh.WindowState = 'maximized';
linearPlotter(tspan, h1_w, h2_w, V1_w, V2_w, F1_w, Fd_w, 'deltaFd', 'Zestawienie zlinearyzowanych odpowiedzi skokowych Fd');



j=1;
for F1inK_akt = F1inK_w %zestawienie wynikow linearyzacji dla zmian skokow F1
    Fd = Fdout(Fd0, n); %przygotowanie wektorow probek zaklocen, F1 opoznione i V0
    F1 = F1out(F1in, F1inK_akt, Top, n, Tp);
    y0 = [V1(h1_0, C1), V2(h2_0, C2)];
    
    [t_lin, V_lin] = model_lin(tspan, y0, F1, Fd, a1, a2, a3, b1, b2, Tp, Tsym); %wyliczenie modelu zlinearyzowanego
    h1_lin = H1(V_lin(:, 1), Ch1);
    h2_lin = H2(V_lin(:, 2), Ch2);
    
    F2w_lin = F2out(al1, h1_lin);
    
    F3w_lin = F3out(al2, h2_lin);
    
    h1_w(:, j) = h1_lin;
    h2_w(:, j) = h2_lin;
    V1_w(:, j) = V_lin(:, 1);
    V2_w(:, j) = V_lin(:, 2);
    Fd_w(:, j) = Fd;
    F1_w(:, j) = F1;
    j=j+1;
end

% figure;
fh = figure();
fh.WindowState = 'maximized';
linearPlotter(tspan, h1_w, h2_w, V1_w, V2_w, F1_w, Fd_w, 'deltaF1', 'Zestawienie zlinearyzowanych odpowiedzi skokowych F1');

