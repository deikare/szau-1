function linearPlotter(tspan, h1_w, h2_w, V1_w, V2_w, F1_w, Fd_w, legendTitle, figureTitle)
    lay = tiledlayout(3, 2, 'TileSpacing','compact', 'Padding', 'compact');
    title(lay, figureTitle);
    nexttile;
    % hold on;
    for i = 1:size(h1_w, 2)
        stairs(tspan, h1_w(:, i));
        hold on;
    end
    lgd = legend({'-20', '-10', '0', '10', '20'}, 'Location', 'Southeast');
    title(lgd, legendTitle);
    title('h1');
    ylabel('h1(t)');
    xlabel('t');
    hold off;

    nexttile;
    % hold on;
    for i = 1:size(h2_w, 2)
        stairs(tspan, h2_w(:, i));
        hold on;
    end
    lgd = legend({'-20', '-10', '0', '10', '20'}, 'Location', 'Southeast');
    title(lgd, legendTitle);
    title('h2');
    ylabel('h2(t)');
    xlabel('t');
    hold off;

    nexttile;
    % hold on;
    for i = 1:size(V1_w, 2)
        stairs(tspan, V1_w(:, i));
        hold on;
    end
    lgd = legend({'-20', '-10', '0', '10', '20'}, 'Location', 'Southeast');
    title(lgd, legendTitle);
    title('V1');
    ylabel('V1(t)');
    xlabel('t');
    hold off;

    nexttile;
    % hold on;
    for i = 1:size(V2_w, 2)
        stairs(tspan, V2_w(:, i));
        hold on;
    end
    lgd = legend({'-20', '-10', '0', '10', '20'}, 'Location', 'Southeast');
    title(lgd, legendTitle);
    title('V2');
    ylabel('V2(t)');
    xlabel('t');
    ylabel('V2(t)');
    xlabel('t');
    hold off;

    nexttile;
    % hold on;
    for i = 1:size(F1_w, 2)
        stairs(tspan, F1_w(:, i));
        hold on;
    end
    lgd = legend({'-20', '-10', '0', '10', '20'}, 'Location', 'Southeast');
    title(lgd, legendTitle);
    title('F1');
    ylabel('dop³yw');
    xlabel('t');
    hold off;

    nexttile;
    % hold on;
    for i = 1:size(Fd_w, 2)
        stairs(tspan, Fd_w(:, i));
        hold on;
    end
    lgd = legend({'-20', '-10', '0', '10', '20'}, 'Location', 'Southeast');
    title(lgd, legendTitle);
    title('Fd');
    ylabel('dop³yw');
    xlabel('t');
    hold off;

    % hold off;
end

