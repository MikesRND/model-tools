function sat = satdetect(x, y, holdSaturate)
%#codegen
% SATDETECT: Detect saturation and optionally hold
% 
% Note that this is CONSERVATIVE because it compares the inputs
% against the bounds rather than the *ROUNDED* input against the bounds.
%
% Author: Mike Babst <mike.babst@dsplogic.com>
%
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------
%

persistent satreg;

if isempty(satreg)
    satreg = false(size(x));
end

sathold = satreg;

max = upperbound(y);
min = lowerbound(y);

saturated = false(size(x));

for k =1:length(x)
    if (x(k) > max)  || (x(k) < min)
        saturated(k) = true;
        satreg(k) = true;
    else
        saturated(k) = false;
    end
end    

if holdSaturate
    sat = sathold;    %: Registered and held
else
    sat = saturated;  %: combinatorial
end