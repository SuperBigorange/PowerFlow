function [ calTable ] = smallWorldCaseProcess( nodeNum,neighbNum,p,Pmax,Qmax,Rm,Xm,n)
%	此函数对生成的小世界网络进行删边处理
%   nodeNum是总节点个数，neighbNum是初始临近节点个数
%   p是随机加边概率，Pmax，Qmax为随机生成P,Q的最大值
%   rmax，xmax为随机生成的r，x最大值,n是迭代次数

calTable=zeros(n,6);
for i=1:n
    mpc = smallWorldCase(nodeNum,neighbNum,p,Pmax,Qmax,Rm,Xm);
    [~,branchMFit,~,~]=delSide(mpc);
    degreeTable=getDegree(mpc);
    calTable(i,1)=degreeTable(degreeTable(:,1)==mpc.branch(branchMFit,1),2);
    calTable(i,2)=degreeTable(degreeTable(:,1)==mpc.branch(branchMFit,2),2);
    disTable=getDis(mpc);
    calTable(i,3)=disTable(disTable(:,1)==mpc.branch(branchMFit,1),2);
    calTable(i,4)=disTable(disTable(:,1)==mpc.branch(branchMFit,2),2);    
    [degreeMax,~]=max(max(degreeTable(:,2)));
    [disMax,~]=max(max(disTable(:,2)));
    calTable(i,5)=degreeMax;
    calTable(i,6)=disMax;
end
    xlswrite('.\smallWorld\analysis',calTable,'test','A1');

end

