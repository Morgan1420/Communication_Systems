function binaryArray = ascii_to_binary_array(asciiString)
    % Convert the char array to an array of binary values
    binaryArray = [];
    for i = 1:length(asciiString)
        binaryArray = [binaryArray dec2bin(asciiString(i), 8) - '0'];
    end
end