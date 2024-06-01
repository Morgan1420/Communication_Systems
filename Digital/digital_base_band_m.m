clc;
close all;

% Missatge a transmetre
missatge = [0 1 0 0 0 0 0 1 0 1 1 0 1 1 0 0 0 1 1 0 0 1 0 1 0 1 1 0 1 0 0 1 0 1 1 1 1 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 1 0 1 0 0 1 1 0 1 1 1 1 0 1 1 1 0 0 1 0 0 1 1 0 0 1 0 0 0 1 1 0 0 0 0 1 0 0 1 0 0 0 0 0 0 1 0 0 0  0 1 0 0 1 1 0 0 0 0 1 0 1 1 0 1 1 1 0 0 1 1 1 0 1 0 1 0 1 1 1 0 0 1 1 0 0 1 0 0 0 0 0 0 1 1 0 1 0 0 1 0 0 1 0 0 0 0 0 0 1 0 0 1 0 1 0 0 1 1 0 0 0 0 1 0 1 1 0 1 1 1 0 0 0 1 0 0 0 0 0 0 1 0 0 1 1 0 1 0 1 1 0 1 1 1 1 0 1 1 1 0 0 1 0 0 1 1 0 0 0 0 1 0 1 1 0 1 1 1 0 0 0 1 0 0 0 0 0 0 1 0 1 0 0 1 0 0 1 1 0 1 0 0 1 0 1 1 0 0 0 1 1 0 1 1 0 0 0 0 1 0 1 1 1 0 0 1 0 0 1 1 0 0 1 0 0 0 1 1 0 1 1 1 1];
plot_signal(missatge, 1, title='Missage original');


% ------------------------------------------------- Modulador

% --------- Codificador de linea: dona l'amplitut correcte al senyal del missatge

A = 2; % Amplitut del missatge 

a=2*A*missatge-A; % Bipolar: Valors A o -A 


plot_signal(a, 2, title='a(t) Bipolar', axis=[ 0 10 (-A - .25) (A + .25)]);

% --------- Conformador de polsos

f_m = 10000;
T_m = 1/f_m;
div = 20; % nombre de divisions del pols

T_pols = 0:T_m/div:T_m;
p = square(T_pols);


s = [];

for i=1:length(a)
    s = [s a(i)*p];
end
   
figure(3)
plot(s), grid on;
title('s(t)');
axis([ 0 div*10 -1.25 1.25]);


function plot_signal(signal, figure_num, varargin) % Input args: signal, figure number, plot title,     
    
    % Definim els paràmtres per defecte
    defaultParams = struct('title', 'Plot', 'axis', [ 0 10 -1.25 1.25]);
    
    % Parsegem els parèmtres per defecte
    params = parseOptionalParams(defaultParams, varargin{:});
    
    % Mostrem els missatge original
    figure(figure_num);
    stem(signal), grid on;
    title(params.text);
    axis(params.axis);
end


function params = parseOptionalParams(defaultParams, varargin)
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