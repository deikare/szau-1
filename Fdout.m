function fd = Fdout(FdK, n)
    fd = zeros(n+1, 1);
    fd(1:n+1, 1)= FdK;
end

