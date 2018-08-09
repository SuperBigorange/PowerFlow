function [] = drawUndigraph( matrix )
%输入无向图的邻接矩阵，画图
view(biograph(tril(matrix),[],'ShowArrows','off','ShowWeights','on'))
end

