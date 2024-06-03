function singnals = demod_ask()
    % Parsegem els parèmtres per defecte
    defaultParams = struct('missatge', [0 0], 'A', 1, 'num_bits', 1, 'periodes_sin', 5);
    params = parse_optional_params(defaultParams, varargin{:});

    % Creem la estructura que retornarèm
    signals = struct('h_r', [], 'y', [], 'Y', [], 'y_KT', [], 'Y_KT', [], 'a_KT', [], 'b_r', []);


end
