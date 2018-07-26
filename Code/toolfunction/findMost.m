function [ value , percent ] = findMost( vector )
%   找到向量中频数最大的一个，返回值和频率
%   vector是输入的向量
%   value是频数最大的值，percent是频率
table=tabulate(vector);
percent=max(table(:,3));
[row,~]=find(table==percent);
value=table(row,1);
end

