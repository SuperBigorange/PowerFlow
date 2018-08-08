function [branchTable,branchMFit,degreeTable,disTable,matrix] = smallWorldNet(casedata,neighbNum,p,Rm,Xm)
%   本函数使用NW小世界模型随机生成电网小世界图
%   casedata是输入案例,沿用其节点类型和P、Q值
%   neighbNum是初始每个节点向与它最临近的neighbNum个节点连出neighbNum条边
%   p是随机化生成边的概率
%   Rm是R阻抗的的最大值
%   Xm是X电感的最大值
%   matrix是生成的小世界网络的关联矩阵
%   lossRatioTable是运行删边算法后的线损表

myMpc=loadcase(casedata);                   %获取案例
[N,~]=size(myMpc.bus);                      %获取节点数
matrix = zeros(N,N);                        %初始化关联矩阵
%随机生成边矩阵
R = rand(N,N)*Rm;
X = rand(N,N)*Xm;

%确定哪些地方需要赋值
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
last=zeros(count,4); %输出的结果
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
