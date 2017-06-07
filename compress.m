function [compressedImg, dict, width, height, depth] = compress(img, threshold, option)
% compresses the image by finding repeating patterns and replacing the
% patterns by values of a dict.
% img: grayscale image to be compressed
% threshold: at least that many pairs must exist for the pair to be
% replaced
% compressedImg: the compressed image as a vector
% dict: the dict containing the patterns as a 2xN matrix in the form
%       element1 element2
%       whereas the position of the matrix indicates the element number
%       (starting with 256).
% width, height: dimensions of original image, needed to decompress

[height, width, depth] = size(img);
compressedImg = double(reshape(img, 1, []));
dict = [];
prevDictSize = -1;
compressedImg = compressedImg + 1;

% while the dict is growing, meaning while there are still potential 
% pairs to be replaced
while size(dict, 1) > prevDictSize
    prevDictSize = size(dict,1);
    s = 256+size(dict,1);
    hash = spalloc((s+1)^2,1,size(compressedImg,2));
    for i = 1:size(compressedImg,2)-1
        hash(compressedImg(i)*s+compressedImg(i+1)) = hash(compressedImg(i)*s+compressedImg(i+1))+1;
    end
    
    i = 1;
    while(i <= size(compressedImg,2) - 1)
        if(hash(compressedImg(i)*s+compressedImg(i+1)) < -s)
            compressedImg(i) = -hash(compressedImg(i)*s+compressedImg(i+1));
            compressedImg(i+1) = NaN;
            i = i + 2; 
        elseif(hash(compressedImg(i)*s+compressedImg(i+1)) >= threshold)
            code = 256 + size(dict,1) + 1;
            hash(compressedImg(i)*s+compressedImg(i+1)) = -code;
            if (option == 1)
                if (compressedImg(i) == compressedImg(i+1))
                    dict = [dict; 0, compressedImg(i+1)];
                else
                    dict = [dict; compressedImg(i), compressedImg(i+1)];
                end
            else
                dict = [dict; compressedImg(i), compressedImg(i+1)];
            end
            compressedImg(i) = code;
            compressedImg(i+1) = NaN;
            i = i + 2;
        else
            i = i+1;
        end
    end
    
    compressedImg = compressedImg(~isnan(compressedImg));
end

compressedImg = compressedImg - 1;
dict = dict - 1;

if(option == 1)
    dict = dictionaryReduce(img,dict);
end
