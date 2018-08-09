function [ calTable ] = smallWorldCaseProcess( nodeNum,neighbNum,p,Pmax,Qmax,Rm,Xm,n)
%	�˺��������ɵ�С�����������ɾ�ߴ���
%   nodeNum���ܽڵ������neighbNum�ǳ�ʼ�ٽ��ڵ����
%   p������ӱ߸��ʣ�Pmax��QmaxΪ�������P,Q�����ֵ
%   rmax��xmaxΪ������ɵ�r��x���ֵ,n�ǵ�������

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

