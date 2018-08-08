xlsName='.\arterial\analysis1';
for i=7:18
    table=zeros(10,3);
    table(:,1)=1:10;
    for j=1:10
        txta=strcat('A',num2str((j-1)*(floor(i/2)+2)+1));
        txtb=strcat('C',num2str((j)*(floor(i/2)+2)));
        txt=strcat(strcat(txta,':'),txtb);
        calTable = xlsread(xlsName,num2str(i),txt);
        if mod(i,2)==0
            table(j,2)=calTable(2,2)/1000;
            table(j,3)=calTable(2,3);
        else 
            table(j,2)=calTable(1,2)/1000;
            table(j,3)=calTable(2,3);
        end
    end
    txt='E1';
    xlswrite(xlsName,table,num2str(i),txt);
    processedTable={'平均数',mean(table(:,2)),'10000次累加',sum(table(:,2))/10,'误差均数',mean(table(:,3))};
    txt='I1';
    xlswrite(xlsName,processedTable,num2str(i),txt);
    txt=strcat('A',num2str(i-3));
    xlswrite(xlsName,[i,processedTable],'总表',txt);
end