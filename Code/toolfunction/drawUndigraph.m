function [] = drawUndigraph( matrix )
%��������ͼ���ڽӾ��󣬻�ͼ
view(biograph(tril(matrix),[],'ShowArrows','off','ShowWeights','on'))
end

