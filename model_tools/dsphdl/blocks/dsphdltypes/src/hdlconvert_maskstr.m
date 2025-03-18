function maskstr = hdlconvert_maskstr(extend, signed, maxwidth, scaleopt, roundMode, saturate, Sforce) 
% DSPHDL / hdlconvert_maskstr
% 
% Description
%   Create a string to display on the hdlconvert block mask
% 
% Author: Mike Babst <mike.babst@dsplogic.com>
%
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------


name_str = 'hdlconvert\n';  

if extend
    extend_str = 'extend\n';
else
    extend_str = '';
end

bitstr = ['Max Bits: ' num2str(maxwidth) '\n'];

switch scaleopt
    case 1
        scale_str = 'Best Precision';
    case 2
        scale_str = 'Best Range';
    case 3
        scale_str = ['Scale = ' num2str(Sforce)];
    otherwise
        scale_str= '';
end

if saturate
    sat_str = 'sat';
else
    sat_str = '';
end    

switch roundMode
    case 1
        rnd_str = ''; % wrap
    case 2
        rnd_str = 'rnd'; % Nearest
    case 3
        rnd_str = 'rnd'; % Convergent
end

rndsat_str = ['\n' rnd_str sat_str];

maskstr= [bitstr scale_str rndsat_str];


