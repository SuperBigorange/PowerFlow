function [ num , deviation ] = findClost( vector , position )
%FINDCLOST �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
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

