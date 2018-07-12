filename = 'delCmp.xlsx';
filename_s = 'delCmpFormat.xlsx';
for sheet = 7:7       %除了case89不能使用该脚本，其他的可以
    del = xlsread(filename,sheet,'A:C');    %A列：删前线损  B列：删去边的序号   C列：删后线损
    gra = xlsread(filename,sheet,'E:F');    %E列：边的源点  F列：边的终点
    dig = xlsread(filename,sheet,'I:I');    %点的度
    dis = xlsread(filename,sheet,'L:L');    %点的距离
    Res = zeros(100,7);  %   边  节点1   节点2   度1  度2    距离1    距离2 
    for i=1:100
        Res(i,1) = del(i,2);
        Res(i,2) = gra(del(i,2),1);
        Res(i,3) = gra(del(i,2),2);
        Res(i,4) = dig(gra(del(i,2),1));
        Res(i,5) = dig(gra(del(i,2),2));
        Res(i,6) = dis(gra(del(i,2),1));
        Res(i,7) = dis(gra(del(i,2),2));
    end
    xlswrite(filename_s,Res,sheet);
end