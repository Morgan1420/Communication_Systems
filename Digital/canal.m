function signals = canal(varargin)

    % Parsegem els parèmtres per defecte
    defaultParams = struct('s', [0 0], 'divisions_pols', 10, 'delay', 1);
    params = parse_optional_params(defaultParams, varargin{:});

    % Creem la estructura que retornarèm
    signals = struct('h_c', [], 'g', [], 'G', [], 'w', [], 'r', [], 'R', []);

    % canal ideal amb retard de -6
    signals.h_c = zeros(1, params.divisions_pols);
    signals.h_c(params.delay) = 1;

    signals.g = conv(params.s, signals.h_c); % Sortida del canal (sense soroll) 
    signals.G = transformada_fourier(signals.g);

    W = .5; % Amplitut del soroll
    signals.w = W*rand(1,length(signals.g));

    signals.r = signals.g + signals.w; % entrada receptor (amb soroll)
    signals.R = transformada_fourier(signals.r);

end
