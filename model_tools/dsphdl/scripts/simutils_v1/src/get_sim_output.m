function [ dout, tout ] = get_sim_output( logsout, signalName, numClocks, enableName )
%GET_SIM_OUTPUT Extract output of simulation signal with optional enable
%   
% Description:  Extract a logged signal from the default 'logsout'
%   object created by a simulink simulation.
%
%   x = get_sim_output(logsout, 'x') 
%       Extracts the logged signal 'x' from the simulink simulation
%   
%   x = get_sim_output(logsout, 'x', 100) 
%       Extracts the logged signal 'x' from the simulink simulation,
%       trimmed to the first 100 samples.
%
%   x = get_sim_output(logsout, 'x', [], 'x_en') 
%       Extract the logged signal 'x' from the simulink simulation, where
%       vlues are only returned when the logged enable signal 'x_en' is
%       non-zero.
%
% Arguments:
% 
%   logsout: (struct)
%       Default object created by a simulink simulation
% 
%   signalName: (str)
%       Name of logged signal
%       
%   numClocks: (int)
%       Number of samples to return.  Pass in 0 or [] to get all samples
% 
%   enableName: (str)
%       Name of enable signal.  When provided, only values of signalName
%       when enableName is non-zero will be returned
% 
% Author: Mike Babst <mike.babst@dsplogic.com>
%
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------
%
if nargin < 3
    numClocks = 0;  % Get all data
end

% Get the output signal
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
if numClocks > 0
    dout      = dout(1:numClocks, :); % Trim to size
    tout      = tout(1:numClocks, :); % Trim to size
end



end

