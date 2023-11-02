% single-layer
[xq_s, yq_s] = meshgrid(linspace(min(t(1,:)), max(t(1,:)), 200), linspace(min(t(2,:)), max(t(2,:)), 200));
errors_interp_s = griddata(t(1,:), t(2,:), mean(abs(y-t)), xq_s, yq_s);

% multi-layer Circle
[xq_c, yq_c] = meshgrid(linspace(min(t_c(1,:)), max(t_c(1,:)), 200), linspace(min(t_c(2,:)), max(t_c(2,:)), 200));
errors_interp_c = griddata(t_c(1,:), t_c(2,:), mean(abs(y_c-t_c)), xq_c, yq_c);


caxis_min_s = min(errors_interp_s(:));
caxis_max_s = max(errors_interp_s(:));

caxis_min_c = min(errors_interp_c(:));
caxis_max_c = max(errors_interp_c(:));


caxis_min = min([caxis_min_s, caxis_min_c]);
caxis_max = max([caxis_max_s, caxis_max_c]);

figure;
subplot(1, 2, 1);
contourf(xq_s, yq_s, errors_interp_s, 20, 'LineStyle', 'none');
title('single');
colorbar;
caxis([caxis_min, caxis_max]);

subplot(1, 2, 2);
contourf(xq_c, yq_c, errors_interp_c, 20, 'LineStyle', 'none');
title('cir');
colorbar;
caxis([caxis_min, caxis_max]);


