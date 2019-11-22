function h2 = h2statlin(F1, Fd, F1_lin, alfa2)
    n = length(F1);
    h2 = zeros(n, 1);
    for i = 1 : n
        h2(i, 1) = (power(F1_lin, 2) + 2 * Fd(i, 1) * F1_lin + power(Fd(i, 1), 2) + (2 * F1_lin + 2*Fd(i, 1)) * (F1(i, 1) - F1_lin)) * (power(alfa2, -2));
    end
end

