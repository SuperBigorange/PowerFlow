function [ num , deviation ] = findClost( vector , position )
%   �ҵ����������׼ֵ��ӽ���һ��������ֵ�����
%   vector�������������positionΪ��׼ֵ���ڵ�λ��
%   num����ӽ���ֵ���ڵ�λ�ã�deviation�����
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
