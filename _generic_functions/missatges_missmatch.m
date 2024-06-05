function num_mismatches = missatges_missmatch(arr1, arr2)
    % Check if the input arrays are of the same length
    while length(arr1) ~= length(arr2)
        arr2(end) = [];
    end
    
    % Calculate the number of mismatches
    num_mismatches = sum(arr1 ~= arr2);
end
