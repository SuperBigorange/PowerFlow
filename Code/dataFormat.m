filename = 'delCmp.xlsx';
filename_s = 'delCmpFormat.xlsx';
for sheet = 8:8
    del = xlsread(filename,sheet,'A:C');
    gra = xlsread(filename,sheet,'E:F');
    dig = xlsread(filename,sheet,'I:I');
    dis = xlsread(filename,sheet,'L:L');
    Res = zeros(100,5);  %   ±ﬂ    ∂»(1)  ∂»£®2£©  æ‡¿Î(1)   æ‡¿Î£®2£© 
    for i=1:100
        Res(i,1) = del(i,2);
        Res(i,2) = dig(gra(del(i,2),1));
        Res(i,3) = dig(gra(del(i,2),2));
        Res(i,4) = dis(gra(del(i,2),1));
        Res(i,5) = dis(gra(del(i,2),2));
    end
    xlswrite(filename_s,Res,sheet);
end