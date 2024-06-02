function asciiString = binary_array_to_ascii(arr)
    
    % Ensure the length of arr is a multiple of 8
    while mod(length(arr), 8) ~= 0
        arr(end) = [];
        %error('La longitut del missatge rebut es de mida diferent a 8.');
    end
    
    % Reshape the array into a matrix with 8 columns
    binaryMatrix = reshape(arr, 8, [])';
    
    % Initialize an array to hold the decimal values
    decimalValues = zeros(1, size(binaryMatrix, 1));
    
    % Convert each row of the binary matrix to a decimal value
    for i = 1:size(binaryMatrix, 1)
        binaryString = num2str(binaryMatrix(i, :));
        decimalValues(i) = bin2dec(binaryString);
    end
    
    % Convert the array of decimal values to an ASCII string
    asciiString = char(decimalValues);
end
