function [lossRatio,branchMFit,closestLossRatio,lossRatioTable] = randomValue(casedata,rmax,xmax)
%   本函数用于随机生成边的电阻和电抗，并计算线损随删边的变化
%   rmax为r电阻的上限
%   xmax为x的上限

mpopt = mpoption('pf.alg', 'NR', 'pf.tol', 1e-4,'pf.nr.max_it',20,'out.all',0);%定义迭代方式
success = 0;
mpc = loadcase(casedata);           %获取案例
[branchRaw,~]=size(mpc.branch);     %获得边数
while success == 0                  %success=0说明随机生成的矩阵不收敛，则继续迭代直到收敛
    value=rand(branchRaw,2);        %用均匀分布随机生成r,x的值
    %r,x的值乘上上限
    randValue(:,1)=rmax*value(:,1); 
    randValue(:,2)=xmax*value(:,2);
    mpc.branch(:,3:4)=randValue(:,1:2); %替换r,x的值
    [~, success]=runpf(mpc,mpopt);        %计算一次生成后的矩阵判断是否收敛
end
%生成矩阵收敛即可对该随机生成的矩阵进行遍历删边
[lossRatio,branchMFit,closestLossRatio,lossRatioTable]=delSide(mpc);
end


