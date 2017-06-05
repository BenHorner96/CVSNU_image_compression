function [compressedImg, dict, width, height] = compress(img, threshold)
% compresses the image by finding repeating patterns and replacing the
% patterns by values of a dictionary.
% img: grayscale image to be compressed
% threshold: at least that many pairs must exist for the pair to be
% replaced
% compressedImg: the compressed image as a vector
% dict: the dictionary containing the patterns as a 2xN matrix in the form
%       element1 element2
%       whereas the position of the matrix indicates the element number
%       (starting with 256).
% width, height: dimensions of original image, needed to decompress

[height, width] = size(img);
compressedImg = double(reshape(img.', 1, []));
dict = [];
prevDictSize = -1;

% while the dictionary is growing, meaning while there are still potential 
% pairs to be replaced
while size(dict, 1) > prevDictSize
    prevDictSize = size(dict, 1);
    i = 1;
    while i < size(compressedImg, 2)
        currentPair = [compressedImg(i), compressedImg(i+1)];
        positionsThatHaveThisPair = [i];
        j = 3; % starting at 3 because we already have the first pair and want it to compare to every other pair
        while j < size(compressedImg, 2)
            if isequal(currentPair, [compressedImg(j), compressedImg(j+1)])
                positionsThatHaveThisPair = [positionsThatHaveThisPair, j];
                j = j + 1; % increase j because we don't want overlaps if we already found a pair
            end
            j = j + 1;
        end
        key = size(dict, 1) + 256;
        i = i + 1;
        if (size(positionsThatHaveThisPair, 2) >= threshold)
            dict = [dict; currentPair];
            i = 1;
            for k = 1:size(positionsThatHaveThisPair, 2)
                pos = positionsThatHaveThisPair(k);
                compressedImg(pos) = key;
                compressedImg(pos + 1) = NaN; % set to NaN so we can remove it later
            end
            compressedImg = compressedImg(~isnan(compressedImg)); % remove the NaNs
        end
    end
end

end

