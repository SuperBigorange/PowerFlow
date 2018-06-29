function printDegree=getDegree(casedata)
myMpc=loadcase(casedata);
[busRaw,busCol]=size(myMpc.bus);
[branchRaw,branchCol]=size(myMpc.branch);
printDegree(busRaw,2)=zeros;
printDegree(:,1)=myMpc.bus(:,1);
order(myMpc.bus(busRaw,1),1)=zeros;

for i=1:busRaw
    order(myMpc.bus(i,1))=i;
end

for j=1:branchRaw
        printDegree(order(myMpc.branch(j,1)),2)=printDegree(order(myMpc.branch(j,1)),2)+1;
        printDegree(order(myMpc.branch(j,2)),2)=printDegree(order(myMpc.branch(j,2)),2)+1;
end
