function funcName = createComponentInitScript(name, style, outDir)
% CREATECOMPONENTINITSCRIPT Creates component initialization script
%
% Inputs:
%   name: component name
%   style: initialization script style
%       'timed': For timed modesl
%
arguments
    name (1,:) char
    style (1,1) string {mustBeMember(style,{'timed','hdl'})} = 'timed'
    outDir (1,:) char = '.'
end

if strcmp(style, 'timed')
    template = 'TimedInitScriptTemplate.m';
else
    error('Only timed style is supported')
end

% Get template relative to this file
templatePath = mfilename('fullpath');
templatePath = fullfile(fileparts(templatePath), 'templates', template);
templateText = fileread(templatePath);

% Replace COMPONENT_NAME with actual component name
templateText = strrep(templateText, 'COMPONENT_NAME', name);

% Write to file
funcName = [name,'_init'];
outPath = fullfile(outDir, [funcName,'.m']);
fid = fopen(outPath, 'w');
if fid == -1
    error('Failed to open file for writing: %s', outPath);
end
fprintf(fid, '%s', templateText);
fclose(fid);

end

