function [lossRatio,U,Y] = randomValue(casedata,m,n)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
success = 0;
myMpc = loadcase(casedata);
mpc=myMpc;
[branchRaw,branchCol]=size(myMpc.branch); %#ok<ASGLU>
while success == 0
    value=rand(branchRaw,2);
    randValue(:,1)=m*value(:,1);
    randValue(:,2)=n*value(:,2);
    mpc.branch(:,3)=randValue(:,1);
    mpc.branch(:,4)=randValue(:,2);
    [result, success]=runpf(mpc);
end
result%#ok<NOPRT>;
[lossRatio,U,Y]=delSide(mpc)
end


