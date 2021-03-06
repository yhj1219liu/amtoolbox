function [gp,gfc] = baumgartner2016_gradientextraction(mp,fc,varargin)
%baumgartner2016_gradientextraction - Extraction of positive spectral gradients
%   Usage:      [gp,gfc] = baumgartner2016_gradientextraction(mp,fc)
%
%   Input parameters:
%     mp      : discharge rate profile
%     fc      : center frequencies
%
%   Output parameters:
%     gp      : positive spectral gradient profile. Fields: gp.m for
%               magnitude and gp.sd for standard deviation. 
%               Dimensions (4-6 optional): 
%               1) frequency, 2) position (polar angle), 3) channel (L/R), 
%               4) fiber type, 5) time frame.
%     gfc     : center frequencies of gradient profile
%
%   `baumgartner2016_gradientextraction(...)` is a spectral cue extractor
%    inspired by functionality of dorsal cochlear nucleus in cats.
%
%   References: baumgartner2014modeling

% AUTHOR: Robert Baumgartner

definput.import={'baumgartner2016'};
definput.keyvals.c2 = 1;
[flags,kv]=ltfatarghelper({'c2'},definput,varargin);


%% Parameter Settings
c2 = kv.c2; % inhibitory coupling between type II mpd type IV neurons
c4 = 1; % coupling between AN and type IV neuron
dilatation = 1; % of tonotopical 1-ERB-spacing between type IV mpd II neurons

erb = audfiltbw(fc);

%% Calculations
Nb = size(mp,1); % # auditory bands
dgpt2 = round(mean(erb(2:end)./diff(fc))*dilatation); % tonotopical distance between type IV mpd II neurons
mpsd = 2.6 * mp.^0.34; % variability of discharge rate (May and Huang, 1997)
gp.m = zeros(Nb-dgpt2,size(mp,2),size(mp,3),size(mp,4),size(mp,5)); % type IV output
gp.sd = gp.m;
for b = 1:Nb-dgpt2
  gp.m(b,:,:,:,:) = c4 * mp(b+dgpt2,:,:,:,:) - c2 * mp(b,:,:,:,:);
  gp.sd(b,:,:,:,:) = sqrt( (c4*mpsd(b+dgpt2,:,:,:,:)).^2 + (c2*mpsd(b,:,:,:,:)).^2 );
end

% Restriction to positive gradients
% hard restriction
% gp.m = (gp.m + c2*abs(gp.m))/2; % gp = max(gp,0);

% soft restriction
% kv.mgs = 10; % constant to stretch the atan
gp.m = kv.mgs*(atan(gp.m/kv.mgs-pi/2)+pi/2);
gp.sd = gp.sd/2; % ROUGH APPROXIMATION assuming that non-linear restriction to positive gradients halfs the rate variability

gfc = fc(dgpt2+1:end);

end