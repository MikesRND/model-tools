classdef (Sealed) PathMgr < handle
% DSPLOGIC / Path Manager
%----------------------------------------------------------
% Usage: The path manager is used to manage paths related
% to the DSP HDL Blockset.
%
% getInstance
%   Get or create the single PathMgr instance.
%----------------------------------------------------------
% Revision Information
% $Author: Mike Babst <mike.babst@dsplogic.com>$
%
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------
    
    properties (Access= private)
        MAIN            = fullfile('blocks',  'dsphdlmain');
        UTILS           = fullfile('blocks',  'dsphdlutils');
        TYPES           = fullfile('blocks',  'dsphdltypes');
        MATH            = fullfile('blocks',  'dsphdlmath');       
        ROUTE           = fullfile('blocks',  'dsphdlroute');
        CONTROL         = fullfile('blocks',  'dsphdlcontrol');
        DSP             = fullfile('blocks',  'dsphdldsp');
        HDLGEN          = fullfile('scripts', 'hdlgen_v1');		
        SIMUTILS        = fullfile('scripts', 'simutils_v1');
    end
    
    methods (Access = private)
        function obj = PathMgr
            %disp('Creating new PathMgr instance')
        end
    end
    
    methods

        function activateSource(self)
        % DSPLOGIC / PathMgr.getInstance.activateSource
        %----------------------------------------------------------
        % Description: Modifies Matlab path to activate blocket
        % from source tree
            if ~exist('dsphdl_blocks','file')
                self.activate(1, 'src', true)
            end
        end
        
        function deactivateSource(self)
        % DSPLOGIC / PathMgr.getInstance.deactivateSource
        %----------------------------------------------------------
        % Description: Modifies Matlab path to deactivate blocket
        % from source tree
        
            if exist('dsphdl_blocks','file')
                self.activate(0, 'src', true)
            end
            
        end

        function paths = getSrcPaths(self)
            srcroot = self.getDsphdlRoot;
            paths = {};
            paths{end+1} = fullfile(srcroot);
            paths{end+1} = fullfile(srcroot, self.MAIN,     'src');
            paths{end+1} = fullfile(srcroot, self.UTILS,    'src');
            paths{end+1} = fullfile(srcroot, self.TYPES,    'src');
            paths{end+1} = fullfile(srcroot, self.MATH,     'src');
            paths{end+1} = fullfile(srcroot, self.ROUTE,    'src');
            paths{end+1} = fullfile(srcroot, self.CONTROL,  'src');
            paths{end+1} = fullfile(srcroot, self.DSP,      'src');
            paths{end+1} = fullfile(srcroot, self.HDLGEN,   'src');
            paths{end+1} = fullfile(srcroot, self.SIMUTILS, 'src');
        end
        
        
    end
    
    methods (Static)
        
        function singleObj = getInstance
            %: Implement singleton instance
            persistent localObj
            if isempty(localObj) || ~isvalid(localObj)
                localObj = PathMgr;
            end
            singleObj = localObj;
        end
        
        function root = getDsphdlRoot
            %: Get root directory using using path of this file
            %: Assumes that this file is in root directory
            [root,~,~] = fileparts(mfilename('fullpath'));
        end       

        % function parentPath = getParentPath(path, nlevels)
        %     NEED TO MAKE GENERIC FOR FILE OR PATH BEFORE USING
        %     if nargin < 2
        %         nlevels= 1;
        %     end
        %     % Get parent path of file or path
        %     [root,~,~] = fileparts(path);
        % 
        %     %: and going up 3 levels
        %     parts = strsplit(root, filesep);
        %     parentPath = strjoin(parts(1:end-nlevels), filesep);
        % 
        % end       
        
    end
    
    methods (Access= private)
        
        function activate(self, varargin)
        %: Activate Path
        
            p = inputParser;
            p.StructExpand = false;
            p.addOptional ('onoff', true );
            p.addOptional ('code',       'src',  @(x) any(validatestring(x,{'src','dist'}) ));
            p.addOptional ('rehashpath', true );
            p.parse(varargin{:});
            a         = p.Results;
            
                
            switch a.code
                case 'src'
                    paths = self.getSrcPaths;
                    
                case 'dist'
                    error('dist is not supported')
                    
                otherwise
                    error('Invalid code type.  use ''''src'''' or ''''dist'''' )')
            end

            if logical(a.onoff)
                for k = 1:length(paths)
                    addpath( paths{k} )
                end
            else
                for k = 1:length(paths)
                    rmpath( paths{k} )
                end
            end
            
            if logical(a.rehashpath)
                rehash TOOLBOXCACHE
            end
            
        end
               
    end
end




