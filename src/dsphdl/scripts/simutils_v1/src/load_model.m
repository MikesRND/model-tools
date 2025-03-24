% LOAD_MODEL Load XPI Model named 'sys'
%
% Inputs:
%   sys: (string)
%       Model name
%
% Outputs: None
%
% Author: Mike Babst <mike.babst@dsplogic.com>
%
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------

if ~bdIsLoaded(sys)
    disp(['Loading system ' sys '...']);
    load_system(sys)
end
isShown = strcmp(get_param(sys,'Shown'), 'on'); 
if  ~isShown
    disp(['Showing system ' sys '...']);
    open_system(sys)
end

modelInfo = Simulink.MDLInfo(sys);

disp(['Loaded Model: ' modelInfo.BlockDiagramName ' (ver ' modelInfo.ModelVersion ')'  ]);
