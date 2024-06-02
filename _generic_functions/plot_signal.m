function plot_signal(varargin) % Input args: signal, figure number, plot title,     
    
    % Definim els paràmtres per defecte
    defaultParams = struct('figure_num', 1, 'signal_1', [0 0], 'signal_2', [0 0], 'title_1', 'Plot_t', 'title_2', 'Plot_f', 'axis', 0, 'discreete', false, 'num_plots', 2);
    
    % Parsegem els parèmtres per defecte
    params = parse_optional_params(defaultParams, varargin{:});
    
    % Mostrem els missatge original
    figure(params.figure_num);
    if params.num_plots == 1
        if params.discreete == false
            plot(params.signal_1), grid on;
        else
            stem(params.signal_1), grid on;
        end
        title(params.title_1);
        axis(params.axis);
    else
        subplot(params.num_plots,1,1);
        if params.discreete == false
            plot(params.signal_1), grid on;
        else
            stem(params.signal_1), grid on;
        end
        title(params.title_1);
        axis(params.axis);

        subplot(params.num_plots,1,2);
        if params.discreete == false
            plot(params.signal_2), grid on;
        else
            stem(params.signal_2), grid on;
        end
        title(params.title_2);
    end


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