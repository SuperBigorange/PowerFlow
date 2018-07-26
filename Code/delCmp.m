%本脚本用于保持图的拓补结构不变，随机生成边的大小进而进行删边处理

n=100;                          %实验次数
usedCase=arterialCase(7,400,100,0.005,0.01);             %采用的案例
rmax=0.005;                      %r电阻的最大值
xmax=0.01;                      %x电感的最大值

%T的第一列是原线损，第二列是删边后最接近原线损的那一次所删除的边的序号，第三列是所对应的线损
T = zeros(n,3);
for i=1:n
    [lossRatio,U,Y] = randomValue(usedCase,rmax,xmax);
    T(i,:)=[lossRatio,U,Y];
end
%filename = 'delCmp.xlsx';
%xlswrite(filename,T,1)
x = 1:n;      %画图
% plot(x,T(:,2));
scatter(x,T(:,2))