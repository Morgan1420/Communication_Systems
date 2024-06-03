function signals = mod_ask(varargin)

    % Parsegem els parèmtres per defecte
    defaultParams = struct('missatge', [0 0], 'A', 1, 'num_bits', 1, 'periodes', 5, 'f', 1, 'min_cos_A', .5);
    params = parse_optional_params(defaultParams, varargin{:});

    % Creem la estructura que retornarèm
    signals = struct('a', [], 's', [], 'S', []);

    % ----------------------------- Codificador de linea
    
    for i= 1:length(params.missatge)
        signals.a = [signals.a (params.min_cos_A+params.A*params.missatge(i))];
    end
    
    
    % Fer senyal sinusoidal
    % sinus = sin(...) % tants pariodes com es passi per paràmetre
    % t = 0:0.0001:1; 
    t = 0:1/params.f/100:params.periodes/params.f;
    cosinus = cos(2*pi*params.f*t);
    for i = 1:length(signals.a)
        signals.s = [signals.s signals.a(i)*cosinus]; 
    end

    signals.S = transformada_fourier(signals.s);

end