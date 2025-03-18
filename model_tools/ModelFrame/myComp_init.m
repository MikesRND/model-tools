function [ini] = myComp_init(Tsys)
%myComp_INIT Component Mask Initialization Script
% Initialize constant parameters for internal use by a 
% timed model component.
%
% Inputs
%   Tsys: System time, base model period
%
% Returns
%   ini: struct
%     Constant initialization parameters for internal use

arguments
    Tsys (1,1) double {mustBePositive} = 1.0
end

ini.Fsys = 1/Tsys;
ini.constant1 = 2*pi;

end
    