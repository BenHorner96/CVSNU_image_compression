function [dictionary, convert] = DictionaryCompression(img,threshold)
if (ndims(img) == 3)
        img = rgb2gray(img);
end
convert = double(img(:));
convert = convert+1;
dictionary = zeros(1,2);
prev = zeros(3);
%hash = zeros(

while size(convert,1) ~= size(prev,1)
    prev = convert;
    s = 256+size(dictionary,1)-1;
    hash = zeros((s+1)^2,1);
    for i = 1:size(convert,1)-1
        hash(convert(i)*s+convert(i+1)) = hash(convert(i)*s+convert(i+1))+1;
    end
    
    i = 1;
    while(i <= size(convert,1) - 1)
        if(hash(convert(i)*s+convert(i+1)) < -s)
            convert(i) = -hash(convert(i)*s+convert(i+1));
            convert(i+1) = NaN;
            i = i + 2; 
        elseif(hash(convert(i)*s+convert(i+1)) >= threshold)
            code = 256 + size(dictionary,1);
            hash(convert(i)*s+convert(i+1)) = -code;
            dictionary = [dictionary; convert(i), convert(i+1)];
            convert(i) = code;
            convert(i+1) = NaN;
            i = i + 2;
        else
            i = i+1;
        end
    end
    
    convert = convert(~isnan(convert));
end

dictionary = dictionary(2:size(dictionary,1),:) - 1;
convert = convert - 1;

