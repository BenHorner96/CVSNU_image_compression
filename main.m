img = imread('data/img3.png');
img = rgb2gray(img);

% step 1: smooth the image
img1 = imgaussfilt(img, 2);
img2 = roundImage(img, 10);
img3 = imsharpen(img, 'Radius', 2, 'Amount', 1, 'Threshold', 0.5);
img4 = imfilter(img, fspecial('unsharp'));
imshow(imresize([img1 img2 img3 img4], 2))

%img = round(rand(20, 20).*255);
%img = [1 2 1 3; 4 1 2 1; 8 8 8 9];

tic
[a b c d] = compress(img,10)
toc

imshow([img, decompress(a,b,c,d)]);
