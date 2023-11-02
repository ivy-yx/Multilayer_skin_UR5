x = [16.1, 4.4, 7.3, 6.7];
y = [15.5, 4.4, 12.6, 11.7];
data = [x; y];
figure;
b = bar(data,0.8); 

bar_colors = [
    0.2 0.4 0.6; 
    0.8 0.2 0.4; 
    0.4 0.6 0.2; 
    0.6 0.2 0.8];
colormap(bar_colors);

ylabel('Mean Absolute Error (mm)');
legend('Single-layer circular shape', 'Multi-layer circular shape', 'Multi-layer rectangular shape', 'Multi-layer irregular shape');
xticks(1:2);
xticklabels({'x-axes', 'y-axes'}); 


