function mpc = smallWorldCase(nodeNum,neighbNum,p,Pmax,Qmax,Rm,Xm)
%此函数用于生成自主生成的小时借网络
%nodeNum为网络中节点个数，neighNum为小世界网络的最近邻个数
%p为随机重连概率，Pmax，Qmax为随机生成P,Q的最大值
%rmax，xmax为随机生成的r，x最大值
%% MATPOWER Case Format : Version 2
mpc.version = '2';

%%-----  Power Flow Data  -----%%
%% system MVA base
mpc.baseMVA = 100;

%% bus data
%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
mpc.bus=zeros(nodeNum,13);
mpc.bus(:,13)=0.94;
mpc.bus(:,12)=1.06;
mpc.bus(:,11)=1;
mpc.bus(:,10)=0;
mpc.bus(:,9)=-10*rand(nodeNum,1);
mpc.bus(:,8)=1;
mpc.bus(:,7)=1;
mpc.bus(:,1)=1:nodeNum;
mpc.bus(1,2)=3;
for i=2:nodeNum
    if rand<=0.5 
        mpc.bus(i,2)=2;
    else
        mpc.bus(i,2)=1;
    end
end
mpc.bus(2:nodeNum,3)=Pmax*rand(nodeNum-1,1);
mpc.bus(2:nodeNum,4)=Qmax*rand(nodeNum-1,1);

%% generator data
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
mpc.gen = [
	1	0	0	Qmax*nodeNum	-Qmax*nodeNum	1	0	1	Pmax*nodeNum	0	0	0	0	0	0	0	0	0	0	0	0;
];

%%  branch data
N=nodeNum;
matrix = zeros(N,N);                        %初始化关联矩阵
%随机生成边矩阵
R = rand(N,N)*Rm;
X = rand(N,N)*Xm;

%确定哪些地方需要赋值
for i=neighbNum+1:N-neighbNum
    matrix(i,i- neighbNum:i+neighbNum)=1;
end

for i=1:neighbNum
    matrix(i,1:i+neighbNum)=1;
end

for i=N- neighbNum+1:N
    matrix(i,i- neighbNum:N)=1;
end

for i=1:neighbNum
    matrix(i,N- neighbNum+i:N)=1;
    matrix(N- neighbNum+i:N,i)=1;
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
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
[mRaw,~]=size(last);
mpc.branch=zeros(mRaw,13);
mpc.branch(:,13)=360;
mpc.branch(:,12)=-360;
mpc.branch(:,11)=1;
mpc.branch(:,1:4)=last;
%%-----  OPF Data  -----%%
%% generator cost data
%	1	startup	shutdown	n	x1	y1	...	xn	yn
%	2	startup	shutdown	n	c(n-1)	...	c0
mpc.gencost = [
	2	0	0	2	14	0;
];
