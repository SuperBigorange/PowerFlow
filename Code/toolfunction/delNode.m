function [lossRatioTable,success]=delNode(casedata)
%本函数用于计算删去一个度为1的节点后的线损
%casedata是传入案例，lossRatioTable是输出表
%success是所有迭代算法是否都成功，只要有不成功者即为0，全成功即为1
%% 定义迭代方式
myMpc = loadcase(casedata);
mpopt = mpoption('pf.alg', 'NR', 'pf.tol', 1e-4,'pf.nr.max_it',20,'out.all',0);%定义迭代方式

%% 删点
degreeTable=getDegree(myMpc);                           %得到度表
balanceNum= myMpc.bus(myMpc.bus(:,2)==3,1);             %获得平衡节点
oneDegree=degreeTable(degreeTable(:,2)==1,1);           %找到度为1的节点
oneDegree(oneDegree==balanceNum)=[];                    %把平衡节点去掉
lossRatioTable=zeros(size(oneDegree,1),2);              %初始化输出表，对应除去平衡节点后的度为1的节点
success=1;                                              %success初始化为1
for i=1:size(oneDegree,1)
    temp=myMpc.bus(myMpc.bus(:,1)==oneDegree(i,1),:);               %将此节点暂时删去
    myMpc.bus(myMpc.bus(:,1)==oneDegree(i,1),:)=[];
    %将包含此节点的支路暂时删去
    if isempty(find(myMpc.branch(:,1)==oneDegree(i,1), 1))~=1       
       temp1=myMpc.branch(myMpc.branch(:,1)==oneDegree(i,1),:);
       myMpc.branch(myMpc.branch(:,1)==oneDegree(i,1),:)=[];
    else
       temp1=myMpc.branch(myMpc.branch(:,2)==oneDegree(i,1),:);
       myMpc.branch(myMpc.branch(:,2)==oneDegree(i,1),:)=[];
    end
    if isempty(find(myMpc.gen(:,1)==oneDegree(i,1), 1))==0          %此节点是不是发电节点，是则暂时删去
        temp2=myMpc.gen(myMpc.gen(:,1)==oneDegree(i,1),:);
        myMpc.gen(myMpc.gen(:,1)==oneDegree(i,1),:)=[];
    end
    [result,su]=runpf(myMpc,mpopt);
    if su~=1 
        success=0;
    end
    lossP=sum(abs(result.branch(:,14)+result.branch(:,16)));%计算线损
    lossRatio=lossP/sum(result.gen(:,2)); 
    lossRatioTable(i,1)=oneDegree(i,1);
    lossRatioTable(i,2)=lossRatio;    %记录到表上
    %恢复现场
    myMpc.bus=[myMpc.bus;temp];
    myMpc.branch=[myMpc.branch;temp1];
    myMpc.gen=[myMpc.gen;temp2];
end
[result,su]=runpf(myMpc,mpopt);
if su~=1 
    success=0;
end
lossP=sum(abs(result.branch(:,14)+result.branch(:,16)));%计算线损
lossRatio=lossP/sum(result.gen(:,2)); 
lossRatioTable=[lossRatioTable;-1,lossRatio];   


