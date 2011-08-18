% This example creates a 4th order gammatone filter with a center
% frequency of 1000Hz and a 3dB-bandwidth of 100Hz, suitable for 
% input signals with a sampling frequency of 10kHz.              
%
% copyright: Universitaet Oldenburg
% author   : tp
% date     : Jan, Mar 2002, Nov 2006

disp('This example creates a 4th order gammatone filter with a center');
disp('frequency of 1000Hz and a 3dB-bandwidth of 100Hz, suitable for ');
disp('input signals with a sampling frequency of 10kHz.              ');


%%% create the example filter: %%%

center_frequency_hz   =  1000;
bandwidth_hz          =   100;
attenuation_db        =     3;
sampling_frequency_hz = 10000;
filter_order          =     4;

filter = Gfb_Filter_new(sampling_frequency_hz, center_frequency_hz, ...
                        bandwidth_hz, attenuation_db, filter_order);

%%% print the filter's parameters to the screen %%%

disp(' ');
disp(['The filter coefficient of this filter is: ', ...
      num2str(real(filter.coefficient)),            ...
      ' + ',                                        ...
      num2str(imag(filter.coefficient))]);
disp(['Its normalization factor is             : ', ...
      num2str(filter.normalization_factor)]);


%%% plot the impulse response and the frequency response of this filter: %%%
impulse_samples            = 8192;
impulse_response_samples   =  200;
impulse                    = [1, zeros(1,impulse_samples - 1)];

[impulse_response, filter] = Gfb_Filter_process(filter, impulse);

figure(1);
plot([0:impulse_response_samples-1], ...
         [real(impulse_response(1:impulse_response_samples)); ...
          imag(impulse_response(1:impulse_response_samples)); ...
          abs(impulse_response(1:impulse_response_samples))]);
axis([0,impulse_response_samples, -0.035,0.035]);
title('impulse response of example gammatone filter');
xlabel('sample number');
ylabel('filter output');


%%% plot the frequency response of this filter: %%%

frequency_response = abs(fft(real(impulse_response.')));
figure(2);
plot([0:(impulse_samples - 1)] *                     ...
     (sampling_frequency_hz / impulse_samples),       ...
     20 * log10(frequency_response));
axis([0,1500, -40,0]);
title('frequency response of example gammatone filter');
xlabel('frequency / Hz');
ylabel('filter response / dB');

disp(' ');
disp(['Figure 1 shows the first ',num2str(impulse_response_samples)]);
disp('samples of the impulse response of this gammatone filter.    ');
disp('Real part, imaginary part, and absolute value of the impulse ');
disp('response are plotted as lines 1, 2, and 3, respectively.     ');
disp(' ');
disp('Figure 2 shows the frequency response function of this filter');
disp('in dB over frequency in Hz.');
