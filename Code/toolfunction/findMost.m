function [ value , percent ] = findMost( vector )
%   �ҵ�������Ƶ������һ��������ֵ��Ƶ��
%   vector�����������
%   value��Ƶ������ֵ��percent��Ƶ��
table=tabulate(vector);
percent=max(table(:,3));
[row,~]=find(table==percent);
value=table(row,1);
end

