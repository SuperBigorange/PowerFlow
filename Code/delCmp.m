T = zeros(100,3);       %T�ĵ�һ����ԭ���𣬵ڶ�����ɾ�ߺ���ӽ�ԭ�������һ����ɾ���ıߵ���ţ�������������Ӧ������
for i=1:100
    [lossRatio,U,Y] = randomValue(case300,0.01,0.01)
    T(i,:)=[lossRatio,U,Y];
end
filename = 'delCmp.xlsx';
%xlswrite(filename,T,1)
x = 1:100;      %��ͼ
% plot(x,T(:,2));
scatter(x,T(:,2))