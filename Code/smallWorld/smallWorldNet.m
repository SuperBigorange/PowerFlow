function [branchTable,branchMFit,degreeTable,disTable,matrix] = smallWorldNet(casedata,neighbNum,p,Rm,Xm)
%   ������ʹ��NWС����ģ��������ɵ���С����ͼ
%   casedata�����밸��,������ڵ����ͺ�P��Qֵ
%   neighbNum�ǳ�ʼÿ���ڵ����������ٽ���neighbNum���ڵ�����neighbNum����
%   p����������ɱߵĸ���
%   Rm��R�迹�ĵ����ֵ
%   Xm��X��е����ֵ
%   matrix�����ɵ�С��������Ĺ�������
%   lossRatioTable������ɾ���㷨��������

myMpc=loadcase(casedata);                   %��ȡ����
[N,~]=size(myMpc.bus);                      %��ȡ�ڵ���
matrix = zeros(N,N);                        %��ʼ����������
%������ɱ߾���
R = rand(N,N)*Rm;
X = rand(N,N)*Xm;

%ȷ����Щ�ط���Ҫ��ֵ
for i=neighbNum+1:N-neighbNum
    matrix(i,i- neighbNum:i+neighbNum)=1;
end

for i=1:neighbNum
    matrix(i,1:i+neighbNum)=1;
end

for i=N- neighbNum+1:N
    matrix(i,i- neighbNum:N)=1;
end

for i=1:neighbNum
    matrix(i,N- neighbNum+i:N)=1;
    matrix(N- neighbNum+i:N,i)=1;
end

k=(rand(N)<p);
kk=tril(k,-1);
kkk=triu(k',0);
kkkk=kkk+kk;
for i=1:N
    kkkk(i,i)=0;
end

% Random add edge
matrix = logical(matrix + kkkk);
matrix = matrix -diag(diag(matrix));
count=0;
for i=1:N
    for j=1:N
        count=count+matrix(i,j);
    end
end
count=count/2;      
last=zeros(count,4); %����Ľ��
ah=1;
for i=1:N
    for j=i+1:N
        if matrix(i,j)==1
            last(ah,1)=i;
            last(ah,2)=j;
            last(ah,3)=R(i,j);
            last(ah,4)=X(i,j);
            ah=ah+1;
        end
    end
end
[mRaw,~]=size(last);
myMpc.branch=zeros(mRaw,13);
myMpc.branch(:,13)=360;
myMpc.branch(:,12)=-360;
myMpc.branch(:,11)=1;
myMpc.branch(:,1:4)=last;
branchTable=myMpc.branch(:,1:2);
degreeTable=getDegree(myMpc);
disTable=getDis(myMpc);
[~,branchMFit,~,~]=delSide(myMpc);
