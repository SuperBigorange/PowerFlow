function [lossRatio,branchMFit,closestLossRatio,lossRatioTable] = randomValue(casedata,rmax,xmax)
%   ����������������ɱߵĵ���͵翹��������������ɾ�ߵı仯
%   rmaxΪr���������
%   xmaxΪx������

mpopt = mpoption('pf.alg', 'NR', 'pf.tol', 1e-4,'pf.nr.max_it',20,'out.all',0);%���������ʽ
success = 0;
mpc = loadcase(casedata);           %��ȡ����
[branchRaw,~]=size(mpc.branch);     %��ñ���
while success == 0                  %success=0˵��������ɵľ������������������ֱ������
    value=rand(branchRaw,2);        %�þ��ȷֲ��������r,x��ֵ
    %r,x��ֵ��������
    randValue(:,1)=rmax*value(:,1); 
    randValue(:,2)=xmax*value(:,2);
    mpc.branch(:,3:4)=randValue(:,1:2); %�滻r,x��ֵ
    [~, success]=runpf(mpc,mpopt);        %����һ�����ɺ�ľ����ж��Ƿ�����
end
%���ɾ����������ɶԸ�������ɵľ�����б���ɾ��
[lossRatio,branchMFit,closestLossRatio,lossRatioTable]=delSide(mpc);
end


