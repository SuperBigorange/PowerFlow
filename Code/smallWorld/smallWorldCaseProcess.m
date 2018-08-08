function [ calTable ] = smallWorldCaseProcess( nodeNum,neighbNum,p,Pmax,Qmax,Rm,Xm )
%SMALLWORLDPROCESS1 此处显示有关此函数的摘要
%   此处显示详细说明
calTable=[];
for i=1:1
    mpc = smallWorldCase(nodeNum,neighbNum,p,Pmax,Qmax,Rm,Xm);
    [lossRatio,branchMFit,closestLossRatio,lossRatioTable]=delSide(mpc);
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

