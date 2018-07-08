function [lossRatio,U,Y,lossRatioTable]=delSide(casedata)
myMpc = loadcase(casedata);
mpopt = mpoption('pf.alg', 'NR', 'pf.tol', 1e-4,'pf.nr.max_it',20);%���������ʽ
[branchRaw,branchCol]=size(myMpc.branch);
lossRatioTable(branchRaw+1,1)=zeros;    %��¼ɾ�ߺ�������ԭ����
for i=1:branchRaw
    myMpc.branch(i,11)=0;
    [result,success]=runpf(myMpc,mpopt);
    if success==1
        lossP=sum(abs(result.branch(:,14)+result.branch(:,16)));
        lossRatio=lossP/sum(result.gen(:,2));
        lossRatioTable(i)=lossRatio; 
    else
        lossRatioTable(i)=-1;
    end
    myMpc.branch(i,11)=1;
    
end
result=runpf(myMpc);
lossP=sum(result.branch(:,14)+result.branch(:,16));
lossRatio=lossP/sum(result.gen(:,2));
lossRatioTable(branchRaw+1)=lossRatio;

minDvalue(branchRaw)=zeros; %minDvalue��������ɾ�ߺ��������ԭ�����ֵ�ľ���ֵ
for j=1:branchRaw
    minDvalue(j)=abs(lossRatio-lossRatioTable(j));
end

[Y,U]=min(minDvalue);   %�ҳ���ֵ����Сֵ��U��¼��Ӧ���к�
Y=lossRatioTable(U);    %�ҳ���Ӧ��ԭ����


 