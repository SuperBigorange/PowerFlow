T = zeros(100,3);
for i=1:100
    [lossRatio,U,Y] = randomValue(case300,0.02,0.02)
    T(i,:)=[lossRatio,U,Y];
end
filename = 'delCmp.xlsx';
%xlswrite(filename,T,1)
x = 1:100;
% plot(x,T(:,2));
scatter(x,T(:,2))