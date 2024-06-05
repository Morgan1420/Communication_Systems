function signals = mod_manchester(varargin) % Senyals són a, p, s

    % Parsegem els parèmtres per defecte
    defaultParams = struct('missatge', [0 0], 'A', 1, 'divisions_pols', 10);
    params = parse_optional_params(defaultParams, varargin{:});
    
    % Creem la estructura que retornarèm
    signals = struct('a', [], 'p', [], 's', []);
    

    % ----------------------------- Codificador de linea
    % Manchester encoding: 0 -> 01, 1 -> 10
    signals.a = [];
    for bit = params.missatge
        if bit == 0
            signals.a = [signals.a params.A -params.A];
        else
            signals.a = [signals.a -params.A params.A];
        end
    end

    % ----------------------------- Conformador de polsos
    T_pols = 0:1/params.divisions_pols:1;
    signals.p = square(T_pols);

    %Creem senyal transmesa
    for i=1:length(signals.a)
        signals.s = [signals.s signals.a(i)*signals.p];
    end

    signals.S = transformada_fourier(signals.s);
end