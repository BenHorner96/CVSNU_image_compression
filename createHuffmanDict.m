function [huffDict, comp] = createHuffmanDict(img, dict)
s = 256+size(dict,1);
%{
if(min(dict(1,:)) < 0)
    s = s - min(dict(:,1));
end
%}
counts = zeros(s,1);

img = img + 1;
dict = dict + 1;

for i = 1:size(img,2)
    counts(img(i)) = counts(img(i)) + 1;
end

for i = 1:size(dict,1)
    counts(dict(i,2)) = counts(dict(i,2)) + 1;
    if(dict(i,1) <= 0)
        counts(s + dict(i,1)) = counts(s + dict(i,1)) + 1;
    else
        counts(dict(i,1)) = counts(dict(i,1)) + 1;
    end
end
img = img - 1;
dict = dict - 1;
%{
if(min(dict(:,1) < 0))
    counts = [counts((s+min(dict(:,1))+1:end));counts(1:s+min(dict(:,1)))];
end
%}

counts = counts(counts~=0);

total = size(img,2) + numel(dict);
probs = counts / sum(counts);

sig = [img';dict(:)];
symbols = unique(sig);

huffDict = huffmandict(symbols,probs);
comp = huffmanenco(sig,huffDict);

end





        
    