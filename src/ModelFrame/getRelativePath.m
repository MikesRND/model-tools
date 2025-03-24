function getRelativePath = getRelativePath(subPath, rootPath)

    % Compare a subPath of a rootPath.
    % If the subPath is a subdirectory of the rootPath, return the relative path as a cell array of strings.
    % If the subPath is not a subdirectory of the rootPath, return an empty cell array.

    if ~exist(subPath, 'dir')
        error('Path %s does not exist.', subPath);
    end
    
    if ~exist(rootPath, 'dir')
        error('Path %s does not exist.', rootPath);
    end


    % Convert paths to absolute paths
    rootPath = what(rootPath).path;
    subPath = what(subPath).path;


    % Check if subPath starts with rootPath
    if strcmp(subPath, rootPath)
        relativePath = {};
    elseif startsWith(subPath, rootPath)
        % Remove the rootPath part from subPath
        relativePathStr = strrep(subPath, [rootPath filesep], '');
        % Split the relative path into parts
        relativePath = strsplit(relativePathStr, filesep);
    else
        % Return an empty cell array if subPath is not a subdirectory of rootPath
        relativePath = {};
    end

end