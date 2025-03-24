function multadd_flex_init(blk,...
            accumMode,...
            roundMode_a, roundMode_b, roundMode_c, ...
            saturate_a,  saturate_b, saturate_c, ...
            extend_a, extend_b, extend_c,...
            scalingSelect_a, scalingSelect_b, scalingSelect_c...
)
% MULTADD_FLEX_INIT Block mask initialization function
%   
% This function initializes the madd_flex block.
% 
% Author: Mike Babst <mike.babst@dsplogic.com>
%
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------


%% Get internal block names
% This is necessay because in rare cases Simulink's generated models, the 
% name of % Matlab Function Blocks (e.g. hdlconvert) get changed to random 
% names This doesn't break HDL code generation, but it does break Testbench
% generation during simulation
pc_a = get_param([blk '/a'], 'PortConnectivity');
blk_convert_a = pc_a.DstBlock;
pc_b = get_param([blk '/b'], 'PortConnectivity');
blk_convert_b = pc_b.DstBlock;
pc_c = get_param([blk '/c'], 'PortConnectivity');
blk_convert_c = pc_c.DstBlock;


%% Accumulaor sizing
switch accumMode
    
    case 1 % if strcmp(accumMode, 'Automatic');

        set_param([blk '/madd_type1'],'accumMode', 'Automatic' );

    case 2 % elseif strcmp(accumMode, 'Same as C input (after conversion)'),

        set_param([blk '/madd_type1'],'accumMode', 'Same as C input');

    otherwise
        error('DSPHDL:multadd_flex_init:InvalidInput','Invalid accumMode');
end



%% Input Rounding
apply_roundMode(blk_convert_a, roundMode_a);
apply_roundMode(blk_convert_b, roundMode_b);
apply_roundMode(blk_convert_c, roundMode_c);


%% Input Saturation
set_param(blk_convert_a, 'saturate',saturate_a);
set_param(blk_convert_b, 'saturate',saturate_b);
set_param(blk_convert_c, 'saturate',saturate_c);

%% Input Extension
set_param(blk_convert_a, 'extend', extend_a);
set_param(blk_convert_b, 'extend', extend_b);
set_param(blk_convert_c, 'extend', extend_c);

%% Input Scaling
apply_scaling(blk_convert_a, scalingSelect_a);
apply_scaling(blk_convert_b, scalingSelect_b);
apply_scaling(blk_convert_c, scalingSelect_c);

Sforce_a = get_param(blk, 'Sforce_a');
Sforce_b = get_param(blk, 'Sforce_b');
Sforce_c = get_param(blk, 'Sforce_c');

set_param(blk_convert_a, 'Sforce', Sforce_a);
set_param(blk_convert_b, 'Sforce', Sforce_b);
set_param(blk_convert_c, 'Sforce', Sforce_c);


end

function apply_roundMode(blk, roundMode_id)
    switch roundMode_id
        case 1
            set_param(blk,'roundMode', 'Floor')
        case 2
            set_param(blk,'roundMode', 'Nearest')
        case 3
            set_param(blk,'roundMode', 'Convergent')
        otherwise
            set_param(blk,'roundMode', 'Floor')
    end
end

function apply_scaling( blk_convert,  scalingSelect)

switch scalingSelect
       
    case 1 % elseif strcmp(scalingSelect, 'Best Precision'),
        set_param(blk_convert,'scaleopt',  'Best Precision');
    case 2 % if strcmp(scalingSelect, 'Best Range');
        set_param(blk_convert,'scaleopt', 'Best Range');
    case 3 % elseif strcmp(scalingSelect, 'Forced'),
        set_param(blk_convert,'scaleopt', 'Forced');
    otherwise
        error('Invalid scaling mode');
end

end
