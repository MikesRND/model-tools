function proj = createModelProject(name, opts)
%CREATEMODELPROJECT Create new model project
%   Creates a new model project from scratch.  It must not exist.
arguments
    name (1,:) char
    opts.projectFolder (1,:) char = '.'
end

 proj = matlab.project.createProject('Folder',opts.projectFolder,'Name',name);


