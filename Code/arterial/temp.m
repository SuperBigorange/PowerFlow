for i=7:18
    for j=1:10
        txt=strcat('A',num2str((j-1)*(floor(i/2)+2)+1));
        calTable = arterialProcess( i,200,100,0.005,0.01,1000);
        xlswrite('.\arterial\analysis',calTable,num2str(i),txt);
    end
end
