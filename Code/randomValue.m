function [lossRatio,U,Y] = randomValue(casedata,m,n)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%   mΪr������
%   nΪx������
success = 0;
myMpc = loadcase(casedata);
mpc=myMpc;
[branchRaw,branchCol]=size(myMpc.branch); %#ok<ASGLU>
while success == 0  %success=0˵��������ɵľ������������������ֱ������
    value=rand(branchRaw,2);        %�������r,x��ֵ
    randValue(:,1)=m*value(:,1);    %r,x��ֵ��������
    randValue(:,2)=n*value(:,2);
    mpc.branch(:,3)=randValue(:,1);     %�滻r,x��ֵ
    mpc.branch(:,4)=randValue(:,2);
    [~, success]=runpf(mpc);        %����һ�����ɺ�ľ����ж��Ƿ�����
end
[lossRatio,U,Y]=delSide(mpc);       %���ɾ����������ɶԸ�������ɵľ�����б���ɾ��
end


