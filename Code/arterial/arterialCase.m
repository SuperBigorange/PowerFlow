function mpc = arterialCase(nodeNum,Pmax,Qmax,rmax,xmax)
%本函数生成干线式案例
%nodeNum表示所有节点个数，默认干线节点外联1个节点枝干
%Pmax，Qmax为随机生成P,Q的最大值
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
mpc.bus(:,10)=230;
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

%% branch data
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
mpc.branch=zeros(nodeNum-1,13);
branchNode=floor((nodeNum-1)/2);
arterialNode=nodeNum-branchNode;
mpc.branch(:,13)=360;
mpc.branch(:,12)=-360;
mpc.branch(:,11)=1;
mpc.branch(:,3:4)=[rmax*rand(nodeNum-1,1),xmax*rand(nodeNum-1,1)];
mpc.branch(1:arterialNode-1,1)=1:arterialNode-1;
mpc.branch(1:arterialNode-1,2)=2:arterialNode;
mpc.branch(arterialNode:nodeNum-1,1)=arterialNode+1:nodeNum;
mpc.branch(arterialNode:nodeNum-1,2)=2:nodeNum-arterialNode+1;

%%-----  OPF Data  -----%%
%% generator cost data
%	1	startup	shutdown	n	x1	y1	...	xn	yn
%	2	startup	shutdown	n	c(n-1)	...	c0
mpc.gencost = [
	2	0	0	2	14	0;

];
