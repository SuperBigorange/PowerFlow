function [lossRatioTable,success]=delNode(casedata)
mpopt = mpoption('pf.alg', 'NR', 'pf.tol', 1e-4,'pf.nr.max_it',20,'out.all',0);%定义迭代方式
degreeTable=getDegree(casedata);                        %得到度表
balanceNum= casedata.bus(casedata.bus(:,2)==3,1);       %获得平衡节点
oneDegree=degreeTable(degreeTable(:,2)==1,1);           %找到度为1的节点
oneDegree(oneDegree==balanceNum)=[];                    %把平衡节点去掉
lossRatioTable=zeros(size(oneDegree,1),2);              %初始化输出表，对应除去平衡节点后的度为1的节点
success=1;                                              %success初始化为1
for i=1:size(oneDegree,1)
    temp=casedata.bus(casedata.bus(:,1)==oneDegree(i,1),:);
    casedata.bus(casedata.bus(:,1)==oneDegree(i,1),:)=[];
    if isempty(find(casedata.branch(:,1)==oneDegree(i,1), 1))~=1
       temp1=casedata.branch(casedata.branch(:,1)==oneDegree(i,1),:);
       casedata.branch(casedata.branch(:,1)==oneDegree(i,1),:)=[];
    else
       temp1=casedata.branch(casedata.branch(:,2)==oneDegree(i,1),:);
       casedata.branch(casedata.branch(:,2)==oneDegree(i,1),:)=[];
    end
    [result,su]=runpf(casedata,mpopt);
    if su~=1 
        success=0;
    end
    lossP=sum(abs(result.branch(:,14)+result.branch(:,16)));%计算线损
    lossRatio=lossP/sum(result.gen(:,2)); 
    lossRatioTable(i,1)=oneDegree(i,1);
    lossRatioTable(i,2)=lossRatio;    %记录到表上
    casedata.bus=[casedata.bus;temp];
    casedata.branch=[casedata.branch;temp1];
end
[result,su]=runpf(casedata,mpopt);
if su~=1 
    success=0;
end
lossP=sum(abs(result.branch(:,14)+result.branch(:,16)));%计算线损
lossRatio=lossP/sum(result.gen(:,2)); 
lossRatioTable=[lossRatioTable;-1,lossRatio];   

%nodeNum=size(casedata.bus,1);

