function params = parse_optional_params(defaultParams, varargin)
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