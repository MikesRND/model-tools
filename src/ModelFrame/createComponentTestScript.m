function scriptName = createComponetTestScript(componentName, opts)
% CREATECOMPONENTTESTSCRIPT Creates initial testbench script
%
%
arguments
    componentName (1,:) char
    opts.style (1,1) string {mustBeMember(opts.style,{'timed','hdl'})} = 'timed'
    opts.outDir (1,:) char = '.'
end

if strcmp(opts.style, 'timed')
    template = 'TimedTestbenchScriptTemplate.m';
else
    template = 'TimedTestbenchScriptTemplate.m';
end

% Get template relative to this file
templatePath = mfilename('fullpath');
templatePath = fullfile(fileparts(templatePath), 'templates', template);
templateText = fileread(templatePath);

% Replace COMPONENT_NAME with actual component name
testbenchName = [componentName,'_tb1'];
templateText = strrep(templateText, 'TESTBENCH_NAME', testbenchName);
templateText = strrep(templateText, 'COMPONENT_NAME', componentName);

% Write to file
scriptName = [componentName,'_tb1_main'];
outPath = fullfile(opts.outDir, [scriptName,'.m']);
fid = fopen(outPath, 'w');
if fid == -1
    error('Failed to open file for writing: %s', outPath);
end
fprintf(fid, '%s', templateText);
fclose(fid);

end

