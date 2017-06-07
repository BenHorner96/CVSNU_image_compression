datadir = 'data';

imglist = dir(sprintf('%s/*.png', datadir));


for j = 1:1
    fprintf('==================================================\n');
    fprintf('Image: %s\n',imglist(j).name);
    img = imread(sprintf('%s/%s', datadir, imglist(j).name));
    for i = 2:10

        tic
        [a b c d e] = compress(img,i,0);
        x = toc;

        tic
        pp = decompress(a,b,c,d,e);
        y = toc;
        
        %figure(2);
        %imshow([img, decompress(a,b,c,d,e)]);
       % fprintf('-----------------------------------\n');
        fprintf('%f\t%f\t',x,(size(a,2)+size(b,1)*2)/prod(size(img)));
        fprintf('%f\n',y);
    end
    
end