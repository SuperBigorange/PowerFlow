filename = 'delCmp.xlsx';
filename_s = 'delCmpFormat.xlsx';
for sheet = 7:7       %����case89����ʹ�øýű��������Ŀ���
    del = xlsread(filename,sheet,'A:C');    %A�У�ɾǰ����  B�У�ɾȥ�ߵ����   C�У�ɾ������
    gra = xlsread(filename,sheet,'E:F');    %E�У��ߵ�Դ��  F�У��ߵ��յ�
    dig = xlsread(filename,sheet,'I:I');    %��Ķ�
    dis = xlsread(filename,sheet,'L:L');    %��ľ���
    Res = zeros(100,7);  %   ��  �ڵ�1   �ڵ�2   ��1  ��2    ����1    ����2 
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