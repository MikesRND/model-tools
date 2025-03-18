[filepath, filename] = fileparts(mfilename('fullpath'));
addpath(fullfile(filepath,'model_tools','GetFullPath'));
addpath(fullfile(filepath,'model_tools','ModelFrame'));
run(fullfile(filepath,'model_tools','dsphdl','activate_dsphdl.m'));
