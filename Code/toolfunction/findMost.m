function [ value , percent ] = findMost( vector )
%   找到向量中频数最大的一个，返回值和频率
%   vector是输入的向量
%   value是频数最大的值，percent是频率

table=tabulate(vector);             %计算频数，和占比
percent=max(table(:,3));            %找占比最多的
[row,~]=find(table==percent);       %找到占比大的一行
value=table(row,1);                 %取值返回
end