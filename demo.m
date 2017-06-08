img = imread('data/img2.png');
%img = rgb2gray(img);
fprintf('=========================================\nImage : cat');

for i = [4,20]
    fprintf('\n------------------------------------------\n');
    tic
    [a b c d e] = compress(img,i,0);
    x = toc;

    figure(2);
    imshow([img, decompress(a,b,c,d,e)]);
    fprintf('Threshold: %d\n',i);
    fprintf('Time to compress: %f\nSize is %d of original\n',x,(size(a,2)+size(b,1)*2)/prod(size(img)));
    fprintf('Dictionary size: %d\nCompressed img size: %d\n', size(b,1),size(a,2));
    
end

fprintf('\n------------------------------------------\n');