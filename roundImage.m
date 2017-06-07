function roundedImg = roundImage(img, x)
% Rounds the pixels in the grayscale image to a multiple of x
% img: grayscale image
% x: factor to round

[width, height] = size(img);

for i = 1:width
    for j = 1:height
        img(i, j) = round(img(i, j) / x) * x;   
    end
end

roundedImg = img;

end

