%% HDL Generation script
% HDLWRITE Generate HDL for module
% 
% Description
%   Generate HDL for module 'dut'.  
%   Code is generated in a repeatable way by removing the HDL
%   coder configuration object and re-setting all non-default 
%   parameters to known values.
% 
%   This script is currently hardcoded for the altera development tool 
%   chain (v15.1)
% 
% Environment variables:
%   TARGET_DIR
%       If set, generated code will be put in this directory
%   
% Inputs: 
% 
%   sys: (str)
%       Target simulink model name
% 
%   dut: (str)
%       Target simuink block name (device under test)
% 
%   NumSamplesToIgnore: int
%       Number of samples to ignore in simulation.  0 if not provided
% 
%   TestBenchSimTime: double
%       Testbench duration (seconds)
% 
%   ModuleNamePrefix: str
%       Module name prefix used for all generated files.
%
% Author: Mike Babst <mike.babst@dsplogic.com>
%
% -------------------------------------------------------------------------
% Copyright (c) 2005-2025 DSPlogic, Inc.
% Distributed under the terms of the Simplified BSD License.
% The full license is in the file LICENSE, distributed with this software.
% -------------------------------------------------------------------------

%% Set target directory
if getenv('TARGET_DIR')
    TargetDirectory = getenv('TARGET_DIR');
    disp(['Setting target dir from make: ' TargetDirectory]);
else
    if ~exist('TargetDirectory','var')    
        [~, topName, ~] = fileparts(dut);
        %TargetDirectory = ['../../hdl/' topName '/hdl']; 
        TargetDirectory = '../hdl'; 
    end
end

if ~exist(TargetDirectory,'dir')
    mkdir(TargetDirectory)
end

%% Configuration Parameters
language = 'VHDL'; % or 'Verilog';

%% Number of *samples* to ignore in HDL testbench due to uninitialized RAMS, registers, etc.
if exist('NumSamplesToIgnore','var')
    IgnoreDataChecking = NumSamplesToIgnore;
else
    IgnoreDataChecking = 0;
end    

%
if exist('TestBenchSimTime','var')
    set_param(sys, 'StopTime', num2str(TestBenchSimTime))
end    


%% Set up Xilinx Tools
% Note: Rely on user to set up tool path
%hdlsetuptoolpath('ToolName', 'Altera Quartus II', ...
%                       'ToolPath', 'C:\altera\15.1\quartus\bin64\quartus.exe');

%% Re-Init HDL defaults
hdlrestoreparams(dut)
%: After restoring the default parameters, the following command 
%: should return only the HDLSubsystem parameter.
% hdlsaveparams(dut)
hdlset_param(sys,'HDLSubsystem', dut)


%% Set xilinx target

hdlset_param(sys,'workflow', 'Generic ASIC/FPGA')
hdlset_param(sys,'SynthesisTool','Xilinx Vivado')
hdlset_param(sys,'SynthesisToolChipFamily','Zynq UltraScale+ RFSoC')
hdlset_param(sys,'SynthesisToolDeviceName','xczu28dr-ffvg1517-2-e')

%: Enables generation of scripts for third-party synthesis tool
%:   Related parameters: HDLSynthCmd, HDLSynthInit, HDLSynthTerm, HDLSynthFilePostfix
hdlset_param(sys, 'HDLSynthTool', 'Vivado');

%: Generate web view
%hdlset_param(sys, 'GenerateWebview', 'on');

%% HDL Parameters
%

% Set module prefix
if exist('ModuleNamePrefix','var')
    hdlset_param(sys, 'ModulePrefix', ModuleNamePrefix)
end    

% Set output language
hdlset_param(sys,'TargetLanguage',language)

% Set target directory
hdlset_param(sys,'TargetDirectory', TargetDirectory)

%: Minimize Intermediate Signals
hdlset_param(sys,'MinimizeIntermediateSignals','on');

%: Generate parameterized HDL code from masked subsystem
%hdlset_param(sys,'MaskParameterAsGeneric', 'on');

%: Turn off timestamp in header
hdlset_param(sys,'DateComment','off');

%: Minimize Clock Enables
hdlset_param(sys,'MinimizeClockEnables', 'on');

%: Inline Matlab Function block code to reduce number of files
hdlset_param(sys,'InlineMATLABBlockCode', 'on');

%: Insert header
hdr='\n GOVERNMENT PURPOSE RIGHTS\n \n Contract No.: HC1084-18-C-0002\n Contractor Name: Viasat, Inc.\n Contractor Address: 6155 El Camino Real, Carlsbad, CA 92009\n Expiration Date: 26 September 2024\n \n The Government''s rights to use, modify, reproduce, release, perform,\n display, or disclose this software are restricted by paragraph (b)(2) of\n the Rights in Noncommercial Computer Software and Noncommercial Computer\n Software Documentation clause contained in the above identified contract.\n No restrictions apply after the expiration date shown above.  Any\n reproduction of the software or portions thereof marked with this legend\n must also reproduce the markings.\n \n Distribution Statement D: Distribution authorized to the Department of\n Defense (DoD) and U.S. DoD contractors only by specific authority of Army\n Regulation (AR) 380-5 for administrative and operational use. Date of\n determination is the approval date of this document. Other requests for\n this document shall be referred to the Office of the Product Manager\n (PdM) JBC-P, SFAE-CCC-MCJ, 6007 Combat Drive, Aberdeen\n';
hdlset_param(sys,'UserComment', hdr);

%: Customize filename postfix for multiple modules.
hdlset_param(sys,'EntityConflictPostfix', '_b');

%: Number of output samples to ignore in testbench
hdlset_param(sys,'IgnoreDataChecking', IgnoreDataChecking);

%: Turn off reset init script - causes problem with generated script only
%: supporting Modelsim 10.2 or greater
%: hdlset_param(sys, 'GenerateNoResetInitScript', 'off')

%: Add quit statements to simulation scripts so they can be run from the
%  command line
hdlset_param(sys, 'HDLSimTerm', ['run -all\n',char(10),'quit -f']);
hdlset_param(sys, 'HDLCompileTerm', 'quit -f');

%% Turn on reports
%hdlset_param(sys, 'GenerateValidationModel','on');
hdlset_param(sys, 'Traceability','on');
hdlset_param(sys, 'OptimizationReport','on');
hdlset_param(sys, 'ResourceReport','on');
hdlset_param(sys, 'OptimizationReport','on');
hdlset_param(sys, 'ErrorCheckReport', 'on');
%hdlset_param(sys, 'CriticalPathEstimation','on');

%% Run user script if defined
if exist('HDLParamScript','var')
    run(HDLParamScript);
end


%% Set up coding standards
if false
    %: Create coding standard object
    industry_standard = 'Industry';
    cso = hdlcoder.CodingStandard(industry_standard);
    %: Do not show passing rules in the coding standard report.
    cso.ShowPassingRules.enable = false;
    %: Apply coding standards to model
    hdlset_param(sys,'HDLCodingStandard', industry_standard);
    hdlset_param(sys,'HDLCodingStandardCustomizations', cso);

end

%: Save
hdlsaveparams(dut, [TargetDirectory '/HDL_Config_Settings.m'], 'force_overwrite')

%% Finally, fun HDL generation
makehdl(dut)

%% Clean HDL code comments for maintainability and diffing
hdldir = [TargetDirectory '/' sys];
genResults = load([ hdldir '/hdlcodegenstatus.mat']);
Nfiles = length(genResults.GenFileList);
files = cell(1,Nfiles);
for k=1:Nfiles
   files{k} = [hdldir '/' genResults.GenFileList{k}]; 
end

%% Remove HDL Coder comments from file
% By default, comments will not be removed.
% Define 'CleanupComments' to set.
if exist('CleanupComments','var')
    if ~strcmpi(CleanupComments, 'RemoveAll')
        cleanHdlcoderComments(files, true)
    end
end  

%% Make HDL Testbench
makehdltb(dut)


