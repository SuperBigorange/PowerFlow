function mpc = case5My5

%% MATPOWER Case Format : Version 2
mpc.version = '2';

%%-----  Power Flow Data  -----%%
%% system MVA base
mpc.baseMVA = 100;

%% bus data
%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
mpc.bus = [
1	3	0	0	0	0	1	1.06	0	0	1	1.06	0.94    ;
2	1	-20	-20	0	0	1	1.06	-10	0	1	1.06	0.94	;
3	1	45	15	0	0	1	1.06	-10	0	1	1.06	0.94    ;
4	1	40	5	0	0	1	1.06	-10	0	1	1.06	0.94	;
5	1	60	10	0	0	1	1.06	-10	0	1	1.06	0.94	;

];

%% generator data
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
mpc.gen = [
	1	232.4	-16.9	10	0	1.06	100	1	332.4	0	0	0	0	0	0	0	0	0	0	0	0;
];

%% branch data
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
mpc.branch = [
1	2	0.02	0.06	0	0	0	0	0	0	1	-360	360	;
1	3	0.08	0.24	0	0	0	0	0	0	1	-360	360	;
2	3	0.06	0.18	0	0	0	0	0	0	1	-360	360	;
2	4	0.06	0.18	0	0	0	0	0	0	1	-360	360	;
3	4	0.01	0.03	0	0	0	0	0	0	1	-360	360	;
2	5	0.04	0.12	0	0	0	0	0	0	1	-360	360	;
4	5	0.08	0.24	0	0	0	0	0	0	1	-360	360	;
];

%%-----  OPF Data  -----%%
%% generator cost data
%	1	startup	shutdown	n	x1	y1	...	xn	yn
%	2	startup	shutdown	n	c(n-1)	...	c0
mpc.gencost = [
    2	0	0	3	0.0002	20	0;
];

%% bus names
mpc.bus_name = {
	'Bus 1     HV';
	'Bus 2     HV';
	'Bus 3     HV';
	'Bus 4     HV';
	'Bus 5     HV';
};
