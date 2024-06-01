function plot_signal(signal, figure_num, varargin) % Input args: signal, figure number, plot title,     
    
    % Definim els paràmtres per defecte
    defaultParams = struct('title', 'Plot', 'axis', 0, 'discreete', false);
    
    % Parsegem els parèmtres per defecte
    params = parseOptionalParams(defaultParams, varargin{:});
    
    % Mostrem els missatge original
    figure(figure_num);
    if params.discreete == false
        plot(signal), grid on;
    else
        stem(signal), grid on;
    end
    title(params.title);
    axis(params.axis);

    function params = parseOptionalParams(defaultParams, varargin)
        % Create an input parser
        p = inputParser;

        % Add each field in the defaultParams struct as a parameter
        paramNames = fieldnames(defaultParams);
        for i = 1:length(paramNames)
            addParameter(p, paramNames{i}, defaultParams.(paramNames{i}));
        end

        % Parse input arguments
        parse(p, varargin{:});

        % Return the parameters as a struct
        params = p.Results;
    end
end