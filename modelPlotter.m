function modelPlotter(V, V_lin, h1, h1_lin, h2, h2_lin, t, t_lin, F1, Fd)
    tiledlayout(3, 2, 'TileSpacing','compact', 'Padding', 'compact');

    nexttile;
    stairs(t, h1);
    hold on;
    stairs(t_lin, h1_lin);
    title('h1');
    ylabel('h1(t)');
    xlabel('t');
    legend({'nieliniowy', 'zlinearyzowany'}, 'Location', 'Southeast');
    hold off;

    nexttile;
    stairs(t, h2);
    hold on;
    stairs(t_lin, h2_lin);
    title('h2');
    ylabel('h2(t)');
    xlabel('t');
    legend({'nieliniowy', 'zlinearyzowany'}, 'Location', 'Southeast');
    hold off;

    nexttile;
    stairs(t, V(:, 1));
    hold on;
    stairs(t_lin, V_lin(:, 1));
    title('V1');
    ylabel('V1(t)');
    xlabel('t');
    legend({'nieliniowy', 'zlinearyzowany'}, 'Location', 'Southeast');
    hold off;

    nexttile;
    stairs(t, V(:, 2));
    hold on;
    stairs(t_lin, V_lin(:, 2));
    title('V2');
    ylabel('V2(t)');
    xlabel('t');
    legend({'nieliniowy', 'zlinearyzowany'}, 'Location', 'Southeast');
    hold off;
    
%     nexttile;
%     stairs(t, F1);
%     hold on;
%     stairs(t, Fd);
%     title('F1 i Fd');
%     ylabel('dop³yw');
%     xlabel('t');
%     legend({'F1', 'Fd'}, 'Location', 'Southeast');
%     hold off;

    nexttile;
    stairs(t, F1);
    hold on;
%     stairs(t, Fd);
    title('F1');
    ylabel('dop³yw');
    xlabel('t');
    hold off;
    
    nexttile;
%     stairs(t, F1);
    stairs(t, Fd);
    hold on;
    title('Fd');
    ylabel('dop³yw');
    xlabel('t');
    hold off;
end

