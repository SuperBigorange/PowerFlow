function [ value , percent ] = findMost( vector )
%   �ҵ�������Ƶ������һ��������ֵ��Ƶ��
%   vector�����������
%   value��Ƶ������ֵ��percent��Ƶ��

table=tabulate(vector);             %����Ƶ������ռ��
percent=max(table(:,3));            %��ռ������
[row,~]=find(table==percent);       %�ҵ�ռ�ȴ��һ��
value=table(row,1);                 %ȡֵ����
end