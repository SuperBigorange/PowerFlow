function [] = drawUndigraph( matrix )
view(biograph(tril(matrix),[],'ShowArrows','off','ShowWeights','on'))
end

