function [lossRatio,U,Y] = randomValue(casedata,m,n)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
%   m为r的上限
%   n为x的上限
success = 0;
myMpc = loadcase(casedata);
mpc=myMpc;
[branchRaw,branchCol]=size(myMpc.branch); %#ok<ASGLU>
while success == 0  %success=0说明随机生成的矩阵不收敛，则继续迭代直到收敛
    value=rand(branchRaw,2);        %随机生成r,x的值
    randValue(:,1)=m*value(:,1);    %r,x的值乘上上限
    randValue(:,2)=n*value(:,2);
    mpc.branch(:,3)=randValue(:,1);     %替换r,x的值
    mpc.branch(:,4)=randValue(:,2);
    [~, success]=runpf(mpc);        %计算一次生成后的矩阵判断是否收敛
end
[lossRatio,U,Y]=delSide(mpc);       %生成矩阵收敛即可对该随机生成的矩阵进行遍历删边
end


