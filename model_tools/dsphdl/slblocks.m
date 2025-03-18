function blkStruct = slblocks
% DSPLOGIC / Simulink LIbrary Blocks module
%----------------------------------------------------------
% Usage: 
%   This function specifies that the library should appear
%   in the Library Browser
%   and be cached in the browser repository
%
%----------------------------------------------------------
% Revision Information
% $Author: Mike Babst <mike.babst@dsplogic.com>$
%
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------

Browser.Library = 'lib_dsphdlmain_v2';
% 'mylib' is the name of the library

Browser.Name = 'DSPHDL Library';
% 'My Library' is the library name that appears in the Library Browser

blkStruct.Browser = Browser;
    
end
        