function printDegree=getDegree(casedata)
%���������ڻ�ð���������ͼ�ϸ���Ķ�
%printDegree�Ƿ��ضȱ�casedata�Ǵ��밸��

%Ԥ����
myMpc=loadcase(casedata);                   %��ȡ����
[busRaw,~]=size(myMpc.bus);                 %�ڵ����
[branchRaw,~]=size(myMpc.branch);           %�ߵĸ���
printDegree(:,1)=myMpc.bus(:,1);            %������һ�������нڵ����
printDegree(busRaw,2)=zeros;                %�����������
number(myMpc.bus(busRaw,1),1)=zeros;         %��ʼ�����
%%
%���¸��ڵ����
for i=1:busRaw
    number(myMpc.bus(i,1))=i;
end

for j=1:branchRaw
        printDegree(number(myMpc.branch(j,1)),2)=printDegree(number(myMpc.branch(j,1)),2)+1;
        printDegree(number(myMpc.branch(j,2)),2)=printDegree(number(myMpc.branch(j,2)),2)+1;
end
