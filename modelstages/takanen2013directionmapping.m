function [msoAngles,lsoAngles,wbMsoAngles] = takanen2013directionmapping(mso,lso,contraMso,wbMmso)
%TAKANEN2013DIRECTIONMAPPING Map the directional cues to directions                 
%   Usage: [msoAngles,lsoAngles,wbMsoAngles] = takanen2013directionmapping(mso,lso,contraMso,wbMmso)
%
%   Input parameters:
%        mso       : output of the MSO model projecting to left or right
%                    hemisphere
%        lso       : output of the LSO model projecting to left or right
%                    hemisphere
%        contraMso : output of the MSO model projecting to opposite
%                    hemisphere
%        wbMso     : output of the wideband MSO model projecting to left
%                    or right hemisphere
%
%   Output parameters:
%        msoAngles   : direction estimates provided by the model of MSO
%        lsoAngles   : direction estimates provided by the model of MSO
%        wbMsoAngles : direction estimates provided by the wideband MSO
%                      model
%
%   This function maps the outputs of the models of MSO and LSO into
%   azimuth angles ranging from -90 to 90 in 10 degree resolution using a
%   a set of reference values computed using monophonic signals and
%   measured HRTFs of the corresponding directions. More detailed
%   description about the process can be found in Takanen, Santala, Pulkki
%   2013 (Sec. 3.2.5)
%
%   See also: takanen2013, takanen2013mso, takanen2013lso,
%             takanen2013wbmso
%
%   References: takanen2014

%   AUTHOR: Marko Takanen, Olli Santala, Ville Pulkki
%
%   COPYRIGHT (C) 2013 Aalto University
%                      School of Electrical Engineering
%                      Department of Signal Processing and Acoustics
%                      Espoo, Finland


%% ------ Computation ----------------------------------------------------
%load the precomputed set of reference values
x=amt_load('takanen2013','lookuptable.mat');
referencevalues=x.referencevalues;
dims = size(mso);

%initialize the output values
msoAngles = zeros(dims(1),dims(2));
lsoAngles=msoAngles;
wbMsoAngles =msoAngles;

nAngles = length(referencevalues.angles);
for freqInd =1:dims(2)
    %find the closest match to the cue value amongst the reference values 
    %in the lookup table
    temp = abs((lso(:,freqInd)*ones(1,nAngles))-(ones(dims(1),1)*referencevalues.lso(:,freqInd)'));
    %set the direction corresponding to the found reference value as the
    %direction estimate
    [~,ind] = min(temp,[],2);
    lsoAngles(:,freqInd) = referencevalues.angles(ind);

    %otherwise similar approach as above is used for MSO, except for the
    %fact that contralateral MSO cues are used to solve some ambiguities in
    %direction estimation
    temp = abs((mso(:,freqInd)*ones(1,nAngles))-(ones(dims(1),1)*referencevalues.mso(:,freqInd)'))+...
        abs((contraMso(:,freqInd)*ones(1,nAngles))-(ones(dims(1),1)*referencevalues.contramso(:,freqInd)'));
    [~,ind] = min(temp,[],2);
    msoAngles(:,freqInd) = referencevalues.angles(ind);

    %direction mapping for wideband MSO
    temp = abs((wbMmso(:,freqInd)*ones(1,nAngles))-(ones(dims(1),1)*referencevalues.wbmso(:,freqInd)'));
    [~,ind] = min(temp,[],2);
    wbMsoAngles(:,freqInd) = referencevalues.angles(ind);
end