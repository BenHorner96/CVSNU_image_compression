function s = totalSize(d,c)
s = size(c,1);
for i = 1:size(d,1)
    s = s+size(d{i,2},2);
end
s = s + (log2(size(d,1)))*(3+size(d,1)) + log2(log2(size(d,1)));
s = s/8;
