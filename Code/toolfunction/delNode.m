function [lossRatioTable,success]=delNode(casedata)
%���������ڼ���ɾȥһ����Ϊ1�Ľڵ�������
%casedata�Ǵ��밸����lossRatioTable�������
%success�����е����㷨�Ƿ񶼳ɹ���ֻҪ�в��ɹ��߼�Ϊ0��ȫ�ɹ���Ϊ1
%% ���������ʽ
myMpc = loadcase(casedata);
mpopt = mpoption('pf.alg', 'NR', 'pf.tol', 1e-4,'pf.nr.max_it',20,'out.all',0);%���������ʽ

%% ɾ��
degreeTable=getDegree(myMpc);                           %�õ��ȱ�
balanceNum= myMpc.bus(myMpc.bus(:,2)==3,1);             %���ƽ��ڵ�
oneDegree=degreeTable(degreeTable(:,2)==1,1);           %�ҵ���Ϊ1�Ľڵ�
oneDegree(oneDegree==balanceNum)=[];                    %��ƽ��ڵ�ȥ��
lossRatioTable=zeros(size(oneDegree,1),2);              %��ʼ���������Ӧ��ȥƽ��ڵ��Ķ�Ϊ1�Ľڵ�
success=1;                                              %success��ʼ��Ϊ1
for i=1:size(oneDegree,1)
    temp=myMpc.bus(myMpc.bus(:,1)==oneDegree(i,1),:);               %���˽ڵ���ʱɾȥ
    myMpc.bus(myMpc.bus(:,1)==oneDegree(i,1),:)=[];
    %�������˽ڵ��֧·��ʱɾȥ
    if isempty(find(myMpc.branch(:,1)==oneDegree(i,1), 1))~=1       
       temp1=myMpc.branch(myMpc.branch(:,1)==oneDegree(i,1),:);
       myMpc.branch(myMpc.branch(:,1)==oneDegree(i,1),:)=[];
    else
       temp1=myMpc.branch(myMpc.branch(:,2)==oneDegree(i,1),:);
       myMpc.branch(myMpc.branch(:,2)==oneDegree(i,1),:)=[];
    end
    if isempty(find(myMpc.gen(:,1)==oneDegree(i,1), 1))==0          %�˽ڵ��ǲ��Ƿ���ڵ㣬������ʱɾȥ
        temp2=myMpc.gen(myMpc.gen(:,1)==oneDegree(i,1),:);
        myMpc.gen(myMpc.gen(:,1)==oneDegree(i,1),:)=[];
    end
    [result,su]=runpf(myMpc,mpopt);
    if su~=1 
        success=0;
    end
    lossP=sum(abs(result.branch(:,14)+result.branch(:,16)));%��������
    lossRatio=lossP/sum(result.gen(:,2)); 
    lossRatioTable(i,1)=oneDegree(i,1);
    lossRatioTable(i,2)=lossRatio;    %��¼������
    %�ָ��ֳ�
    myMpc.bus=[myMpc.bus;temp];
    myMpc.branch=[myMpc.branch;temp1];
    myMpc.gen=[myMpc.gen;temp2];
end
[result,su]=runpf(myMpc,mpopt);
if su~=1 
    success=0;
end
lossP=sum(abs(result.branch(:,14)+result.branch(:,16)));%��������
lossRatio=lossP/sum(result.gen(:,2)); 
lossRatioTable=[lossRatioTable;-1,lossRatio];   


