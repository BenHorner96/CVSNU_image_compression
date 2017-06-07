function s = totalSize(d,c)
s = size(c,1);
for i = 1:size(d,1)
    s = s+size(d{i,2},2);
end
s = s + 16*(3+size(d,1));
s = s/8;
