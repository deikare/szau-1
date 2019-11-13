% V1 = zeros(n, 1);
% V2 = zeros(n, 1);
% T = zeros(n, 1);
% F2 = zeros(n, 1);
% F3 = zeros(n, 1);
const;
tspan = 0:Tp:Tsym;
Fd = zeros(n+1, 1) + Fd0;


F1 = F1out(F1in, Top, n, Tp); 
[t, V] = model(tspan, y0, F1, Fd, p, q, Tp, Tsym); %tutaj powinno isc wyjscie F1out w miejsce F1in, ale to jeszcze TODO
% [t1, V1] = modeltol(tspan, y0, F1, Fd, p, q, Tp, Tsym);
h1 = H1(V(:, 1), Ch1);
h2 = H2(V(:, 2), Ch2);

[t_lin, V_lin] = model_lin(tspan, y0, F1, Fd, a1, a2, a3, b1, b2, Tp, Tsym);

% h1_tol = H1(V1(:, 1), Ch1);
% h2_tol = H2(V1(:, 2), Ch2);

h1_lin = H1(V_lin(:, 1), Ch1);
h2_lin = H2(V_lin(:, 2), Ch2);

figure;
stairs(t, h1);
% stairs(t, V(:, 1));
hold on;
% stairs(t_lin, V_lin(:, 1));
stairs(t_lin, h1_lin);
hold off;

figure;
stairs(t, h2);
% stairs(t, V(:, 2));
hold on;
% stairs(t_lin, V_lin(:, 2));
stairs(t_lin, h2_lin);
hold off;