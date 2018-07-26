function [lossRatioTable,success]=delNode(casedata)
mpopt = mpoption('pf.alg', 'NR', 'pf.tol', 1e-4,'pf.nr.max_it',20,'out.all',0);%���������ʽ
degreeTable=getDegree(casedata);                        %�õ��ȱ�
balanceNum= casedata.bus(casedata.bus(:,2)==3,1);       %���ƽ��ڵ�
oneDegree=degreeTable(degreeTable(:,2)==1,1);           %�ҵ���Ϊ1�Ľڵ�
oneDegree(oneDegree==balanceNum)=[];                    %��ƽ��ڵ�ȥ��
lossRatioTable=zeros(size(oneDegree,1),2);              %��ʼ���������Ӧ��ȥƽ��ڵ��Ķ�Ϊ1�Ľڵ�
success=1;                                              %success��ʼ��Ϊ1
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
    lossP=sum(abs(result.branch(:,14)+result.branch(:,16)));%��������
    lossRatio=lossP/sum(result.gen(:,2)); 
    lossRatioTable(i,1)=oneDegree(i,1);
    lossRatioTable(i,2)=lossRatio;    %��¼������
    casedata.bus=[casedata.bus;temp];
    casedata.branch=[casedata.branch;temp1];
end
[result,su]=runpf(casedata,mpopt);
if su~=1 
    success=0;
end
lossP=sum(abs(result.branch(:,14)+result.branch(:,16)));%��������
lossRatio=lossP/sum(result.gen(:,2)); 
lossRatioTable=[lossRatioTable;-1,lossRatio];   

%nodeNum=size(casedata.bus,1);

