function W = randInitializeWeights(L_in, L_out, seed)
%randInitializeWeights Randomly initialize the weights of a layer with L_in
%incoming connections and L_out outgoing connections
%   W = randInitializeWeights(L_in, L_out, seed) randomly initializes the weights 
%   of a layer with L_in incoming connections and L_out outgoing 
%   connections. If seed is provided, rand's seed will be set to it.
%
%   Note that W should be set to a matrix of size(L_out, 1 + L_in) as
%   the first column of W handles the "bias" terms
%
if exist('seed', 'var')
    fprintf('\nrand seed=%f', seed);
    rand("seed", seed);
end
% You need to return the following variables correctly 
W = zeros(L_out, 1 + L_in);


% ====================== YOUR CODE HERE ======================
% Initialize W randomly with values in range [-epsilon, epsilon]
epsilon_init = sqrt(6) / sqrt(L_in + L_out);
W = rand(L_out, 1 + L_in) * 2 * epsilon_init - epsilon_init;
% =========================================================================

end
