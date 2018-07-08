T = zeros(100,3);       %T的第一列是原线损，第二列是删边后最接近原线损的那一次所删除的边的序号，第三列是所对应的线损
for i=1:100
    [lossRatio,U,Y] = randomValue(case300,0.01,0.01)
    T(i,:)=[lossRatio,U,Y];
end
filename = 'delCmp.xlsx';
%xlswrite(filename,T,1)
x = 1:100;      %画图
% plot(x,T(:,2));
scatter(x,T(:,2))