function h1 = H1(V1, C)
    h1 = zeros(length(V1), 1);
    for i = 1 : length(h1)
        h1(i, 1) = C * sqrt(V1(i, 1));
    end
end

