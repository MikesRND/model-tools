function madd_type1_init(blk, accumMode, addop)
% MADD_TYPE1_INIT Block mask initialization function
%   
% This function initializes the madd_type1 block.
% 
% Author: Mike Babst <mike.babst@dsplogic.com>
%
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------



switch accumMode
    case 1 % 'Automatic'
        set_param([blk '/sum'],'AccumDataTypeStr', 'Inherit: Inherit via internal rule');
    case 2 % 'Same as C input'
        set_param([blk '/sum'],'AccumDataTypeStr', 'Inherit: Same as first input');
    otherwise
        error('DSPHDL:madd:InvalidInput',['Invalid accumMode:' accumMode]);
end

switch addop
    case 1
        set_param([gcb '/sum'],'Inputs', '++');
    case 2
        set_param([gcb '/sum'],'Inputs', '+-');
    case 3
        set_param([gcb '/sum'],'Inputs', '-+');
end

end