function signals = mod_bipolar_nrz(varargin) % Senyals són a, p, s

    % Parsegem els parèmtres per defecte
    defaultParams = struct('missatge', [0 0], 'A', 1, 'divisions_pols', 10);
    params = parse_optional_params(defaultParams, varargin{:});
    
    % Creem la estructura que retornarèm
    signals = struct('a', [], 'p', [], 's', [], 'S', []);
    

    % ----------------------------- Codificador de linea
    signals.a = 2*params.A*params.missatge-params.A;

    % ----------------------------- Conformador de polsos
    T_pols = 0:1/params.divisions_pols:1;
    signals.p = square(T_pols);

    %Creem senyal transmesa
    for i=1:length(signals.a)
        signals.s = [signals.s signals.a(i)*signals.p];
    end

    signals.S = transformada_fourier(signals.s);

end