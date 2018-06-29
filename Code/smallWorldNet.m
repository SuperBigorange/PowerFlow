function result = smallWorldNet(casedata,N,m,p,Rm,Xm)
matrix = zeros(N,N);
r = rand(N,N)*Rm;
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
k=(rand(N)<p);
kk=tril(k,-1);
kkk=triu(k',0);
kkkk=kkk+kk;
for i=1:N
    kkkk(i,i)=0;
end
% Random add edge
matrix = logical(matrix + kkkk);
matrix = matrix -diag(diag(matrix));
count=0;
for i=1:N
    for j=1:N
        count=count+matrix(i,j);
    end
end
count=count/2;
last=zeros(count,4);
ah=1;
for i=1:N
    for j=i+1:N
        if matrix(i,j)==1
            last(ah,1)=i;
            last(ah,2)=j;
            last(ah,3)=r(i,j);
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

    
