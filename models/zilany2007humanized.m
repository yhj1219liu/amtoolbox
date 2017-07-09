function [ANdata,vFreq] = zilany2007humanized(stim_level,stim,fsstim,fsmod,varargin)
% ZILANY2007HUMANIZED  Humanized auditory nerve model
%   Usage: [ANdata,vFreq] = zilany2007humanized(lvl,stim,fsstim,fsmod);
%
%   Input parameters:
%     stim_level  : Level of stimulus in peSPL
%     stim        : Pressure waveform of stimulus (timeseries)
%     fsstim      : Sampling frequency of stimulus  
%     fsmod       : Model sampling frequency (often 200kHz)
%
%   Output parameters:
%     ANdata     : AN exicitation in 500 different AN fibers spaced equally
%                   on the BM
%     vFreq      : Frequency vector containing the 500 center frequencies
%
%   `zilany2007humanized(stim_lvl, stim, fsstim, fsmod)` returns simulations
%   from Rønne et al. (2012). It calls the mex'ed C code containing the
%   humanized version of Zilany et al. (2007)'s AN model. The humanization
%   is described in Rønne et al. (2012). The AN model is called 500 times to
%   simulate 500 fibers tuned to different center frequencies.
%
%   Please cite Rønne et al (2012) and Zilany and Bruce (2007) if you use
%   this model.
%
%   This function takes the following optional parameters:
%
%     'flow',flow     Lowest centre frequency. Default value is 100.
%
%     'fhigh',fhigh   Highest centre frequency. Default value is 16000.
%
%     'nfibers',nf    Number of fibers between lowest and highest
%                     frequency. The fibers will be equidistantly spaced
%                     on the basilar membrane. Default value is 500.
%  
%   Requirements and installation:
%   ------------------------------
%
%   1) Compiled mex files (run `amt_mex`)
%   
%   References: roenne2012modeling zilany2007representation

if nargin<4
  error('%s: Too few input parameters.',upper(mfilename));
end;

% Define input flags
definput.keyvals.flow    = 100;
definput.keyvals.fhigh   = 16000;
definput.keyvals.nfibers = 500;
[flags,kv]  = ltfatarghelper({'flow','fhigh','nfibers'},definput,varargin);

stim	= resample(stim,fsmod,fsstim);	% stim fs = mod fs
idnz	= stim ~= 0;                    % ignore pauses
lvlref = 20*log10(1/20e-6);           % Reference level: 20 micro Pa
stim(idnz) = setdbspl(stim(idnz),stim_level,'dboffset',lvlref); % Calibrate level

% stim must be a row vector
if size(stim,2) == 1
    stim = stim';
end

% location of lowest and highest centre frequency
xlo     = (1.0/0.06)*log10((kv.flow/165.4)+0.88);
xhi     = (1.0/0.06)*log10((kv.fhigh/165.4)+0.88);	

% equal spaced distances on the BM
vX      = linspace(xlo,xhi,kv.nfibers);

% and the resulting frequency vector
vFreq   = 165.4*(10.^(0.06*vX)-0.88); 

% resolution in the time domain
tdres   = 1/fsmod;                

% spontaneous rate in sp/sec
spont   = 50;    

% time in sec between stimulus repetitions - NOTE should be equal to or
% longer than the duration of the stimulus
reptime   = (2*length(stim)+1)/fsmod; 

% cohc is the ohc scaling factor: 1 is normal OHC function; 0 is complete
% OHC dysfunction
cohc    = 1;                                        

% cihc is the ihc scaling factor: 1 is normal IHC function; 0 is complete
% IHC dysfunction
cihc    = 1;                                        

% Call AN model - loop over the 500 fibers tuned to different CFs
for jj = 1:kv.nfibers
  % Call AN model (mex'ed C model)
  [timeout,meout,c1filterout,c2filterout,c1vihc,c2vihc,vihc,synout,psth500k] ...
      = comp_zilany2007humanized(stim,...
                                 vFreq(jj),...
                                 1,...
                                 tdres,...
                                 reptime,...
                                 cohc, ...
                                 cihc,...
                                 spont); 
  
  % Use the output of the synapse stage of the AN model. 
  ANdata(jj,:)           = synout;             
end