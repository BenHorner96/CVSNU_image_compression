function img = decompress(compressedImg, dict, width, height, depth)
% decompresses the image
% compressedImg: return value of compress()
% dict: return value of compress()
% width, heigth: the dimensions of the original image

img = [];

i = 1;
while i <= size(compressedImg, 2)
    imgPart = expandCode(compressedImg(i), dict);
    img = [img, imgPart];
%     tmp = [compressedImg(i)];
%     j = 1;
%     while j <= size(tmp, 2)
%         if tmp(j) > 255
%             key = tmp(j) - 255;
%             tmp(j) = dict(key, 1);
%             tmp(j + 1) = dict(key, 2);
%         else
%             j = j + 1;
%         end
%     end
%     img = [img, tmp];
    i = i + 1;
end

img = reshape(img, height, width,depth);
img = uint8(img);

end
