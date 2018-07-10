function table=getDis(casedata)
%���������ڻ�ð�����ͼ�ϵ����ƽ��ڵ���ز������
%table�Ƿ��ر�casedata�Ǵ��밸��

%Ԥ�ȴ���
mpc = loadcase(casedata);       %��ȡ����
num3= find(mpc.bus(:,2)==3);    %�ҵ�ƽ��ڵ�
name=mpc.bus(num3,1);           %ƽ��ڵ�����
[num,~]=size(mpc.bus);            %һ���Ľڵ����
table(:,1)=mpc.bus(:,1);        %table�ĵ�һ��Ϊ���нڵ����
table(:,2)=0;                   %�����ز�����������
table(num3,2)=-1;               %ƽ��ڵ����������-1
branchVec=mpc.branch(:,1:2);    %ȡ����֧·
%%
%�����������
count=num-1;                    %δ����ȵĽڵ���
temp=name;                      %���ε����Ľڵ����
depth=1;
    while count~=0
        temp1=0;
        for i=1:length(branchVec)       %��������֧·
            for j=1:length(temp)
                if branchVec(i,1)==temp(j)
                    otherBusNum= table(:,1)==branchVec(i,2);    %��һ���ڵ�
                    if table(otherBusNum,2)==0                  %���ڵ����δ�������ҵ������
                        count=count-1;
                        table(otherBusNum,2)=depth;             %�������
                        if temp1(1)==0
                            %��һ�����ĵ�һ������
                            temp1=table(otherBusNum,1);
                        else
                            %��Ϊ��һ��������
                            temp1(length(temp1)+1)=table(table(:,1)==branchVec(i,2),1);
                        end
                    end
                end
                if branchVec(i,2)==temp(j) 
                    otherBusNum= table(:,1)==branchVec(i,1);    %��һ���ڵ�
                    if table(otherBusNum,2)==0                  %���ڵ����δ�������ҵ������
                        count=count-1;
                        table(otherBusNum,2)=depth;             %�������
                        if temp1(1)==0 
                             %��һ�����ĵ�һ������
                            temp1=table(otherBusNum,1);
                        else
                             %��Ϊ��һ��������
                            temp1(length(temp1)+1)=table(table(:,1)==branchVec(i,1),1);
                        end
                    end
                end
            end
        end
        depth=depth+1;      %������һ�������
        temp=temp1;         %�����ҵ��Ľڵ��Ϊ�´ε����Ĳ���
    end
end
