filename = 'delCmp.xlsx';
filename_s = 'delCmpFormat.xlsx';
for sheet = 6:6
    del = xlsread(filename,sheet,'A:C');
    gra = xlsread(filename,sheet,'E:F');
    dig = xlsread(filename,sheet,'H:I');
    dis = xlsread(filename,sheet,'K:L');
    Res = zeros(100,7);  %   边  节点1   节点2   度1  度2    距离1    距离2 
    for i=1:100
        Res(i,1) = del(i,2);
        for j=1:length(dig)
            if dig(j,1)==gra(del(i,2),1)
                d1 = dig(j,2);
            end
            if dig(j,1)==gra(del(i,2),2)
                d2 = dig(j,2);
            end
            if dis(j,1)==gra(del(i,2),1)
                s1 = dis(j,2);
            end
            if dis(j,1)==gra(del(i,2),2)
                s2 = dis(j,2);
            end
        end
        Res(i,:) = [del(i,2),gra(del(i,2),1),gra(del(i,2),2),d1,d2,s1,s2];
    end
    xlswrite(filename_s,Res,sheet);
end