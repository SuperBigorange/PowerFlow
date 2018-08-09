function [ num , deviation ] = findClost( vector , position )
%   找到向量中离标准值最接近的一个，返回值和误差
%   vector是输入的向量，position为标准值所在的位置
%   num是最接近的值所在的位置，deviation是误差
if position==-1
    position=length(vector);
end
ref=vector(position);
num=-1;
deviation=1;
for i=1:length(vector)
    if i==position 
        continue
    end
    if abs(vector(i)-ref)/ref<deviation
        deviation=abs(vector(i)-ref)/ref;
        num=i;
    end
end
