function signals = canal(varargin)
    % Parsegem els parèmtres per defecte
    defaultParams = struct('s', [0 0], 'divisions_pols', 10, 'delay', 1, 'W', .5);
    params = parse_optional_params(defaultParams, varargin{:});

    % Creem la estructura que retornarèm
    signals = struct('h_c', [], 'g', [], 'G', [], 'w', [], 'r', [], 'R', []);

    % canal ideal amb retard de -6
    signals.h_c = zeros(1, params.divisions_pols);
    signals.h_c(params.delay) = 1;

    signals.g = conv(params.s, signals.h_c); % Sortida del canal (sense soroll) 
    signals.G = transformada_fourier(signals.g);


    % creem un soroll 
    noise_mean = 0; % la mitjana en el cas d'un soroll seguint una distribució gausiana normal es 0
    noise_std = params.W; % Aquest valor depèn de diferents factors, nosaltres el situem a 1 per simplicitat
    signals.w  = noise_mean + noise_std * randn(size(signals.g));
    

    signals.r = signals.g + signals.w; % entrada receptor (amb soroll)
    signals.R = transformada_fourier(signals.r);

end
