% V1 = zeros(n, 1);
% V2 = zeros(n, 1);
% T = zeros(n, 1);
% F2 = zeros(n, 1);
% F3 = zeros(n, 1);
const;
tspan = 0:Tp:Tsym;

FdK_w = [0.5*Fd0 0.75*Fd0 1.5*Fd0]; %wektory kolejnych wartosci aktualnych punktow pracy modelu
F1inK_w = [0.5*F1in 0.75*F1in 1.5*F1in];
% tau_w = 0.5 * Top: 0.25*Top : 1.5*Top;
% h1_0_w = 0 : 0.35 * h1_0 : 1.5 * h1_0;
% h2_0_w = 0.5 * h2_0 : 0.25 * h2_0 : 1.5 * h2_0;
tau_w = Top;
h1_0_w = h1_0;
h2_0_w = h2_0;
length_FdK_w = length(FdK_w); %licze dlugosci wektorow, bo ptorzebne sa do automatyzacji testow modeli
length_F1inK_w = length(F1inK_w);
length_tau_w = length(tau_w);
length_h1_0_w = length(h1_0_w);
length_h2_0_w = length(h2_0_w);


%%%%wersja dla jednego testu modelu
% Fd = zeros(n+1, 1) + Fd0;
% F1 = F1out(F1in, Top, n, Tp); 
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
% figure;
% hold on;
% modelPlotter(V, V_lin, h1, h1_lin, h2, h2_lin, t, t_lin);
% hold off;

j = 1;
FdK_akt = 0;
F1inK_akt = 0;
tau_akt = 0;
h1_0_akt = 0;
h2_0_akt = 0;

for i = 1 : length_FdK_w + length_F1inK_w + length_tau_w + length_h1_0_w + length_h2_0_w
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
        
    elseif (i - length_FdK_w - length_F1inK_w <= length_tau_w) %testujemy po zmienionym tau
        if j > length_tau_w
           j = 1; 
        end
        
        FdK_akt = Fd0;
        F1inK_akt = F1in;
        tau_akt = tau_w(j);
        h1_0_akt = h1_0;
        h2_0_akt = h2_0;
        
        
    elseif i - length_FdK_w - length_F1inK_w - length_tau_w <= length_h1_0_w %testujemy po zmienionym h1_0
        if j > length_h1_0_w
           j = 1; 
        end
        
        FdK_akt = Fd0;
        F1inK_akt = F1in;
        tau_akt = Top;
        h1_0_akt = h1_0_w(j);
        h2_0_akt = h2_0;
        
    elseif (i - length_FdK_w - length_F1inK_w - length_tau_w - length_h1_0_w <= length_h2_0_w) %testujemy po zmienionym h2_0
        if j > length_h2_0_w
           j = 1; 
        end
        
        FdK_akt = Fd0;
        F1inK_akt = F1in;
        tau_akt = Top;
        h1_0_akt = h1_0;
        h2_0_akt = h2_0_w(j);
    end
    
    j = j + 1;
    
    Fd = Fdout(FdK_akt, n); %przygotowanie wektorow probek zaklocen, F1 opoznione i V0
    F1 = F1out(F1in, F1inK_akt, tau_akt, n, Tp);
    y0 = [V1(h1_0_akt, C1), V2(h2_0_akt, C2)];
    
    [t, V] = model(tspan, y0, F1, Fd, p, q, Tp, Tsym); %wyliczenie modelu nieliniowego
    h1 = H1(V(:, 1), Ch1);
    h2 = H2(V(:, 2), Ch2);
    
    [t_lin, V_lin] = model_lin(tspan, y0, F1, Fd, a1, a2, a3, b1, b2, Tp, Tsym); %wyliczenie modelu zlinearyzowanego
    h1_lin = H1(V_lin(:, 1), Ch1);
    h2_lin = H2(V_lin(:, 2), Ch2);
    
%     fh = figure('NumberTitle', 'off', 'Name', ['F1in=', num2str(F1in_akt), ', Fd=', num2str(Fd0_akt), ', tau=', num2str(tau_akt), ', h1z=', num2str(h1_0_akt), ', h2z=', num2str(h2_0_akt)]); 
    fh = figure('Name', ['F1inK=', num2str(F1inK_akt), ', FdK=', num2str(FdK_akt), ', tau=', num2str(tau_akt), ', h1z=', num2str(h1_0_akt), ', h2z=', num2str(h2_0_akt)]); 
    fh.WindowState = 'maximized';
    hold on;
    modelPlotter(V, V_lin, h1, h1_lin, h2, h2_lin, t, t_lin, F1, Fd);
    hold off;
    
end

% for Fd0_act = Fd0_w
%     Fd = zeros(n+1, 1) + Fd0_act;
%     F1 = F1out(F1in, Top, n, Tp); 
%     
%     [t, V] = model(tspan, y0, F1, Fd, p, q, Tp, Tsym);
%     h1 = H1(V(:, 1), Ch1);
%     h2 = H2(V(:, 2), Ch2);
%     
%     [t_lin, V_lin] = model_lin(tspan, y0, F1, Fd, a1, a2, a3, b1, b2, Tp, Tsym);
%     h1_lin = H1(V_lin(:, 1), Ch1);
%     h2_lin = H2(V_lin(:, 2), Ch2);
%     
%     figure;
%     hold on;
%     modelPlotter(V, V_lin, h1, h1_lin, h2, h2_lin, t, t_lin);
%     hold off;
% 
% end
