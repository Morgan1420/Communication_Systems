function signals = mod_ask(varargin)

    % Parsegem els parèmtres per defecte
    defaultParams = struct('missatge', [0 0], 'A', 1, 'num_bits', 1, 'periodes', 5, 'f', 10000, 'min_cos_A', .5, 'f_o', 100, 'divisions_pols', 20);
    params = parse_optional_params(defaultParams, varargin{:});

    % Creem la estructura que retornarèm
    signals = struct('a', [], 'p', [], 's', [], 'S', [], 's_mod', [], 'S_mod', []);

    % ----------------------------- Codificador de linea
    
    for i= 1:length(params.missatge)
        signals.a = [signals.a (params.min_cos_A+params.A*params.missatge(i))];
    end
    
    % creem cosinus portador
    div_periode = 1000;
    t = 0:1/params.f_o/div_periode:1/params.f_o; % cosinus de 1kHz
    cos_o = cos(2*pi*params.f_o*t);

    % senyal banda base
    for i = 1:length(params.missatge)
        signals.s = [signals.s signals.a(i)*cos_o];
    end

    signals.S = transformada_fourier(signals.s);


    % senyal modulada

    % creem cosinus portador
    cos_b = cos(2*pi*params.f*t);
    cos_b_total = [];
    for i = 1:length(params.missatge)
        cos_b_total = [cos_b_total cos_b];
    end


    signals.s_mod = signals.s .* cos_b_total;
    signals.S_mod = transformada_fourier(signals.s_mod);


end