function [lossRatio,branchMFit,closestLossRatio,lossRatioTable]=delSide(casedata)
%本函数用于计算删去一条边后（图仍保持连通）的线损
%casedata是输入案例，lossRatio是原线损，branchMFit是删去后对线损影响最小的边号
%closestLossRatio是删去后影响最小的线损大小，lossRatioTable是删去各边的线损表，最后一个元素是原线损

%计算删一条边后
mpopt = mpoption('pf.alg', 'NR', 'pf.tol', 1e-4,'pf.nr.max_it',20,'out.all',0);%定义迭代方式
myMpc = loadcase(casedata);             %获取案例
[branchRaw,~]=size(myMpc.branch);       %获得支路数
lossRatioTable(branchRaw+1,1)=zeros;    %记录删边后的线损和原线损
for i=1:branchRaw
    myMpc.branch(i,11)=0;               %把这条支路关掉
    [result,success]=runpf(myMpc,mpopt);%应用潮流算法
    if success==1                       %若删去后图仍连通
        lossP=sum(abs(result.branch(:,14)+result.branch(:,16)));%计算线损
        lossRatio=lossP/sum(result.gen(:,2)); 
        lossRatioTable(i)=lossRatio;    %记录到表上
    else
        lossRatioTable(i)=-1;           %待更改！不连通时仅仅赋-1，这么做不严谨
    end
    myMpc.branch(i,11)=1;               %把这条支路重新打开
end
%%
%计算原线损
result=runpf(myMpc,mpopt);
lossP=sum(result.branch(:,14)+result.branch(:,16));
lossRatio=lossP/sum(result.gen(:,2));
lossRatioTable(branchRaw+1)=lossRatio;  %在表后附上原线损

minDvalue(branchRaw)=zeros; %minDvalue矩阵存的是删边后的线损与原线损差值的绝对值
for j=1:branchRaw
    minDvalue(j)=abs(lossRatio-lossRatioTable(j));
end

[~,branchMFit]=min(minDvalue);   %找出差值的最小值，branchMFit记录相应的行号
closestLossRatio=lossRatioTable(branchMFit);    %找出对应的原线损


 