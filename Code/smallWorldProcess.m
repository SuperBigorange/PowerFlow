function table=smallWorldProcess(casedata,neighbNum,p,Rm,Xm,n)
table=zeros(n,6);
for i=1:n
    [branchTable,branchMFit,degreeTable,disTable] = smallWorldNet(casedata,neighbNum,p,Rm,Xm);
    table(i,1:2)=branchTable(branchMFit,1:2);
    nodeNum1=find(degreeTable(:,1)==branchTable(branchMFit,1));
    nodeNum2=find(degreeTable(:,1)==branchTable(branchMFit,2));
%     [degreeMax,~]=max(max(degreeTable(:,2)));
%     [disMax,~]=max(max(disTable(:,2)));
    table(i,3)=degreeTable(nodeNum1,2);
    table(i,4)=degreeTable(nodeNum2,2);
    table(i,5)=disTable(nodeNum1,2);
    table(i,6)=disTable(nodeNum2,2);
end