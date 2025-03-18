function openModelProject(projectFolder, forceClose)
%OPENMODELPROJECT Open Model Project
%   Open model project
arguments
    projectFolder (1,:) char
    forceClose (1,1) logical = false

end

% Convert to absolute path
projectFolder = GetFullPath(projectFolder);

% Check for open project
try
    proj = currentProject();
    if ~isempty(proj)
        if strcmp(proj.RootFolder, projectFolder)
            fprintf('Project already open\n')
            return
        else
            if forceClose
                fprintf('Closing current project\n')l
                closeProject(proj);
            else
                % Ask user
                answer = questdlg('Close current project?', 'Close Project', 'Yes', 'No', 'No');
                if strcmp(answer, 'Yes')
                    fprintf('Closing current project\n')
                    closeProject(proj);
                else
                    return
                end
            end
        end
    end

catch
    % No project open

    if ~exist(projectFolder, 'dir')
        fprintf('ERROR: Project folder %s does not exist\n', projectFolder)
        return
    end
    
    proj = openProject(projectFolder);
    fprintf('Opened project %s\n', proj.Name)

end


