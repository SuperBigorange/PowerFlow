%���ű����ڱ���ͼ���ز��ṹ���䣬������ɱߵĴ�С��������ɾ�ߴ���

n=100;                          %ʵ�����
usedCase=arterialCase(7,400,100,0.005,0.01);             %���õİ���
rmax=0.005;                      %r��������ֵ
xmax=0.01;                      %x��е����ֵ

%T�ĵ�һ����ԭ���𣬵ڶ�����ɾ�ߺ���ӽ�ԭ�������һ����ɾ���ıߵ���ţ�������������Ӧ������
T = zeros(n,3);
for i=1:n
    [lossRatio,U,Y] = randomValue(usedCase,rmax,xmax);
    T(i,:)=[lossRatio,U,Y];
end
%filename = 'delCmp.xlsx';
%xlswrite(filename,T,1)
x = 1:n;      %��ͼ
% plot(x,T(:,2));
scatter(x,T(:,2))