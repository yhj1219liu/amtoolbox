function output = exp_lindemann1986a(varargin)
%EXP_LINDEMANN1986a Reproduces figures from lindemann1986a
%   Usage: output = exp_lindemann1986a(flag)
%
%   Output parameters:
%       output - The data for the given figure. The format of output
%       depends on the chosen figure and will be explained below.
%
%   EXP_LINDEMANN1986a(flag) reproduces the results for the figure given by
%   flag from the Lindemann (1986a) paper. It will also plot the results.
%   The format of its output depends on the chosen figure. If not other
%   stated the cross-correlation of a pure tone sinusoids with f=500 Hz and
%   different ITDs, ILDs or a combination of both is calculated. Because of
%   the stationary character of the input signals T_int = inf is used to
%   produce only one time step in the crosscorr output.
%   
%   flag can be one of the following:
%
%   'fig6'
%       output - cross-correlation result of the figure.
%                Dim: number of c_s conditions x nitds x delay line length
%
%       EXP_LINDEMANN1986a('fig6') reproduces fig.6 from lindemann1986a. 
%       The cross-correlation is calculated for different ITDs and different
%       inhibition factors c_s (0,0.3,1). Afterwards for every c_s the
%       correlation is plotted for every used ITD dependend on the
%       correlation-time delay.
%
%   'fig7'
%       output - Displacement of the centroid for different c_s values.
%                Dim: c_s x nitds
%
%       EXP_LINDEMANN1986a('fig7') reproduces fig.7 from lindemann1986a. 
%       The cross-correlation is calculated for different ITDs and different
%       inhibition factors c_s (0:0.2:1). Afterwards for every c_s the
%       displacement of the centroid of the auditory image is calculated
%       and plotted dependend on the ITD.
%
%   'fig8'
%       output - cross-correlation result of the to figure.
%                Dim: number of c_s conditions x nilds x delay line length
%
%       EXP_LINDEMANN1986a('fig8') reproduces fig.8 from lindemann1986a. 
%       The cross-correlation is calculated for different ILDs and different
%       inhibition factors c_s = 0.3, 1. Afterwards for every c_s the ILD
%       is plotted dependend on the correaltion time.
%
%   'fig10'
%       output - cross-correlation result of the to figure.
%                Dim: number of c_s conditions x nilds x delay line length
%
%       EXP_LINDEMANN1986a('fig10') reproduces fig.10 from lindemann1986a. 
%       The cross-correlation is calculated for different ILDs, an
%       inhibition factor c_s = 0.3 and a monaural detector factor
%       w_f = 0.035. Afterwards for every c_s the ILD is plotted dependend
%       on the correaltion time.
%
%   'fig11'
%       output - cross-correlation result of the to figure.
%                Dim: number of c_s conditions x nilds x delay line length
%
%       EXP_LINDEMANN1986a('fig11') reproduces fig.11 from lindemann1986a. 
%       The centroid position is calculated for different ILDs, an
%       inhibition factor c_s = 0.3 and a monaural detector factor
%       w_f = 0.035. Afterwards for every c_s the displacement of the
%       centroid is plotted dependend on the ILD.
%
%   'fig12'
%       output - simulated results for a trading experiment. The ILD value for
%                getting a centroid near the center for an combined ITD, ILD
%                stimulus with a given ITD value.
%                Dim: number of ITDs x 1
%
%       EXP_LINDEMANN1986a('fig12') reproduces fig.12 from lindemann1986a. 
%       The centroids are calculated for combinations of ITDs and ILDs.
%       After the calculation the values for the centroids of the stimuli
%       are searched to find the nearest value to 0. The corresponding ILD
%       value is stored in output and plotted depnenden on the ITD.
%
%   'fig13'
%       output - ILD value for getting the same lateralization with an ILD only
%                stimulus compared to a stimulus with both ITD and ILD.
%                Dim: number of ILDs x number of ITDs
%
%       EXP_LINDEMANN1986a('fig13') reproduces fig.13 from lindemann1986a. 
%       The centroids are calculated for ILD only and ITD/ILD combination
%       stimuli.After the calculation the values for the centroids of the
%       ILD only stimuli are searched to find the nearest value to the
%       centroid of a given combined stimulus. The resulting ILD value is
%       stored for different combinaition values and plotted dependend on
%       ITD.
%
%   'fig14a'
%       output - Displacement of the centroid for different c_s values and ILDs.
%                Dim: c_s x nilds
%
%       EXP_LINDEMANN1986a('fig14a') reproduces fig.14 (a) from lindemann1986a.
%       The cross-correlations for a combination of ILDs and a ITD of ~1ms are
%       calculated. This is done for different ILDs and different inhibition
%       factors c_s = [0,0.2,0.4,0.6,1]. Afterwards for every c_s the
%       centroid of the auditory image is calculated and plotted dependend
%       on the ILD.
%
%   'fig14b'
%       output - Displacement of the centroid as a function of the ITD averaged
%                over different small ILD with a standard deviation of 0,1,2,3,4,5.
%                Dim: nilds x nitds
%
%       EXP_LINDEMANN1986a('fig14b') reproduces fig.14 (b) from lindemann1986a.
%       The cross-correlations for a combination of ILDs and a ITD of ~1ms are
%       calculated. This is done for different small ILDs with a standard
%       deviation of 0-5. Afterwards for every standard deviation the mean
%       centroid displacement is calculated and plotted dependend on the ITD.
%
%   'fig15'
%       output - cross-correlation result of the to figure.
%                Dim: number of c_s conditions x nilds x delay line length
%
%       EXP_LINDEMANN1986a('fig15') reproduces fig.15 from lindemann1986a.
%       The cross-correlation for an ITD of -0.5ms is calculated. This is
%       done for different ILDs, an inhibition factor c_s = 0.3 and a
%       monaural detector factor w_f = 0.035. Afterwards for every c_s the
%       ILD is plotted dependend on the correaltion time.
%
%   'fig16'
%       output - The ILD value for which the cross-correlation for a combined ITD,
%                ILD stimulus has two peaks with the same (nearest) height,
%                dependend on the ITD
%                Dim: number of ITDs x 1
%
%       EXP_LINDEMANN1986a('fig16') reproduces fig.16 from lindemann1986a. 
%       The cross-correlations for combinations of ITDs and ILDs are
%       calculated. Afterwards the combinations of ILD and ITD are looked for
%       the ones that have two peaks in its cross-correlation which have the
%       nearly same height. The corresponding ILD value is than stored in
%       output and plotted dependend on the ITD.
%
%   'fig17'
%       output.rcen - ITD value for getting the same lateralization with an ITD only
%                     stimulus compared to a stimulus with both ITD and ILD using
%                     the centroid of the cross-correlation.
%                     Dim: number of ITDs x number of ILDs
%       output.rmax - ITD value for getting the same lateralization with an ITD only
%                     stimulus compared to a stimulus with both ITD and ILD using
%                     the maximum of the cross-correlation.
%                     Dim: number of ITDs x number of ILDs
%
%       EXP_LINDEMANN1986a('fig17') reproduces fig.17 from lindemann1986a.
%       The cross-correlation for ITD/ILD combination and ITD only stimuli is
%       calculated. Afterwards the values for the centroids and maxima of
%       the ITD only stimuli are searched to find the nearest value to the
%       centroid and maxima of a given combined stimulus. The resulting ITD
%       value is stored for different combinaition values.
%
%   'fig18'
%       output - cross-correlation result of the figure.
%                Dim: number of interaural coherences x delay line length
%
%       EXP_LINDEMANN1986a('fig18') reproduces fig.18 from lindemann1986a.
%       The cross-correlation of pink noise with different interaural
%       coherence values is calculated. 
%       Afterwards for every interaural coherence value the correlation is plotted 
%       dependend on the correlation-time delay.
%
%R lindemann1986a
%

%   AUTHOR: Hagen Wierstorf

definput.flags.type={'fig6','fig7','fig8','fig10','fig11',...
                    'fig12','fig13','fig14a','fig14b','fig15',...
                    'fig16','fig17','fig18'};

definput.flags.plot={'plot','noplot'};

[flags,keyvals]  = ltfatarghelper({},definput,varargin);


%% ------ FIG 6 -----------------------------------------------------------
if flags.do_fig6
    
    % Sampling rate
    fs = 44100;
    % Frequency of the sinusoid
    f = 500;
    T = 1/f;
    fc = round(freqtoerb(f));   % corresponding frequency channel

    % Model parameter
    T_int = inf;
    w_f = 0;
    M_f = 6; % not used, if w_f==0
    c_s = [0,0.3,1];

    % NOTE: the longer the signal, the more time we need for computation. On the
    % other side N_1 needs to be long enough to eliminate any onset effects.
    % Lindemann uses N_1 = 17640. Here I uses only N_1 = 2205 which gives the same
    % results for this demo.
    N_1 = ceil(25*T*fs);
    siglen = ceil(30*T*fs);

    % Calculate crosscorrelations for 21 ITD points between 0~ms and 1~ms
    nitds = 21; % number of used ITDs
    ndl = 2*round(fs/2000)+1;   % length of the delay line (see bincorr.m)
    itd = linspace(0,1,nitds);
    output = zeros(length(c_s),nitds,ndl);
    for ii = 1:nitds; 
        % Generate ITD shifted sinusoid
        sig = itdsin(f,itd(ii),fs);
        % Use only the beginning of the signal to generate only one time instance of
        % the cross-correlation and apply onset window
        sig = sig(1:siglen,:);
        sig = lindemannwin(sig,N_1);
        % Calculate cross-correlation for different inhibition factor c_s
        for jj = 1:length(c_s)
            % Calculate cross-correlation (and squeeze due to T_int==inf)
            tmp = squeeze(lindemann(sig,fs,c_s(jj),w_f,M_f,T_int,N_1));
            % Store the needed frequency channel. NOTE: the cross-correlation
            % calculation starts with channel 5, so we have to subtract 4.
            output(jj,ii,:) =  tmp(:,fc-4);
        end
    end


    % ------ Plotting ------
    % Generate time axis
    tau = linspace(-1,1,ndl);
    % Plot figure for every c_s condition
    for jj = 1:length(c_s)
        figure;
        mesh(tau,itd(end:-1:1),squeeze(output(jj,:,:)));
        view(0,57);
        xlabel('correlation-time tau (ms)');
        ylabel('interaural time difference (ms)');
        set(gca,'YTick',0:0.2:1);
        set(gca,'YTickLabel',{'1','0.8','0.6','0.4','0.2','0'});
        tstr = sprintf('c_s = %.1f\nw_f = 0\nf = %i Hz\n',c_s(jj),f);
        title(tstr);
    end

end;


%% ------ FIG 7 -----------------------------------------------------------
if flags.do_fig7
    
    % Sampling rate
    fs = 44100;
    % Frequency of the sinusoid
    f = 500;
    T = 1/f;
    fc = round(freqtoerb(f));   % corresponding frequency channel

    % Model parameter
    T_int = inf;
    w_f = 0;
    M_f = 6; % not used, if w_f==0
    c_s = 0:0.2:1;

    % NOTE: the longer the signal, the more time we need for computation. On the
    % other side N_1 needs to be long enough to eliminate any onset effects.
    % Lindemann uses N_1 = 17640. Here I uses only N_1 = 2205 which gives the same
    % results for this demo.
    N_1 = ceil(25*T*fs);
    siglen = ceil(30*T*fs);

    % Calculate crosscorrelations for 21 ITD points between 0~ms and 1~ms
    nitds = 21; % number of used ITDs
    itd = linspace(0,1,nitds);
    output = zeros(length(c_s),nitds);
    for ii = 1:nitds 
        % Generate ITD shifted sinusoid
        sig = itdsin(f,itd(ii),fs);
        % Use only the beginning of the signal to generate only one time instance of
        % the cross-correlation and apply an onset window
        sig = sig(1:siglen,:);
        sig = lindemannwin(sig,N_1);
        % Calculate cross-correlation for different inhibition factor c_s 
        for jj = 1:length(c_s)
            % Calculate cross-correlation (and squeeze due to T_int==inf)
            tmp = squeeze(lindemann(sig,fs,c_s(jj),w_f,M_f,T_int,N_1));
            % Store the needed frequency channel. NOTE: the cross-correlation
            % calculation starts with channel 5, so we have to subtract 4.
            cc = tmp(:,fc-4);
            % Calculate the position of the centroid
            output(jj,ii) = centroid(cc);
        end
    end


    % ------ Plotting ------
    figure;
    for jj = 1:length(c_s)
        plot(itd,output(jj,:));
        hold on;
    end
    xlabel('interaural time difference (ms)');
    ylabel('displacement of the centroid d');
    tstr = sprintf('w_f = 0\nf = %i Hz\n',f);
    title(tstr);
  
end;


%% ------ FIG 8 -----------------------------------------------------------
if flags.do_fig8
  
    % Sampling rate
    fs = 44100;
    % Frequency of the sinusoid
    f = 500;
    T = 1/f;
    fc = round(freqtoerb(f));   % corresponding frequency channel

    % Model parameter
    T_int = inf;
    w_f = 0;
    M_f = 6; % not used, if w_f==0
    c_s = [0.3,1];

    % NOTE: the longer the signal, the more time we need for computation. On the
    % other side N_1 needs to be long enough to eliminate any onset effects.
    % Lindemann uses N_1 = 17640. Here I uses only N_1 = 2205 which gives the same
    % results for this demo.
    N_1 = ceil(25*T*fs);
    siglen = ceil(30*T*fs);

    % Calculate crosscorrelations for 26 ILD points between 0~dB and 25~dB
    nilds = 26; % number of used ILDs
    ndl = 2*round(fs/2000)+1;   % length of the delay line (see bincorr.m)
    ild = linspace(0,25,nilds);
    output = zeros(2,nilds,ndl);
    for ii = 1:nilds 
        % Generate sinusoid with given ILD
        sig = ildsin(f,ild(ii),fs);
        % Use only the beginning of the signal to generate only one time instance of
        % the cross-correlation and apply onset window
        sig = sig(1:siglen,:);
        sig = lindemannwin(sig,N_1);
        % Calculate cross-correlation for different inhibition factor c_s 
        for jj = 1:length(c_s)
            % Calculate cross-correlation (and squeeze due to T_int==inf)
            tmp = squeeze(lindemann(sig,fs,c_s(jj),w_f,M_f,T_int,N_1));
            % Store the needed frequency channel. NOTE: the cross-correlation
            % calculation starts with channel 5, so we have to subtract 4.
            output(jj,ii,:) = tmp(:,fc-4);
        end
    end


    % ------ Plotting ------
    % Generate time axis
    tau = linspace(-1,1,ndl);
    % Plot figure for every c_s condition
    for jj = 1:length(c_s) 
        figure;
        mesh(tau,ild(end:-1:1),squeeze(output(jj,:,:)));
        view(0,57);
        xlabel('correlation-time delay (ms)');
        ylabel('interaural level difference (dB)');
        set(gca,'YTick',0:5:25);
        set(gca,'YTickLabel',{'25','20','15','10','5','0'});
        tstr = sprintf('c_{inh} = %.1f\nw_f = 0\nf = %i Hz\n',c_s(jj),f);
        title(tstr);
    end

end;


%% ------ FIG 10 ----------------------------------------------------------
if flags.do_fig10
  
  % Sampling rate
  fs = 44100;
  % Frequency of the sinusoid
  f = 500;
  T = 1/f;
  fc = round(freqtoerb(f));   % corresponding frequency channel
  
  % Model parameter
  T_int = inf;
  w_f = 0.035;
  M_f = 6; % not used, if w_f==0
  c_s = 0.3;
  
  % NOTE: the longer the signal, the more time we need for computation. On the
  % other side N_1 needs to be long enough to eliminate any onset effects.
  % Lindemann uses N_1 = 17640. Here I uses only N_1 = 2205 which gives the same
  % results for this demo.
  N_1 = ceil(25*T*fs);
  siglen = ceil(30*T*fs);
  
  % Calculate crosscorrelations for 26 ILD points between 0~dB and 25~dB
  nilds = 26; % number of used ILDs
  ndl = 2*round(fs/2000)+1;   % length of the delay line (see bincorr.m)
  ild = linspace(0,25,nilds);
  output = zeros(length(c_s),nilds,ndl);
  for ii = 1:nilds 
    % Generate sinusoid with given ILD
    sig = ildsin(f,ild(ii),fs);
    % Use only the beginning of the signal to generate only one time instance of
    % the cross-correlation and apply onset window
    sig = sig(1:siglen,:);
    sig = lindemannwin(sig,N_1);
    % Calculate cross-correlation for different inhibition factor c_s 
    for jj = 1:length(c_s)
      % Calculate cross-correlation (and squeeze due to T_int==inf)
      tmp = squeeze(lindemann(sig,fs,c_s(jj),w_f,M_f,T_int,N_1));
      % Store the needed frequency channel. NOTE: the cross-correlation
      % calculation starts with channel 5, so we have to subtract 4.
      output(jj,ii,:) = tmp(:,fc-4);
    end
  end
  
  
  % ------ Plotting ------
  if flags.do_plot
    % Generate time axis
    tau = linspace(-1,1,ndl);
    % Plot figure for every c_s condition
    for jj = 1:length(c_s) 
      mesh(tau,ild(end:-1:1),squeeze(output(jj,:,:)));
      view(0,57);
      xlabel('correlation-time delay (ms)');
      ylabel('interaural level difference (dB)');
      set(gca,'YTick',0:5:25);
      set(gca,'YTickLabel',{'25','20','15','10','5','0'});
      tstr = sprintf('c_{inh} = %.1f\nw_f = 0.035\nf = %i Hz\n',c_s(jj),f);
      title(tstr);
    end
  end;
  
end;


%% ------ FIG 11 ----------------------------------------------------------
if flags.do_fig11

    % Sampling rate
    fs = 44100;
    % Frequency of the sinusoid
    f = 500;
    T = 1/f;
    fc = round(freqtoerb(f));   % corresponding frequency channel

    % Model parameter
    T_int = inf;
    w_f = [0,0,0.035];
    M_f = 6; % not used, if w_f==0
    c_s = [0.3,1,0.3];

    % NOTE: the longer the signal, the more time we need for computation. On the
    % other side N_1 needs to be long enough to eliminate any onset effects.
    % Lindemann uses N_1 = 17640. Here I uses only N_1 = 2205 which gives the same
    % results for this demo.
    N_1 = ceil(25*T*fs);
    siglen = ceil(30*T*fs);

    % Calculate crosscorrelations for 26 ILD points between 0~dB and 25~dB
    nilds = 26; % number of used ILDs
    ild = linspace(0,25,nilds);
    output = zeros(length(c_s),nilds);
    for ii = 1:nilds 
        % Generate sinusoid with given ILD
        sig = ildsin(f,ild(ii),fs);
        % Use only the beginning of the signal to generate only one time instance of
        % the cross-correlation and apply onset window
        sig = sig(1:siglen,:);
        sig = lindemannwin(sig,N_1);
        % Calculate cross-correlation for different inhibition factor c_s 
        for jj = 1:length(c_s)
            % Calculate cross-correlation (and squeeze due to T_int==inf)
            tmp = squeeze(lindemann(sig,fs,c_s(jj),w_f(jj),M_f,T_int,N_1));
            % Store the needed frequency channel
            cc = tmp(:,fc-4);
            % Calculate the position of the centroid
            output(jj,ii) = centroid(cc);
        end
    end


    % ------ Plotting ------
    figure;
    % Plot data from experiments
    data = data_lindemann1986a('fig11_yost');
    plot(data(:,1),data(:,2)*0.058,'+'); hold on;
    data = data_lindemann1986a('fig11_sayers');
    plot(data(:,1),data(:,2)*0.058,'*');
    % Plot line for every condition
    for jj = 1:length(c_s) 
        plot(ild,output(jj,:));
    end
    axis([0 25 0 0.8]);
    legend('500 Hz, Yost','600 Hz, Sayers','500 Hz, model');
    xlabel('interaural level difference (dB)');
    ylabel('displacement of the centroid d');

end;


%% ------ FIG 12 ----------------------------------------------------------
if flags.do_fig12

    % Sampling rate
    fs = 44100;
    % Frequency of the sinusoid
    f = 500;
    T = 1/f;
    fc = round(freqtoerb(f));   % corresponding frequency channel

    % Model parameter
    T_int = inf;
    w_f = 0.035;
    M_f = 6; % not used, if w_f==0
    c_s = 0.3;

    % NOTE: the longer the signal, the more time we need for computation. On the
    % other side N_1 needs to be long enough to eliminate any onset effects.
    % Lindemann uses N_1 = 17640. Here I uses only N_1 = 2205 which gives the same
    % results for this demo.
    N_1 = ceil(25*T*fs);
    siglen = ceil(30*T*fs);

    % Calculate crosscorrelations for 26 ILD points between 0~dB and 25~dB
    nilds = 21; % number of used ILDs for the ILD only stimuli
    nitds = 21; % number of used ITDs for the combined stimuli
    ild = linspace(0,10,nilds);
    itd = linspace(-1,0,nitds);

    % Calculate the centroids for ILD+ITD stimuli
    cen = zeros(nitds,nilds);
    for ii = 1:nitds
        for jj = 1:nilds
            % Generate sinusoid with given ILD
            sig = itdildsin(f,itd(ii),ild(jj),fs);
            % Use only the beginning of the signal to generate only one time 
            % instance of the cross-correlation and apply a linear onset window
            sig = sig(1:siglen,:);
            sig = lindemannwin(sig,N_1);
            % Calculate cross-correlation (and squeeze due to T_int==inf)
            tmp = squeeze(lindemann(sig,fs,c_s,w_f,M_f,T_int,N_1));
            % Store the needed frequency channel
            cc = tmp(:,fc-4);
            % Calculate the position of the centroid
            cen(ii,jj) = centroid(cc);
        end
    end


    % ------ Fiting ------
    % For every ITD find the ILD with gives a centroid near 0
    output = zeros(nitds,1);
    for ii = 1:nitds
        % Find centroid nearest to 0
        [val,idx] = min(abs(cen(ii,:)));
        output(ii) = ild(idx);
    end


    % ------ Plotting ------
    figure;
    data = data_lindemann1986a('fig12_400');
    plot(data(:,1),data(:,2),'+'); hold on;
    data = data_lindemann1986a('fig12_600');
    plot(data(:,1),data(:,2),'*');
    plot(itd,output);
    axis([-1 0 0 10]);
    legend('400 Hz','600 Hz','500 Hz, model');
    xlabel('interaural time difference (ms)');
    ylabel('interaural level difference (dB)');

end;


%% ------ FIG 13 ----------------------------------------------------------
if flags.do_fig13

    % Sampling rate
    fs = 44100;
    % Frequency of the sinusoid
    f = 500;
    T = 1/f;
    fc = round(freqtoerb(f));   % corresponding frequency channel

    % Model parameter
    T_int = inf;
    N_1 = 1;
    w_f = 0.035;
    M_f = 6; % not used, if w_f==0
    c_s = 0.3;

    % NOTE: the longer the signal, the more time we need for computation. On the
    % other side N_1 needs to be long enough to eliminate any onset effects.
    % Lindemann uses N_1 = 17640. Here I uses only N_1 = 2205 which gives the same
    % results for this demo.
    N_1 = ceil(25*T*fs);
    siglen = ceil(30*T*fs);

    % Calculate crosscorrelations for 26 ILD points between 0~dB and 25~dB
    nilds_p = 21; % number of used ILDs for the ILD only stimuli
    nitds_t = 21; % number of used ITDs for the combined stimuli
    nilds_t = 6;  % number of used ILDs for the combined stimuli
    ndl = 2*round(fs/2000)+1;     % length of the delay line (see bincorr.m)
    ild_p = linspace(-10,40,nilds_p);
    itd_t = linspace(-1,1,nitds_t);
    ild_t = [-3,0,3,9,15,25];

    % Calculate the centroids for the ILD only stimuli
    cen_p = zeros(1,nilds_p);
    for ii = 1:nilds_p
        % Generate sinusoid with given ILD
        sig = ildsin(f,ild_p(ii),fs);
        % Use only the beginning of the signal to generate only one time instance of
        % the cross-correlation and apply a linear onset window
        sig = sig(1:siglen,:);
        sig = lindemannwin(sig,N_1);
        % Calculate cross-correlation (and squeeze due to T_int==inf)
        tmp = squeeze(lindemann(sig,fs,c_s,w_f,M_f,T_int,N_1));
        % Store the needed frequency channel
        cc = tmp(:,fc-4);
        % Calculate the position of the centroid
        cen_p(ii) = centroid(cc);
    end

    % Calculate the centroids for the combined stimuli
    cen_t = zeros(nilds_t,nitds_t);
    for ii = 1:nitds_t
        for jj = 1:nilds_t
            sig = itdildsin(f,itd_t(ii),ild_t(jj),fs);
            sig = sig(1:siglen,:);
            sig = lindemannwin(sig,N_1);
            tmp = squeeze(lindemann(sig,fs,c_s,w_f,M_f,T_int,N_1));
            cc = tmp(:,fc-4);
            cen_t(jj,ii) = centroid(cc);
        end
    end

    % ------ Fiting ------
    % For the results for the combined centroids find the nearest centroid for the
    % ILD only stimuli
    output = zeros(nilds_t,nitds_t);
    for ii = 1:nitds_t
        for jj = 1:nilds_t
            idx = findnearest(cen_p,cen_t(jj,ii));
            output(jj,ii) = ild_p(idx);
        end
    end


    % ------ Plotting ------
    % First plot the only data from experiments
    figure;
    d = data_lindemann1986a('fig13');
    plot(d(:,1),d(:,2),'x-r', ...   % -3dB
         d(:,1),d(:,3),'x-b', ...   %  3dB
         d(:,1),d(:,4),'x-g', ...   %  9dB
         d(:,1),d(:,5),'x-b', ...   % 15dB
         d(:,1),d(:,6),'x-r')       % 25dB
    legend('25dB','15dB','9dB','3dB','-3dB');
    axis([-1 1 -10 40]);
    set(gca,'XTick',-1:0.4:1);
    xlabel('interaural time difference (ms)');
    ylabel('interaural level difference (dB)');
    % Then plot model results
    figure;
    % Plot line for every condition
    for jj = 1:nilds_t
        plot(itd_t,output(jj,:));
        hold on;
    end
    axis([-1 1 -10 40]);
    set(gca,'XTick',-1:0.4:1);
    xlabel('interaural time difference (ms)');
    ylabel('interaural level difference (dB)');

end;


%% ------ FIG 14a ---------------------------------------------------------
if flags.do_fig14a

    % Sampling rate
    fs = 44100;
    % Frequency of the sinusoid
    f = 500;
    T = 1/f;
    fc = round(freqtoerb(f));   % corresponding frequency channel

    % --- FIG 14 (a) ---
    % Model parameter
    T_int = inf;
    w_f = 0;
    M_f = 6; % not used, if w_f==0
    c_s = [0.0,0.2,0.4,0.6,1.0];

    % NOTE: the longer the signal, the more time we need for computation. On the
    % other side N_1 needs to be long enough to eliminate any onset effects.
    % Lindemann uses N_1 = 17640. Here I uses only N_1 = 2205 which gives the same
    % results for this demo.
    N_1 = ceil(25*T*fs);
    siglen = ceil(30*T*fs);

    % Calculate crosscorrelations for 21 ITD points between 0~ms and 1~ms
    nilds = 21; % number of used ITDs
    ild = linspace(-3,3,nilds);
    itd = 2000/f;
    output = zeros(length(c_s),nilds);
    for ii = 1:nilds 
        % Generate ITD shifted sinusoid
        sig = itdildsin(f,itd,ild(ii),fs);
        % Use only the beginning of the signal to generate only one time instance of
        % the cross-correlation
        sig = sig(1:siglen,:);
        % Apply a linear onset window with length N_1/2 to minimize onset effects
        % (see lindemann1986a p. 1614)
        sig = lindemannwin(sig,N_1);
        % Calculate cross-correlation for different inhibition factor c_s 
        for jj = 1:length(c_s)
            % Calculate cross-correlation (and squeeze due to T_int==inf)
            tmp = squeeze(lindemann(sig,fs,c_s(jj),w_f,M_f,T_int,N_1));
            % Store the needed frequency channel. NOTE: the cross-correlation
            % calculation starts with channel 5, so we have to subtract 4.
            cc = tmp(:,fc-4);
            % Calculate the position of the centroid
            output(jj,ii) = centroid(cc);
        end
    end


    % ------ Plotting ------
    figure;
    for jj = 1:length(c_s)
        plot(ild,output(jj,:));
        hold on;
    end
    xlabel('interaural level difference (dB)');
    ylabel('displacement of the centroid d');
    tstr = sprintf('w_f = 0\nf = %i Hz\n',f);
    title(tstr);

end;


%% ------ FIG 14b ---------------------------------------------------------
if flags.do_fig14b

    % Sampling rate
    fs = 44100;
    % Frequency of the sinusoid
    f = 500;
    T = 1/f;
    fc = round(freqtoerb(f));   % corresponding frequency channel

    % Model parameter
    T_int = inf;
    w_f = 0;
    M_f = 6; % not used, if w_f==0
    c_s = 1.0;

    % NOTE: the longer the signal, the more time we need for computation. On the
    % other side N_1 needs to be long enough to eliminate any onset effects.
    % Lindemann uses N_1 = 17640. Here I uses only N_1 = 2205 which gives the same
    % results for this demo.
    N_1 = ceil(25*T*fs);
    siglen = ceil(30*T*fs);

    fprintf(1,'NOTE: this test function will need a lot of time!\n\n');

    % Calculate crosscorrelations for 21 ITD points between 0~ms and 1~ms
    nitds = 21; % number of used ITDS
    nilds = 201; % number of used ILDs
    itd = linspace(0,1,nitds);
    ild_std = [1,2,3,4,5];
    output = zeros(length(ild_std)+1,nitds);
    centmp = zeros(nilds,nitds);
    for ii = 1:nitds
        % Show progress
        progressbar(ii,nitds);
        % First generate the result for std(ILD) == 0
        sig = itdsin(f,itd(ii),fs);
        sig = sig(1:siglen,:);
        sig = lindemannwin(sig,N_1);
        tmp = squeeze(lindemann(sig,fs,c_s,w_f,M_f,T_int,N_1));
        cc = tmp(:,fc-4);
        cen(1,ii) = centroid(cc);
        % Generate results for std(ILD) ~= 0
        for nn = 1:length(ild_std)
            % Generate normal distributed ILDs with mean ~ 0 and std = 1
            tmp = randn(nilds,1);
            tmp = tmp/std(tmp);
            % Generate desired ILD distribution
            ild = tmp * ild_std(nn);
            % For all distributed ILD values calculate the centroid
            for jj = 1:nilds
                sig = itdildsin(f,itd(ii),ild(jj),fs);
                sig = sig(1:siglen,:);
                sig = lindemannwin(sig,N_1);
                tmp = squeeze(lindemann(sig,fs,c_s,w_f,M_f,T_int,N_1));
                cc = tmp(:,fc-4);
                centmp(jj,ii) = centroid(cc);
            end
            % Calculate the mean centroid above the ILD distribution
            output(nn+1,ii) = mean(centmp(:,ii));
        end
    end


    % ------ Ploting ------
    figure
    for nn = 1:length(ild_std)+1
        plot(itd,output(nn,:)); hold on;
    end
    axis([0 1 0 1]);
    xlabel('interaural level difference (dB)');
    ylabel('displacement of the centroid d');
    tstr = sprintf('w_f = 0\nc_{inh} = 1\nf = %i Hz\n',f);
    title(tstr);

end;


%% ------ FIG 15 ----------------------------------------------------------
if flags.do_fig15

    % Sampling rate
    fs = 44100;
    % Frequency of the sinusoid
    f = 500;
    T = 1/f;
    fc = round(freqtoerb(f));   % corresponding frequency channel

    % Model parameter
    T_int = inf;
    w_f = 0.035;
    M_f = 6; % not used, if w_f==0
    c_s = 0.3;

    % NOTE: the longer the signal, the more time we need for computation. On the
    % other side N_1 needs to be long enough to eliminate any onset effects.
    % Lindemann uses N_1 = 17640 (200*T). Here I uses only N_1 = 2205 (25*T) 
    % which gives the same results for this demo.
    N_1 = ceil(25*T*fs);
    siglen = ceil(30*T*fs);

    % Calculate crosscorrelations for 26 ILD points between 0~dB and 25~dB
    nilds = 26; % number of used ILDs
    ndl = 2*round(fs/2000)+1;   % length of the delay line (see bincorr.m)
    ild = linspace(0,25,nilds);
    itd = -0.5;
    output = zeros(length(c_s),nilds,ndl);
    for ii = 1:nilds 
        % Generate sinusoid with given ILD
        sig = itdildsin(f,itd,ild(ii),fs);
        % Use only the beginning of the signal to generate only one time instance of
        % the cross-correlation and apply onset window
        sig = sig(1:siglen,:);
        sig = lindemannwin(sig,N_1);
        % Calculate cross-correlation for different inhibition factor c_s 
        for jj = 1:length(c_s)
            % Calculate cross-correlation (and squeeze due to T_int==inf)
            tmp = squeeze(lindemann(sig,fs,c_s(jj),w_f,M_f,T_int,N_1));
            % Store the needed frequency channel. NOTE: the cross-correlation
            % calculation starts with channel 5, so we have to subtract 4.
            output(jj,ii,:) = tmp(:,fc-4);
        end
    end


    % ------ Plotting --------------------------------------------------------
    % Generate time axis
    tau = linspace(-1,1,ndl);
    % Plot figure for every c_s condition
    for jj = 1:length(c_s) 
        figure;
        mesh(tau,ild(end:-1:1),squeeze(output(jj,:,:)));
        view(0,57);
        xlabel('correlation-time delay (ms)');
        ylabel('interaural level difference (dB)');
        set(gca,'YTick',0:5:25);
        set(gca,'YTickLabel',{'25','20','15','10','5','0'});
        tstr = sprintf('c_{inh} = %.1f\nw_f = 0.035\nf = %i Hz\n',c_s(jj),f);
        title(tstr);
    end

end;


%% ------ FIG 16 ---------------------------------------------------------
if flags.do_fig16

    % Sampling rate
    fs = 44100;
    % Frequency of the sinusoid
    f = 500;
    T = 1/f;
    fc = round(freqtoerb(f));   % corresponding frequency channel

    % Model parameter
    T_int = inf;
    w_f = 0.035;
    M_f = 6; % not used, if w_f==0
    c_s = 0.3;

    % NOTE: the longer the signal, the more time we need for computation. On the
    % other side N_1 needs to be long enough to eliminate any onset effects.
    % Lindemann uses N_1 = 17640. Here I uses only N_1 = 2205 which gives the same
    % results for this demo.
    N_1 = ceil(25*T*fs);
    siglen = ceil(30*T*fs);

    % Calculate crosscorrelations for 26 ILD points between 0~dB and 25~dB
    nilds = 21; % number of used ILDs for the ILD only stimuli
    nitds = 21; % number of used ITDs for the combined stimuli
    ndl = 2*round(fs/2000)+1;     % length of the delay line (see bincorr.m)
    ild = linspace(0,10,nilds);
    itd = linspace(-1,0,nitds);

    % Calculate the centroids for ILD+ITD stimuli
    cc = zeros(nitds,nilds,ndl);
    for ii = 1:nitds
        for jj = 1:nilds
            % Generate sinusoid with given ILD
            sig = itdildsin(f,itd(ii),ild(jj),fs);
            % Use only the beginning of the signal to generate only one time 
            % instance of the cross-correlation and apply a linear onset window
            sig = sig(1:siglen,:);
            sig = lindemannwin(sig,N_1);
            % Calculate cross-correlation (and squeeze due to T_int==inf)
            tmp = squeeze(lindemann(sig,fs,c_s,w_f,M_f,T_int,N_1));
            % Store the needed frequency channel
            cc(ii,jj,:) = tmp(:,fc-4);
        end
    end


    % ------ Fiting ------
    % For every ITD find the ILD with gives a centroid near 0
    output = zeros(nitds,1);
    for ii = 1:nitds
        % Find two peaks of same height
        idx = findpeaks(squeeze(cc(ii,:,:)));
        output(ii) = ild(idx);
    end


    % ------ Plotting ------
    figure;
    data = data_lindemann1986a('fig16');
    plot(data(:,1),data(:,2),'+'); hold on;
    plot(itd,output);
    axis([-1 0 0 15]);
    xlabel('interaural time difference (ms)');
    ylabel('interaural level difference (dB)');

end;


%% ------ FIG 17 ----------------------------------------------------------
if flags.do_fig17

    % Sampling rate
    fs = 44100;
    % Frequency of the sinusoid
    f = 500;
    T = 1/f;
    fc = round(freqtoerb(f));   % corresponding frequency channel

    % Model parameter
    T_int = inf;
    w_f = 0.035;
    M_f = 6; % not used, if w_f==0
    c_s = 0.3;

    % NOTE: the longer the signal, the more time we need for computation. On the
    % other side N_1 needs to be long enough to eliminate any onset effects.
    % Lindemann uses N_1 = 17640. Here I uses only N_1 = 2205 which gives the same
    % results for this demo.
    N_1 = ceil(25*T*fs);
    siglen = ceil(30*T*fs);

    % Calculate crosscorrelations for 26 ILD points between 0~dB and 25~dB
    nitds_p = 21; % number of used ITDs for the ITD only stimuli
    nitds_t = 4; % number of used ITDs for the combined stimuli
    nilds_t = 21;  % number of used ILDs for the combined stimuli
    itd_p = linspace(-0.36,0.72,nitds_p);
    ild_t = linspace(-9,9,nilds_t);
    itd_t = [0,0.09,0.18,0.27];

    % Calculate the centroids for the ITD only stimuli
    cen_p = zeros(1,nitds_p);
    max_p = zeros(1,nitds_p);
    for ii = 1:nitds_p
        % Generate sinusoid with given ILD
        sig = itdsin(f,itd_p(ii),fs);
        % Use only the beginning of the signal to generate only one time instance of
        % the cross-correlation and apply a linear onset window
        sig = sig(1:siglen,:);
        sig = lindemannwin(sig,N_1);
        % Calculate cross-correlation (and squeeze due to T_int==inf)
        tmp = squeeze(lindemann(sig,fs,c_s,w_f,M_f,T_int,N_1));
        % Store the needed frequency channel
        cc = tmp(:,fc-4);
        % Find the maximum position
        max_p(ii) = findmax(cc);
        % Calculate the position of the centroid
        cen_p(ii) = centroid(cc);
    end

    % Calculate the centroids for the combined stimuli
    cen_t = zeros(nitds_t,nilds_t);
    max_t = zeros(nitds_t,nilds_t);
    for ii = 1:nilds_t
        for jj = 1:nitds_t
            sig = itdildsin(f,itd_t(jj),ild_t(ii),fs);
            sig = sig(1:siglen,:);
            sig = lindemannwin(sig,N_1);
            tmp = squeeze(lindemann(sig,fs,c_s,w_f,M_f,T_int,N_1));
            cc = tmp(:,fc-4);
            max_t(jj,ii) = findmax(cc);
            cen_t(jj,ii) = centroid(cc);
        end
    end

    % ------ Fiting ------
    % For the results for the combined centroids find the nearest centroid for the
    % ITD only stimuli
    output.rmax = zeros(nitds_t,nilds_t);
    output.rcen = output.rmax;
    for ii = 1:nilds_t
        for jj = 1:nitds_t
            idx = findnearest(cen_p,cen_t(jj,ii));
            output.rcen(jj,ii) = itd_p(idx);
            idx = findnearest(max_p,max_t(jj,ii));
            output.rmax(jj,ii) = itd_p(idx);
        end
    end


    % ------ Plotting ------
    % First plot the only data from experiments
    figure; % fig 17 (a)
    d = data_lindemann1986a('fig17');
    plot(d(:,1),d(:,5),'x-r', ...   %  0 ms
         d(:,1),d(:,4),'x-b', ...   %  0.09 ms
         d(:,1),d(:,3),'x-g', ...   %  0.18 ms
         d(:,1),d(:,2),'x-b')       %  0.27 ms
    legend('0.27 ms','0.18 ms','0.09 ms','0 ms');
    axis([-9 9 -0.36 0.72]);
    set(gca,'XTick',-9:3:9);
    xlabel('interaural level difference (dB)');
    ylabel('interaural time difference (ms)');
    % Then plot model results
    figure; % fig 17 (b)
    % Plot line for every condition
    for jj = 1:nitds_t
        plot(ild_t,output.rcen(jj,:));
        hold on;
    end
    axis([-9 9 -0.36 0.72]);
    set(gca,'XTick',-9:3:9);
    xlabel('interaural level difference (dB)');
    ylabel('interaural time difference (ms)');
    %
    figure; % fig 17 (c)
    for jj = 1:nitds_t
        plot(ild_t,output.rmax(jj,:));
        hold on;
    end
    axis([-9 9 -0.36 0.72]);
    set(gca,'XTick',-9:3:9);
    xlabel('interaural level difference (dB)');
    ylabel('interaural time difference (ms)');

end;


%% ------ FIG 18 ----------------------------------------------------------
if flags.do_fig18

    % Sampling rate
    fs = 44100;
    % Frequency of the sinusoid
    f = 500;
    T = 1/f;
    fc = round(freqtoerb(f));   % corresponding frequency channel

    % Model parameter
    T_int = inf;
    w_f = 0.035;
    M_f = 6; % not used, if w_f==0
    c_s = 0.11;

    % NOTE: the longer the signal, the more time we need for computation. On the
    % other side N_1 needs to be long enough to eliminate any onset effects.
    % Lindemann uses N_1 = 17640. Here I uses only N_1 = 2205 which gives the same
    % results for this demo.
    N_1 = ceil(25*T*fs);

    % Calculate crosscorrelations for 21 ITD points between 0~ms and 1~ms
    niacs = 11; % number of used interaural coherence values
    ndl = 2*round(fs/2000)+1;   % length of the delay line (see bincorr.m)
    iac = linspace(0,1,niacs);
    output = zeros(niacs,ndl);
    for ii = 1:niacs; 
        % Generate ITD shifted sinusoid
        sig = corpinknoise(fs,iac(ii));
        % Aplly onset window
        sig = lindemannwin(sig,N_1);
        % Calculate cross-correlation (and squeeze due to T_int==inf)
        tmp = squeeze(lindemann(sig,fs,c_s,w_f,M_f,T_int,N_1));
        % Store the needed frequency channel. NOTE: the cross-correlation
        % calculation starts with channel 5, so we have to subtract 4.
        output(ii,:) =  tmp(:,fc-4);
    end


    % ------ Plotting ------
    % Generate time axis
    tau = linspace(-1,1,ndl);
    % Plot figure for every c_s condition
    figure;
    mesh(tau,iac,output);
    view(0,57);
    xlabel('correlation-time tau (ms)');
    ylabel('degree of interaural coherence');

end;


%% ------ Subfunctions ----------------------------------------------------
function idx = findnearest(list,val)
[dif,idx] = min(abs(list-val));

function idx = findpeaks(cc)
% FINDPEAKS Finds two peaks of the same height in a given cross-correlation
h = zeros(size(cc,1),1);
for ii = 1:size(cc,1)
    % Find a peak in the two halfes of the cross-correlation and subtract them
    h(ii) = max(cc(ii,1:30)) - max(cc(ii,31:end));
end
% Find the index with the smallest distance between the two peaks
[val,idx] = min(abs(h));

function m = findmax(list)
[m,idx] = max(list);
d = linspace(-1,1,length(list));
m = d(idx);