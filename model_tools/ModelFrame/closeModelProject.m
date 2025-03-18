function closeModelProject(forceClose)
%CLOSEPROJECT Close Project
%   Closes any currently open project
arguments
    forceClose (1,1) logical = true
end

% Check for open project
try
    proj = currentProject();
    if ~isempty(proj)
        if forceClose
            proj.close;
        else
            % Ask user
            answer = questdlg('Close current project?', 'Close Project', 'Yes', 'No', 'No');
            if strcmp(answer, 'Yes')
                proj.close;
            else
                return
            end
        end
    end
catch

end

end