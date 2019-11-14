function f1 = F1out(F1in0, F1inK, Top, n, Tp)
%funkcja realizujaca opoznienie, wystawia na wyjscie gotowy
    i = round(Top/Tp); %indeks ostatniej opoznionej probki
    f1 = zeros(n+1, 1);
    if i >= n + 1
        f1(1:n+1, 1) = F1in0;
    else
        f1(1:i, 1) = F1in0;
        f1(i+1: n+1, 1) = F1inK;
    end
end

