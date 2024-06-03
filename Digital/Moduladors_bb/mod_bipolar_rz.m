function signals = mod_bipolar_rz(varargin) % Senyals són a, p, s

    % Parsegem els parèmtres per defecte
    defaultParams = struct('missatge', [0 0], 'A', 1, 'divisions_pols', 10);
    params = parse_optional_params(defaultParams, varargin{:});
    
    % Creem la estructura que retornarèm
    signals = struct('a', [], 'p', [], 's', [], 'S', []);
    

    % ----------------------------- Codificador de linea
    % Dupliquem el missatge i posem un zero entre cada bit
    signals.a = 2*params.A*params.missatge-params.A;
    signals.a = reshape([signals.a; zeros(1, length(signals.a))], 1, 2*length(signals.a));

    % ----------------------------- Conformador de polsos
    T_pols = 0:1/params.divisions_pols:1;
    signals.p = square(T_pols);

    %Creem senyal transmesa
    for i=1:length(signals.a)
        signals.s = [signals.s signals.a(i)*signals.p];
    end

    signals.S = transformada_fourier(signals.s);

end