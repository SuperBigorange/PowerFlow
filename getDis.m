function table=getDis(casedata)
mpc = loadcase(casedata);
num3= find(mpc.bus(:,2)==3);
name=mpc.bus(num3,1);
num=length(mpc.bus);
table(:,1)=mpc.bus(:,1);
table(:,2)=0;
table(num3,2)=-1;
count=num-1;
branchVec=mpc.branch(:,1:2);
temp=name;
depth=1;
    while count~=0
        temp1=0;
        for i=1:length(branchVec)
            for j=1:length(temp)
                if branchVec(i,1)==temp(j) 
                    otherBusNum= table(:,1)==branchVec(i,2);
                    if table(otherBusNum,2)==0
                        count=count-1;
                        table(otherBusNum,2)=depth;
                        if temp1(1)==0 
                            temp1=table(otherBusNum,1);
                        else
                            temp1(length(temp1)+1)=table(table(:,1)==branchVec(i,2),1);
                        end
                    end
                end
                if branchVec(i,2)==temp(j) 
                    otherBusNum= table(:,1)==branchVec(i,1);
                    if table(otherBusNum,2)==0
                        count=count-1;
                        table(otherBusNum,2)=depth;
                        if temp1(1)==0 
                            temp1=table(otherBusNum,1);
                        else
                            temp1(length(temp1)+1)=table(table(:,1)==branchVec(i,1),1);
                        end
                    end
                end
            end
        end
        depth=depth+1;
        temp=temp1;
    end
end
