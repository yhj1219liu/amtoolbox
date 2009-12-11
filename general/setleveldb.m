function inoutsig = setleveldb(inoutsig,lvl);
%SETLEVELDB  Set level of signal in Db
%  Usage:  outsig = setlevel(insig,lvl);
%
%  SETLEVELDB(insig,lvl) sets the level of the signal insig to lvl Db SPL,
%  using the convention that an RMS value of 1 corresponds to 100 Db SPL.
%
%  If the input is a matrix, it is assumed that each column is a signal.
%
%  See also: rms, rmsdb, gaindb
  
%   Author: Peter L. Soendergaard, 2009

% ------ Checking of input parameters ---------
  
error(nargchk(2,2,nargin));

if ~isnumeric(inoutsig)
  error('%s: insig must be numeric.',upper(mfilename));
end;

if ~isnumeric(lvl) || ~isscalar(lvl) 
  error('%s: lvl must be a scalar.',upper(mfilename));
end;

if isvector(inoutsig)
  inoutsig = gaindb(inoutsig/rms(inoutsig),lvl-100);
else
  for ii=1:size(inoutsig,2);
    inoutsig(:,ii) = gaindb(inoutsig(:,ii)/rms(inoutsig(:,ii)),lvl-100);
  end;
end;


