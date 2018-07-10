function [lossRatio,branchMFit,closestLossRatio,lossRatioTable]=delSide(casedata)
%���������ڼ���ɾȥһ���ߺ�ͼ�Ա�����ͨ��������
%casedata�����밸����lossRatio��ԭ����branchMFit��ɾȥ�������Ӱ����С�ıߺ�
%closestLossRatio��ɾȥ��Ӱ����С�������С��lossRatioTable��ɾȥ���ߵ���������һ��Ԫ����ԭ����

%����ɾһ���ߺ�
mpopt = mpoption('pf.alg', 'NR', 'pf.tol', 1e-4,'pf.nr.max_it',20,'out.all',0);%���������ʽ
myMpc = loadcase(casedata);             %��ȡ����
[branchRaw,~]=size(myMpc.branch);       %���֧·��
lossRatioTable(branchRaw+1,1)=zeros;    %��¼ɾ�ߺ�������ԭ����
for i=1:branchRaw
    myMpc.branch(i,11)=0;               %������֧·�ص�
    [result,success]=runpf(myMpc,mpopt);%Ӧ�ó����㷨
    if success==1                       %��ɾȥ��ͼ����ͨ
        lossP=sum(abs(result.branch(:,14)+result.branch(:,16)));%��������
        lossRatio=lossP/sum(result.gen(:,2)); 
        lossRatioTable(i)=lossRatio;    %��¼������
    else
        lossRatioTable(i)=-1;           %�����ģ�����ͨʱ������-1����ô�����Ͻ�
    end
    myMpc.branch(i,11)=1;               %������֧·���´�
end
%%
%����ԭ����
result=runpf(myMpc,mpopt);
lossP=sum(result.branch(:,14)+result.branch(:,16));
lossRatio=lossP/sum(result.gen(:,2));
lossRatioTable(branchRaw+1)=lossRatio;  %�ڱ����ԭ����

minDvalue(branchRaw)=zeros; %minDvalue��������ɾ�ߺ��������ԭ�����ֵ�ľ���ֵ
for j=1:branchRaw
    minDvalue(j)=abs(lossRatio-lossRatioTable(j));
end

[~,branchMFit]=min(minDvalue);   %�ҳ���ֵ����Сֵ��branchMFit��¼��Ӧ���к�
closestLossRatio=lossRatioTable(branchMFit);    %�ҳ���Ӧ��ԭ����


 