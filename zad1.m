% V1 = zeros(n, 1);
% V2 = zeros(n, 1);
% T = zeros(n, 1);
% F2 = zeros(n, 1);
% F3 = zeros(n, 1);
const;
tspan = 0:Tp:Tsym;


F1 = F1out(F1in, Top, n, Tp);
[t, V] = model(tspan, y0, F1in, Fd, p, q);
figure;
hold on;
plot(t, V(:,1));
hold off;
figure;
plot(t, V(:,2));
