function result = smallWorldNet(casedata,N,m,p,Rm,Xm)
matrix = zeros(N,N);%
R = rand(N,N)*Rm;
X = rand(N,N)*Xm;
for i=m+1:N- m
    matrix(i,i- m:i+m)=1;
end
for i=1:m
    matrix(i,1:i+m)=1;
end
for i=N- m+1:N
    matrix(i,i- m:N)=1;
end
for i=1:m
    matrix(i,N- m+i:N)=1;
    matrix(N- m+i:N,i)=1;
end
kk=tril((rand(N)<p),-1)+triu((rand(N)<p)',0);
for i=1:N
    kk(i,i)=0;
end
% Random add edge
matrix = logical(matrix + kk);
matrix = matrix -diag(diag(matrix));
count=0;
for i=1:N
    for j=1:N
        count=count+matrix(i,j);
    end
end
count=count/2;      
last=zeros(count,4); %输出的结果
ah=1;
for i=1:N
    for j=i+1:N
        if matrix(i,j)==1
            last(ah,1)=i;
            last(ah,2)=j;
            last(ah,3)=R(i,j);
            last(ah,4)=X(i,j);
            ah=ah+1;
        end
    end
end
myMpc=loadcase(casedata);
[mRaw,mCol]=size(last);
myMpc.branch=zeros(mRaw,13);
myMpc.branch(:,13)=360;
myMpc.branch(:,12)=-360;
myMpc.branch(:,11)=1;
myMpc.branch(:,1:4)=last;
myMpc.branch
result=delSide(myMpc);

    
