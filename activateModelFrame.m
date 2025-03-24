[filepath, filename] = fileparts(mfilename('fullpath'));
addpath(fullfile(filepath,'src','GetFullPath'));
addpath(fullfile(filepath,'src','ModelFrame'));
run(fullfile(filepath,'src','dsphdl','activate_dsphdl.m'));
