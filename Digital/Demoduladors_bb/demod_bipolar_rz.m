function signals = demod_bipolar_rz(varargin)
    % Parsegem els parèmtres per defecte
    defaultParams = struct('r', [0 0], 'divisions_pols', 10, 'llista_valors', [1 -1]);
    params = parse_optional_params(defaultParams, varargin{:});

    % Creem la estructura que retornarèm
    signals = struct('h_r', [], 'y', [], 'Y', [], 'y_KT', [], 'Y_KT', [], 'a_KT', [], 'b_r', []);

    % ----------------------------- Filtre receptor
    signals.h_r = zeros(1, params.divisions_pols);
    signals.h_r(1) = 1;

    % ----------------------------- Senyal rebuda
    signals.y = conv(params.r,signals.h_r);
    signals.Y = transformada_fourier(signals.y);

    % ----------------------------- Dades rebudes
    signals.y_KT = [];
    for i = (params.divisions_pols/2):params.divisions_pols+1:length(signals.y)
        signals.y_KT = [signals.y_KT signals.y(i)];
    end

    % ----------------------------- Detector de nivell
    signals.a_KT = [];
    for i = 1:length(signals.y_KT)
        signals.a_KT = [signals.a_KT find_closest_value(params.llista_valors, signals.y_KT(i))];
    end

    % ----------------------------- Decodificador de linea
    signals.b_r = back_to_binary_bipolar(signals.a_KT);

    % ----------------------------- Funcions extra
    function missatge = back_to_binary_bipolar(a)
        missatge = [];
        for j = 1:length(a)
            if a(j) > 0
                missatge = [missatge 1];
            else
                missatge = [missatge 0];
            end
        end 
    end

    % ----------------------------- Remove the zeros inserted during modulation
    signals.b_r = signals.b_r(1:2:end);
end