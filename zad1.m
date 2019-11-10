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

h1 = H1(V(:, 1), Ch1);
h2 = H2(V(:, 2), Ch2);

figure;
hold on;
stairs(t, h1);
hold off;
figure;
stairs(t, h2);
