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
h2_lin = (H2zlin(V_lin(:, 2), Ch2, V2_lin)  - h1_0) / 20 + h1_0;

figure;
% stairs(t, h1_lin);
% hold on;
stairs(t, h2_lin);
% hold off;


% D = round(440/Tp);
D = 5;
s = h2_lin(1:D);
Nu = 5;
N = 5;
fi = 5;
lam = 0.3;
Fi = diag(zeros(1, N) + fi);
Lambda = diag(zeros(1, Nu) + lam);
disp(Fi);
disp(Lambda);
M = zeros(N, Nu);
k = 1;
for j = 1 : Nu
    M(k:N, j) = s(1 : N - k + 1);
    k = k+1;
end

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

K = ((M') * Fi * M + Lambda) \ ((M') * Fi);
ke = 0;
for i = 1 : N
    ke = ke + K(1, i);
end
ku = K(1, :) * Mp;
for t = tspan
    %%TODO - wystarczy ze dostane wyjscie staerowania - trzeba dodac
    %%opoznienie pluc liczyc wszystko elegancko, nie wiem jeszcze jak
    %%opozniac, moze jakis rejestr przesuwny
    %%mozna wykorzystac nawet model_lin.m, ale trzeba dobrze wtedy podawac
    %%sterowanie (F1in)

end
