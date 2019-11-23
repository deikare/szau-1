clear;
umin = 0;
umax = 90;
dU = 0.5;


U = umin: dU: 90;
L = [3 4 5];

fh = figure;
fh.WindowState = 'maximized';
hold on;
tiledlayout(length(L), 1);
for l = L
    nexttile;
    hold on;
    title(['dla n = ', num2str(l)]);
    set(gca, 'XTick', 0:10:180), 
%     axes('XTick', 0:10:umax);
    wektorPrzyn = funprzynwidok(U, l, umin, umax, 10);
    for i = 1: l
        plot(U, wektorPrzyn(:, i));
        xlabel('y');
        ylabel('\mu');
    end
    
    hold off;
end
hold off;

fh = figure;
fh.WindowState = 'maximized';
hold on;
tiledlayout(length(L), 1);
for l = L
    nexttile;
    hold on;
    title(['dla n = ', num2str(l)]);
    set(gca, 'XTick', 0:10:180),
    for i = 1 : l
        
%     axes('XTick', 0:10:umax);
        wektorPrzyn(:, i) = funprzyn(U, l, umin, umax, 10, i);
    end
    for i = 1: l
        plot(U, wektorPrzyn(:, i));
        xlabel('y');
        ylabel('\mu');
    end
    hold off;
end
hold off;