function closestValue = find_closest_value(arr, x)
    % Calculate the absolute differences between each element in arr and x
    differences = abs(arr - x);
    
    % Find the index of the minimum difference
    [~, index] = min(differences);
    
    % Get the closest value using the index
    closestValue = arr(index);
end