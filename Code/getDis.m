function table=getDis(casedata)
%本函数用于获得案例的图上点关于平衡节点的拓补距离表
%table是返回表，casedata是传入案例

%预先处理
mpc = loadcase(casedata);       %获取案例
num3= find(mpc.bus(:,2)==3);    %找到平衡节点
name=mpc.bus(num3,1);           %平衡节点的序号
[num,~]=size(mpc.bus);            %一共的节点个数
table(:,1)=mpc.bus(:,1);        %table的第一列为所有节点序号
table(:,2)=0;                   %各点拓补距离先置零
table(num3,2)=-1;               %平衡节点自身距离置-1
branchVec=mpc.branch(:,1:2);    %取所有支路
%%
%广度优先搜索
count=num-1;                    %未定深度的节点数
temp=name;                      %本次迭代的节点参照
depth=1;
    while count~=0
        temp1=0;
        for i=1:length(branchVec)       %遍历所有支路
            for j=1:length(temp)
                if branchVec(i,1)==temp(j)
                    otherBusNum= table(:,1)==branchVec(i,2);    %另一个节点
                    if table(otherBusNum,2)==0                  %若节点深度未定，则找到其深度
                        count=count-1;
                        table(otherBusNum,2)=depth;             %更新深度
                        if temp1(1)==0
                            %下一迭代的第一个参照
                            temp1=table(otherBusNum,1);
                        else
                            %存为下一迭代参照
                            temp1(length(temp1)+1)=table(table(:,1)==branchVec(i,2),1);
                        end
                    end
                end
                if branchVec(i,2)==temp(j) 
                    otherBusNum= table(:,1)==branchVec(i,1);    %另一个节点
                    if table(otherBusNum,2)==0                  %若节点深度未定，则找到其深度
                        count=count-1;
                        table(otherBusNum,2)=depth;             %更新深度
                        if temp1(1)==0 
                             %下一迭代的第一个参照
                            temp1=table(otherBusNum,1);
                        else
                             %存为下一迭代参照
                            temp1(length(temp1)+1)=table(table(:,1)==branchVec(i,1),1);
                        end
                    end
                end
            end
        end
        depth=depth+1;      %进行下一深度搜索
        temp=temp1;         %本次找到的节点存为下次迭代的参照
    end
end
