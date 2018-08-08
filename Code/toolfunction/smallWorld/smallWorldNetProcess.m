function table=smallWorldNetProcess(casedata,neighbNum,p,Rm,Xm,n)
txt={'最合适节点1','最合适节点2','度1','度2','最大度','深度1','深度2','最大深度','度1/最大度','度2/最大度','深度1/最大深度','深度2/最大深度'};
table=zeros(n,12);
for i=1:n
    [branchTable,branchMFit,degreeTable,disTable,~] = smallWorldNet(casedata,neighbNum,p,Rm,Xm);
    table(i,1:2)=branchTable(branchMFit,1:2);
    nodeNum1=find(degreeTable(:,1)==branchTable(branchMFit,1));
    nodeNum2=find(degreeTable(:,1)==branchTable(branchMFit,2));
    [degreeMax,~]=max(max(degreeTable(:,2)));
    [disMax,~]=max(max(disTable(:,2)));
    table(i,13)=min(degreeTable(:,2));
    table(i,3)=degreeTable(nodeNum1,2);
    table(i,4)=degreeTable(nodeNum2,2);
    table(i,5)=degreeMax;
    table(i,6)=disTable(nodeNum1,2);
    table(i,7)=disTable(nodeNum2,2);
    table(i,8)=disMax;
end
table(:,9)=table(:,3)./table(:,5);
table(:,10)=table(:,4)./table(:,5);
table(:,11)=table(:,6)./table(:,8);
table(:,12)=table(:,7)./table(:,8);

xlswrite('.\smallWorld\smallWorld',txt,casedata,'A1');
xlswrite('.\smallWorld\smallWorld',table,casedata,'A2');