function h2 = H2(V2, C)
    h2 = zeros(length(V2), 1);
    for i = 1 : length(h2)
        h2(i, 1) = C * nthroot(V1(i, 1), 3);
    end
end

