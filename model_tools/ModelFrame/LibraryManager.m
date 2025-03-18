classdef LibraryManager
    properties
        libRoot
    end
    
    methods
        function obj = LibraryManager(libRoot)
            arguments
                libRoot char = getenv('MODEL_LIB_ROOT')
            end

            if isempty(libRoot)
                error('Model library root must be provided or set in the environment variable MODEL_LIB_ROOT.');
            end

            if exist(libRoot,"dir")
                % Convert to absolute path
                libRoot = what(libRoot).path;
            else
                error('The provided model library root path does not exist: %s', libRoot);
            end
            
            obj.libRoot = libRoot;
        end
                
        function root = getRoot(obj)
            root = obj.libRoot;
        end
        
        function createComponentFolder(obj, componentName, parentLibName)
            arguments
            obj
            componentName char
            parentLibName char = ""
            end
            
            parentLibName = obj.getParentLibName(parentLibName);
            
            libPath = fullfile(obj.libRoot, parentLibName);
            if ~exist(libPath, 'dir')
            error('Library %s does not exist in the model library root.', parentLibName);
            end
            
            componentPath = fullfile(libPath, componentName);
            if exist(componentPath, 'dir')
            error('Component %s already exists in the library %s.', componentName, parentLibName);
            end
            
            mkdir(componentPath);
            mkdir(fullfile(componentPath, 'mdl'));
            mkdir(fullfile(componentPath, 'tst'));
            
            fprintf('Component %s created in library %s.\n', componentName, parentLibName);
        end
        
        function parentLibName = getParentLibName(obj)
            
            currentPath = pwd;
            relativePath = strrep(obj.libRoot, currentPath, '');
            pathParts = strsplit(relativePath, filesep);
            
            if numel(pathParts) < 2 || isempty(pathParts{2})
                error('Parent library name cannot be inferred.');
            end
            
            parentLibName = pathParts{2};

        end


    end
end
