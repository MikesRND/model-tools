function [ y ] = hdls( val, W, S )
%HDLS Signed HDL Integer
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
fm = fimath('RoundingMethod', 'Floor',...
            'OverflowAction', 'Wrap',...
            'ProductMode', 'FullPrecision',...
            'MaxProductWordLength', 128,...
            'SumMode', 'KeepLSB',...
            'SumWordLength', W);
if nargin < 3
    S=0;
end
y = fi(val, 1, W, S, fm);
                 
end