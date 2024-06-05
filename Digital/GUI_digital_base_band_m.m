clc;
close all;
addpath('Digital/Moduladors_bb');
addpath('Digital/Demoduladors_bb');
addpath('_generic_functions');

% Fem una llista d'opcions per a que l'usuari pugui escollir les diferents modulacions
opcions = ["Bipolar NRZ", "Unipolar NRZ", "Bipolar RZ", "Unipolar RZ", "Manchester"];
opcio = menu("Escull la modulació", opcions);

% Demanem a l'usuari l'amplitud de la senyal
A = input("Introdueix l'amplitud de la senyal (Enter per defecte): ");
if isempty(A)
    A = 2;
end

% Demanem a l'usuari el soroll
W = input("Introdueix la variança de la senyal del soroll (Enter per defecte): ");
if isempty(W)
    W = .5;
end

div = 20; % intentem que sigui superior a la meitat del delay del canal ja que els receptors accionen en div/2

% Demanem a l'usuari el missatge a transmetre
missatge_s = input("Introdueix el missatge a transmetre (Enter per defecte): ", 's');
disp("Missatge introduit: " + missatge_s)
if isempty(missatge_s)
    % Molt important que el missatge sigui un string amb cometes simples
    missatge_s = 'Aleix Jorda Banus i Jan Moran Ricardo';
end

% Convertim el missatge a un array de bits
missatge = ascii_to_binary_array(missatge_s);


DMM = 10; % DM = Divisions del Missatge a Mostrar
plot_signal(signal_1=missatge, figure_num=1, title_1='Missage original', axis=[ 0 DMM -1.25 1.25], discreete=true, num_plots=1);

switch opcio
    case 1 % Bipolar NRZ
        % MODULADOR
        signals_mod = mod_bipolar_nrz(missatge=missatge, A=A, divisions_pols=div);
        % CANAL
        signals_ch = canal(s=signals_mod.s,divisions_pols=div, W=W);
        % RECEPTOR
        signals_dem = demod_bipolar_nrz(r=signals_ch.r, divisions_pols=div);
    case 2 % Unipolar NRZ
        % MODULADOR
        signals_mod = mod_unipolar_nrz(missatge=missatge, A=A, divisions_pols=div);
        % CANAL
        signals_ch = canal(s=signals_mod.s,divisions_pols=div, W=W);
        % RECEPTOR
        signals_dem = demod_unipolar_nrz(r=signals_ch.r, divisions_pols=div);
    case 3 % Bipolar RZ
        % MODULADOR
        signals_mod = mod_bipolar_rz(missatge=missatge, A=A, divisions_pols=div);
        % CANAL
        signals_ch = canal(s=signals_mod.s,divisions_pols=div, W=W);
        % RECEPTOR
        signals_dem = demod_bipolar_rz(r=signals_ch.r, divisions_pols=div);
    case 4 % Unipolar RZ
        % MODULADOR
        signals_mod = mod_unipolar_rz(missatge=missatge, A=A, divisions_pols=div);
        % CANAL
        signals_ch = canal(s=signals_mod.s,divisions_pols=div, W=W);
        % RECEPTOR
        signals_dem = demod_unipolar_rz(r=signals_ch.r, divisions_pols=div);
    case 5 % Manchester
        % MODULADOR
        signals_mod = mod_manchester(missatge=missatge, A=A, divisions_pols=div);
        % CANAL
        signals_ch = canal(s=signals_mod.s,divisions_pols=div, W=W);
        % RECEPTOR
        signals_dem = demod_manchester(r=signals_ch.r, divisions_pols=div);
    otherwise
        disp("Opció no implementada")
        return 
end



% -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ Modulador
% --------- Ploting senyals del modulador

plot_signal(signal_1=signals_mod.a, title_1='a(t) Bipolar', axis=[ 0 DMM (-A - .25) (A + .25)], discreete=true);
plot_signal(signal_1=signals_mod.p, title_1='p(t)', axis=[ 0 (div + 1) (-A - .25) (A + .25)], discreete=true);
plot_signal(signal_1=signals_mod.s, signal_2=signals_mod.S, title_1='s(t)', title_2='S(f)', axis=[ 0 (div * DMM) (-A - .25) (A + .25)]);


% -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ Canal
% --------- Ploting senyals del canal
plot_signal(signal_1=signals_ch.h_c, figure_num=5, title_1='h_c(t)', axis=[ 0 (div + 1) -1.25 1.25], discreete=true, num_plots=1);
plot_signal(signal_1=signals_ch.g, signal_2=signals_ch.G, figure_num=6, title_1='r_c(t)', title_2='R_c(f)', axis=[ 0 (div * DMM) (-A -W - .25) (A +W + .25)]);
plot_signal(signal_1=signals_ch.w, figure_num=7, title_1='w(t)', axis=[ 0 (div * DMM) (-W - .25) (W + .25)], num_plots=1);
plot_signal(signal_1=signals_ch.r, signal_2=signals_ch.R, figure_num=8, title_1='r(t)', title_2='R(f)', axis=[ 0 (div * DMM) (-A- .25) (A + W + .25)]);


% -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ Receptor
% --------- Ploting senyals del receptor
plot_signal(signal_1=signals_dem.y, signal_2=signals_dem.Y, figure_num=9, title_1='y(t)', title_2='Y(f)', axis=[ 0 (div * DMM) (-A- .25) (A + W + .25)]);
plot_signal(signal_1=signals_dem.y_KT, figure_num=10, title_1='y(kT)', axis=[ 0 (div * DMM) (-A- .25) (A + W + .25)], discreete=true, num_plots=1);
plot_signal(signal_1=signals_dem.a_KT, figure_num=11, title_1='â(t)', axis=[ 0 (div * DMM) (-A- .25) (A +  .25)], discreete=true, num_plots=1);
plot_signal(signal_1=missatge, signal_2=signals_dem.b_r, figure_num=12, title_1='missatge enviat', title_2='missatge rebut', axis=[ 0 (div * DMM) (-A- .25) (A +  .25)], discreete=true);

% -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ Resultats
disp("Missatge original: " + binary_array_to_ascii(missatge));
disp("Missatge rebut: " + binary_array_to_ascii(signals_dem.b_r));
% Comparar el missatge rebut amb el missatge original
if isequal(binary_array_to_ascii(missatge), binary_array_to_ascii(signals_dem.b_r))
    disp("Missatge rebut correctament");
else
    disp("Missatge rebut incorrectament");
    disp("");
    % BER (Bit Error Rate)
    disp("Length missatge (binary array): " + length(missatge))
    disp("Number of missmatches: " + missatges_missmatch(missatge, signals_dem.b_r))
    % Error a lectura de caràcters
    disp("Length missatge (ascii): " + length(binary_array_to_ascii(missatge)) + " caràcters")
    disp("Number of characters missmatches: " + missatges_missmatch(binary_array_to_ascii(missatge), binary_array_to_ascii(signals_dem.b_r)))

end