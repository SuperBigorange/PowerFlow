%���ű����ڱ���ͼ���ز��ṹ���䣬������ɱߵĴ�С��������ɾ�ߴ���

n=100;                          %ʵ�����
usedCase='case145';             %���õİ���
rmax=0.01;                      %r��������ֵ
xmax=0.01;                      %x��е����ֵ

%T�ĵ�һ����ԭ���𣬵ڶ�����ɾ�ߺ���ӽ�ԭ�������һ����ɾ���ıߵ���ţ�������������Ӧ������
T = zeros(n,3);
for i=1:n
    [lossRatio,U,Y] = randomValue(usedCase,rmax,xmax);
    T(i,:)=[lossRatio,U,Y];
end
filename = 'delCmp.xlsx';
xlswrite(filename,T,8)
x = 1:n;      %��ͼ
% plot(x,T(:,2));
scatter(x,T(:,2))