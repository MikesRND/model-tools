function turn_scopes(action, sys)
%TURN_SCOPES Enable/disable scopes in model
%   
% Syntax:
%   turn_scopes('off',sys)
%   turn_scopes('on',sys)
% 
% Description:
%   Disable or enable scopes within a model by commenting or uncommenting
%   them out.
% 
% Arguments:
% 
%   sys: (str)
%       Simulink model name
% 
%   action: 'on' or 'off'
%       'on':  Enable scopes by "uncommenting" all Scope blocks
%       'off': Disable scopes by "commenting" all Scope blocks
%   
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------

scopes = find_system(sys,'LookUnderMasks','all',...
                         'IncludeCommented','on',...
                         'BlockType','Scope');

N = numel(scopes);

if strcmp(action,'on')
    for k = 1:N
        set_param(scopes{k},'Commented','off');
    end
    disp(['Turned on ' num2str(N) ' scopes']);
    
elseif strcmp(action,'off')
    for k = 1:N
        set_param(scopes{k},'Commented','on');
    end
    disp(['Turned off ' num2str(N) ' scopes']);
else
    error(['Invalid input:' action]);
end    

