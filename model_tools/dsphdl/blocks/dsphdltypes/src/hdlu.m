function [ y ] = hdlu( val, W, S, preventOverride)
%HDLU Unsigned HDL Integer
% 
% This object allows the simple coding pattern for HDL counters
%    x = x + 1
% instead of
%    x = fi(x + 1 ...)
% 
% Achieved by setting SumMode and SumWordLength to avoid bit 
% growth in the output.
%
% Author: Mike Babst <mike.babst@dsplogic.com>
%
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------
%

if nargin < 2
    % Autosize
    W = ceil(log2(max(max(val))));
    W = max(1,W);
end

if nargin < 3
    S = 0;
end

if nargin < 4
    preventOverride = false;
end

fm = fimath('RoundingMethod', 'Floor',...
            'OverflowAction', 'Wrap',...
            'ProductMode', 'FullPrecision',...
            'MaxProductWordLength', 128,...
            'SumMode', 'KeepLSB',...
            'SumWordLength', W);

if preventOverride        
    nt = numerictype(0, W, S, 'DataTypeOverride', 'Off');
else
    nt = numerictype(0, W, S);
end
        
y = fi(val, nt, fm);
                 
end