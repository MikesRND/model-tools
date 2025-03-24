function [ dout, tout ] = getSimOutput(simOut, signalName, opts)
arguments
    simOut (1,1) Simulink.SimulationOutput
    signalName (1,:) char {mustBeNonempty} 
    opts.L (1,1) double = 0 
    opts.enableName (1,:) char = ''
end
%GETSIMOUTPUT Extract output of simulation signal with optional enable
%   
% Description:  Extract a logged signal from the default 'Simulink.SimulationOutput'
%   object created by a simulink simulation.
%
%   x = get_sim_output(simOut, 'x') 
%       Extracts the logged signal 'x' from the simulink simulation
%   
%   x = get_sim_output(simOut, 'x', 100) 
%       Extracts the logged signal 'x' from the simulink simulation,
%       trimmed to the first 100 samples.
%
%   x = get_sim_output(simOut, 'x', [], 'x_en') 
%       Extract the logged signal 'x' from the simulink simulation, where
%       vlues are only returned when the logged enable signal 'x_en' is
%       non-zero.
%
% Arguments:
% 
%   logssimOutout: (Simulink.SimulationOutput)
%       Default object created by a simulink simulation
% 
%   signalName: (str)
%       Name of logged signal
%       
%   opts.L: (int)
%       Maxumum number of samples to return.  
% 
%   enableName: (str)
%       Name of enable signal.  When provided, only values of signalName
%       when enableName is non-zero will be returned
% 
% Author: Mike Babst <mike.babst@dsplogic.com>
%

% Get the output signal
logsout = simOut.logsout;
dout    = logsout.getElement(signalName).Values.Data;
dout    = squeeze(dout);
tout    = logsout.getElement(signalName).Values.Time;
tout    = squeeze(tout);

% If enabled, get the enable signal and filter output    
if nargin > 3
    sigvalid  = logsout.getElement(enableName).Values.Data;
    tvalues   = logsout.getElement(enableName).Values.Time;
    try
        dout    =    dout(sigvalid,:); % use logical indexing
    catch ME
        dout    =    dout(:,sigvalid).'; % use logical indexing
    end
    try
        tout    = tvalues(sigvalid,:); % use logical indexing
    catch ME
        tout    = tvalues(:,sigvalid).'; % use logical indexing
    end
end

% If requested, extract the correct number of outputs 
if opts.L > 0
    dout      = dout(1:opts.L, :); % Trim to size
    tout      = tout(1:opts.L, :); % Trim to size
end


end

