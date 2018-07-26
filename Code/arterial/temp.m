for i=18:18
    calTable = arterialProcess( i,250,60,0.005,0.01,1000);
    xlswrite('.\arterial\wa',calTable,num2str(i));
end
