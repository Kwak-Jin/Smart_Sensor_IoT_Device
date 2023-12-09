function plot_with_index( x, y, color_and_style, line_width, marker_size )
%==============================%
% Smart Sensors and IoT devices
% Creator : Jin Kwak
% Created : 2023.06.12
% Modified: 2023.06.14 
%==============================%
% Example
%    color_and_style : (Example) 'r*-' or 'b--o' or else
%    line_width      : 1 is recommended
%    marker_size     : 7 or larger is recommended
% No index datatip difficulty...

if length(x) == length(y)

    N_idx = length(x);
    array_idx = zeros(1, N_idx);
    for idx = 1:N_idx                % Making index number array 
        array_idx(idx) = idx;
    end

    % Creating variable form of plot
    PLOT_VARIABLE = plot(x, y, color_and_style, ...
                         'LineWidth', line_width, ...
                         'MarkerSize', marker_size);

    % Thicker grid lines. default value of GridAlpha = 0.15
    ax = gca;
    ax.GridAlpha = 0.4;
    grid on;

else
    % Exception Handling
    disp('ERROR : different length of x and y data')
end

end