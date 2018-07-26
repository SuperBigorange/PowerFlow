function [ num , deviation ] = findClost( vector , position )
%FINDCLOST 此处显示有关此函数的摘要
%   此处显示详细说明
if position==-1
    position=length(vector);
end
ref=vector(position);
num=-1;
deviation=1;
for i=1:size(vector)
    if i==position 
        continue
    end
    if abs(vector(i)-ref)/ref<deviation
        deviation=abs(vector(i)-ref)/ref;
        num=i;
    end
end

