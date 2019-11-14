function h2 = H2(V2, C)
    h2 = zeros(length(V2), 1);
    for i = 1 : length(h2)
        h2(i, 1) = C * sqrt(V2(i, 1));
    end
end

