function [ calTable ] = arterialProcess( nodeNum,Pmax,Qmax,rmax,xmax,calNum )
%ARTERIALPROCESS 此处显示有关此函数的摘要
%   此处显示详细说明
mpc=arterialCase(nodeNum,Pmax,Qmax,rmax,xmax);
[lossRatioTable,~]=delNode(mpc);
calTable=zeros(size(lossRatioTable,1),3);
calTable(:,1)=lossRatioTable(:,1);
i=0;
while i<calNum
    mpc=arterialCase(nodeNum,Pmax,Qmax,rmax,xmax);
    [lossRatioTable,success]=delNode(mpc);
    if success==1
        i=i+1;
        [num , deviation] = findClost( lossRatioTable(:,2) , -1 );
        calTable(num,2)=calTable(num,2)+1;
        if calTable(num,3)==0
            calTable(num,3)=deviation;
            
        else
            calTable(num,3)=(calTable(num,3)*(calTable(num,2)-1)+deviation)/calTable(num,2);
        end
    end
end


