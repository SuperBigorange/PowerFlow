function printDegree=getDegree(casedata)
%本函数用于获得案例的无向图上各点的度
%printDegree是返回度表，casedata是传入案例

%预处理
myMpc=loadcase(casedata);                   %获取案例
[busRaw,~]=size(myMpc.bus);                 %节点个数
[branchRaw,~]=size(myMpc.branch);           %边的个数
printDegree(:,1)=myMpc.bus(:,1);            %输出表第一列是所有节点序号
printDegree(busRaw,2)=zeros;                %各点度先置零
number(myMpc.bus(busRaw,1),1)=zeros;         %初始化序号
%%
%存下各节点序号
for i=1:busRaw
    number(myMpc.bus(i,1))=i;
end

for j=1:branchRaw
        printDegree(number(myMpc.branch(j,1)),2)=printDegree(number(myMpc.branch(j,1)),2)+1;
        printDegree(number(myMpc.branch(j,2)),2)=printDegree(number(myMpc.branch(j,2)),2)+1;
end
