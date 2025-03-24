function [ result, libs ] = get_links( sys, disabled, sourceLib )
%GET_LINKS Get model library links
% 
% Description:
%
%   get_links(gcb) 
%       Searches the current block and returns a structure containing all 
%       blocks that are library links.
%   
%   get_links(gcb, true) 
%       Searches the current block and returns a structure containing all 
%       blocks that are *disabled* library links.
%   
%   get_links(gcb, [], sourceLib) 
%       Searches the current block and returns a structure containing all 
%       blocks that are links to the sourceLib library.
%
% Arguments:
% 
%   sys: (str)
%       Simulink model/block name
% 
%   disabled: (bool()
%       Determines whether to search for disabled links
%       
%   sourceLib: (str)
%       If provided, only blocks referencing this library will be returned.
% 
% Author: Mike Babst <mike.babst@dsplogic.com>
%
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------
 
if nargin < 3
    sourceLib = ''; % Search all libs by default
    
end
if nargin < 2
    disabled = false;
end

if disabled
    li = libinfo(sys, 'LinkStatus','inactive', 'BlockType','SubSystem');
else
    li = libinfo(sys, 'BlockType','SubSystem');
end
Nblocks = length(li);

%lis = struct2cell(li);

blocks  = {};
libs    = {};
refs    = {};
libver  = {};
stat    = {};

% Remove built-ins
% ignore_builtins = ["simulink", "commchan", "dspsrcs"];

p = 1;
for k = 1:Nblocks
    
    if isempty(sourceLib) ||  strcmp(sourceLib, li(k).Library )

        if ~any(startsWith(li(k).Library, "simulink"))

            blocks{p} = li(k).Block;
            libs{p}   = li(k).Library;
            refs{p}   = li(k).ReferenceBlock;
            libver{p} = Simulink.MDLInfo(li(k).Library).ModelVersion;
            stat{p}   = li(k).LinkStatus;
            p = p+1;

        end
    end

end

blocks = blocks';
libs = libs';
refs = refs';
libver = libver';
stat = stat';


result=struct('Block'          ,blocks ,...
              'Library'        ,libs   ,...
              'ReferenceBlock' ,refs   ,...
              'LinkStatus'     ,stat   ,...
              'LibraryVersion' ,libver    ...
              );
           

%[mg ng] = arrayfun(@(x)find( strcmp(x.Library,'libxpi_main') ), blocks,'uniformoutput',false)

%% Get unique library dependencies
lis = struct2cell(li);
dep = unique(lis(2,:));
dep = dep';
dep(cellfun(@(dep) (strcmp(dep,'simulink')),dep))=[]; % Remove simulink
Ndep = length(dep);

if Ndep > 0
    libs = cell(Ndep,2);
    for k = 1:Ndep
        libs{k,1} = dep{k};
        libs{k,2} = Simulink.MDLInfo(dep{k}).ModelVersion;
    end
else
    libs = {};
end



end

